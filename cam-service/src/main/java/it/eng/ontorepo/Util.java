package it.eng.ontorepo;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.regex.Pattern;

import javax.xml.bind.DatatypeConverter;

/**
 * Collection of utility methods of general interest.
 * 
 * @author Mauro Isaja mauro.isaja@eng.it
 *
 */
public class Util {

	public static final String NS_SEP = ":";
	public static final String PATH_TERM = "#";
	public static final int MIN_NAME_LENGTH = 1;
	public static final int MAX_NAME_LENGTH = 255;
	
	private static final Pattern namePattern;
	private static final Class<?>[] SUPPORTED_DATATYPES =
		{
			String.class,
			Integer.class,
			Long.class,
			Short.class,
			BigDecimal.class,
			Double.class,
			Float.class,
			Calendar.class,
			Boolean.class
		};
	
	
	static {
		// this is the main rule for name validity: names can be made of
		// letters, either uppercase or lowercase, numbers and the "_" and "-"
		// characters, in no particular order; note that also a constraint
		// on length is enforced: see MIN_NAME_LENGTH and MAX_NAME_LENGTH
		namePattern = Pattern.compile("[a-zA-Z_0-9\\-]*");
	}
	
	/**
	 * Cannot be instantiated
	 */
	private Util() {}

	/**
	 * Given a namespace and a name, returns the concatenation of the two if name
	 * is not null or empty and it's unqualified (i.e., it is not already prepended
	 * by a namespace); otherwise returns the name unchanged.
	 * @param namespace
	 * @param name
	 * @return
	 */
	public static String getGlobalName(String namespace, String name) {
		return isLocalName(name) ? namespace + name : name; 
	}
	
	/**
	 * Given a namespace and a name, if the name is relative to the namespace
	 * returns the name stripped of the namespace; otherwise it returns the
	 * name unchanged.
	 * @param namespace
	 * @param name
	 * @return
	 */
	public static String getLocalName(String namespace, String name) {
		if (null != name && name.startsWith(namespace)) {
			name = name.substring(namespace.length());
		}
		return name;
	}
	
	/**
	 * Returns true is the given name is not qualified by a namespace.
	 * @param name
	 * @return
	 */
	public static boolean isLocalName(String name) {
		if (null == name || name.trim().length() == 0) return false;
		return !name.contains(NS_SEP) && !name.contains(PATH_TERM);
	}
	
	/**
	 * Returns true if the given name is valid as a local name, according
	 * to the specific restrictions imposed by this implementation.
	 * @param name
	 * @return
	 */
	public static boolean isValidLocalName(String name) {
		if (isLocalName(name)) {
			if (name.length() >= MIN_NAME_LENGTH && name.length() <= MAX_NAME_LENGTH) {
				return namePattern.matcher(name).matches();
			}
		}
		return false;
	}
	
	/**
	 * Returns true if the given type is a legal type for an Attribute declaration.
	 * @param type
	 * @return
	 */
	public static boolean isSupportedType(Class<?> type) {
		if (null == type) 
			return false;
		for (int i = 0; i < SUPPORTED_DATATYPES.length; i++) {
			if (SUPPORTED_DATATYPES[i] == type)
				return true;
		}
		return false;
	}
	
	/**
	 * Given a Calendar instance, returns its String representation 
	 * according to XSD standards. If the given value is <code>null</code>,
	 * returns the empty string.
	 * @param date
	 * @return
	 */
	public static String getDateTimeRepresentation(Calendar date) {
		return null != date ? DatatypeConverter.printDateTime(date) : "";
	}
	
	/**
	 * Given a string value and a Java type, returns true if the given
	 * value is a legal assignment to an Attribute having the given Java type.
	 * <code>null</code> or empty values are always legal.
	 * @param value
	 * @param type
	 * @return
	 */
	public static boolean isValidValue(String value, Class<?> type) {
		if (null == value || value.length() == 0)
			return true; // missing values are always legal
		if (String.class == type) {
			return true; // string values are always legal (opaque strings)
		} else if (Integer.class == type) {
			try {
				DatatypeConverter.parseInteger(value);
				return true;
			} catch (NumberFormatException e) {	}
		} else if (Long.class == type) {
			try {
				DatatypeConverter.parseLong(value);
				return true;
			} catch (NumberFormatException e) {	}
		} else if (Short.class == type) {
			try {
				DatatypeConverter.parseShort(value);
				return true;
			} catch (NumberFormatException e) {	}
		} else if (BigDecimal.class == type) {
			try {
				DatatypeConverter.parseDecimal(value);
				return true;
			} catch (NumberFormatException e) {	}
		} else if (Double.class == type) {
			try {
				DatatypeConverter.parseDouble(value);
				return true;
			} catch (NumberFormatException e) {	}
		} else if (Float.class == type) {
			try {
				DatatypeConverter.parseFloat(value);
				return true;
			} catch (NumberFormatException e) {	}
		} else if (Calendar.class == type) {
			try {
				DatatypeConverter.parseDateTime(value);
				return true;
			} catch (IllegalArgumentException e) {
				try {
					DatatypeConverter.parseDate(value);
					return true;
				} catch (IllegalArgumentException e1) {}
			}
		} else if (Boolean.class == type) {
			try {
				DatatypeConverter.parseBoolean(value);
				return true;
			} catch (IllegalArgumentException e) {	}
		} else {
			throw new IllegalArgumentException("Unsupported type: " + type); 
		}
		return false;
	}
}
