package it.eng.ontorepo;

import java.math.BigDecimal;
import java.util.Calendar;

import org.openrdf.model.vocabulary.OWL;
import org.openrdf.model.vocabulary.XMLSchema;

/**
 * DTO representing the declaration of an Object Property
 * or of a Datatype Property. Only the Name and a single Range
 * are supported. In particular, the <code>Domain</code>,
 * <code>FunctionalProperty</code> and <code>inverseOf</code>
 * ontology concepts are <i>not</i> supported; if multiple Range
 * declarations exist, only the first one is considered, while the
 * others are silently discarded. 
 * <p />
 * Only a subset of the possible range assertions are supported;
 * for those, a mapping with the Java language is also provided
 * by this class, when useful (see {@link #getPropertyType()}).
 * In the following table, all supported ranges are listed
 * together with their corresponding Java type. Note that for
 * Object Properties no type mapping is done: any range is acceptable,
 * and is treated as an opaque string.
 * <table>
 *   <tr>
 *     <td><b>Assertion</b></td>
 *     <td><b>Range</b></td>
 *     <td><b>Java Type</b></td>
 *   </tr>
 *   <tr>
 *     <td><code>ObjectProperty</code></td>
 *     <td>(any)</td>
 *     <td><code>java.lang.Object</code></td>
 *   </tr>
 *   <tr>
 *     <td><code>DatatypeProperty</code></td>
 *     <td>(no range)</td>
 *     <td><code>java.lang.String</code></td>
 *   </tr>
 *   <tr>
 *     <td><code>DatatypeProperty</code></td>
 *     <td>
 *       <code>http://www.w3.org/2001/XMLSchema#string</code>
 *     </td>
 *     <td><code>java.lang.String</code></td>
 *   </tr>
 *   <tr>
 *     <td><code>DatatypeProperty</code></td>
 *     <td>
 *       <code>http://www.w3.org/2001/XMLSchema#int</code><br />
 *       <code>http://www.w3.org/2001/XMLSchema#integer</code><br />
 *     </td>
 *     <td><code>java.lang.Integer</code></td>
 *   </tr>
 *   <tr>
 *     <td><code>DatatypeProperty</code></td>
 *     <td>
 *       <code>http://www.w3.org/2001/XMLSchema#long</code><br />
 *     </td>
 *     <td><code>java.lang.Long</code></td>
 *   </tr>
 *   <tr>
 *     <td><code>DatatypeProperty</code></td>
 *     <td>
 *       <code>http://www.w3.org/2001/XMLSchema#short</code><br />
 *     </td>
 *     <td><code>java.lang.Short</code></td>
 *   </tr>
 *   <tr>
 *     <td><code>DatatypeProperty</code></td>
 *     <td>
 *       <code>http://www.w3.org/2001/XMLSchema#decimal</code>
 *     </td>
 *     <td><code>java.math.BigDecimal</code></td>
 *   </tr>
 *   <tr>
 *     <td><code>DatatypeProperty</code></td>
 *     <td>
 *       <code>http://www.w3.org/2001/XMLSchema#double</code>
 *     </td>
 *     <td><code>java.lang.Double</code></td>
 *   </tr>
 *   <tr>
 *     <td><code>DatatypeProperty</code></td>
 *     <td>
 *       <code>http://www.w3.org/2001/XMLSchema#float</code>
 *     </td>
 *     <td><code>java.lang.Float</code></td>
 *   </tr>
 *   <tr>
 *     <td><code>DatatypeProperty</code></td>
 *     <td>
 *       <code>http://www.w3.org/2001/XMLSchema#date</code><br />
 *       <code>http://www.w3.org/2001/XMLSchema#dateTime</code>
 *     </td>
 *     <td><code>java.util.Calendar</code></td>
 *   </tr>
 *   <tr>
 *     <td><code>DatatypeProperty</code></td>
 *     <td>
 *       <code>http://www.w3.org/2001/XMLSchema#boolean</code>
 *     </td>
 *     <td><code>java.lang.Boolean</code></td>
 *   </tr>
 * </table>
 * 
 * @author Mauro Isaja mauro.isaja@eng.it
 *
 */
public class PropertyDeclarationItem extends Tuple {
	
	private final Class<?> type;
	private final String range;

	/**
	 * Initialize a new instance with its own Name, Assertion Type and Range.
	 * @param namespace the implicit namespace of the Reference Ontology (mandatory)
	 * @param name full URI which identifies the Property (mandatory)
	 * @param type OWL type of the assertion - either owl:DatatypeProperty or owl:ObjectProperty (mandatory)
	 * @param range full URI which identifies a standard XSD type (optional)
	 */
	public PropertyDeclarationItem(String namespace, String name, String type, String range) {
		super(namespace, name, type);
		this.range = range; // can be null or empty
		if (OWL.OBJECTPROPERTY.stringValue().equals(type)) {
			// object property: range is meaningless in the Java type system
			this.type = Object.class;
		} else if (OWL.DATATYPEPROPERTY.stringValue().equals(type)) {
			// data property: we try to match the range with a Java type
			// NOTE: only properties with a single range statement are supported
			if (null != range && !range.isEmpty()) {
				// a range statement exists
				if (XMLSchema.STRING.stringValue().equals(range)) {
					this.type = String.class;
				} else if (XMLSchema.INT.stringValue().equals(range) ||
						XMLSchema.INTEGER.stringValue().equals(range)) {
					this.type = Integer.class;
				} else if (XMLSchema.LONG.stringValue().equals(range)) {
					this.type = Long.class;
				} else if (XMLSchema.SHORT.stringValue().equals(range)) {
					this.type = Short.class;
				} else if (XMLSchema.DECIMAL.stringValue().equals(range)) {
					this.type = BigDecimal.class;
				} else if (XMLSchema.DOUBLE.stringValue().equals(range)) {
					this.type = Double.class;
				} else if (XMLSchema.FLOAT.stringValue().equals(range)) {
					this.type = Float.class;
				} else if (XMLSchema.DATE.stringValue().equals(range) ||
						XMLSchema.DATETIME.stringValue().equals(range)) {
					this.type = Calendar.class;
				} else if (XMLSchema.BOOLEAN.stringValue().equals(range)) {
					this.type = Boolean.class;
				} else {
					throw new IllegalArgumentException("Unsupported range: " + range); 
				}
			} else {
				// if range is not specified, it defaults to String for data properties
				this.type = String.class;
			}
		} else {
			// this is a programming error
			throw new IllegalArgumentException("Unsupported property type: " + type);
		}
	}

	/**
	 * Returns the <i>local</i> Name of the Property: the implicit namespace,
	 * if is part of the full URI, is stripped from the result. URIs which do not
	 * contain a reference to the implicit namespace are left unchanged.
	 * <p />
	 * To obtain the original full URI, use {@link Tuple#getOriginalName()}.
	 * @return
	 */
	public String getPropertyName() {
		return getNormalizedName();
	}

	/**
	 * Returns the type of the Property as a Java Class. Object Properties are
	 * always of type <code>java.lang.Object</code>, while Datatype Properties
	 * have types which depend on the declared range, if any: the default is
	 * <code>java.lang.String</code>, and the most typical alternatives are
	 * <code>java.lang.Integer</code> and <code>java.lang.Boolean</code>.
	 * For a full list of supported ranges and their equivalent Java Class,
	 * see class-level comments.
	 * @return
	 */
	public Class<?> getPropertyType() {
		return type;
	}
	
	/**
	 * Returns the range of the Property, as declared in the Reference Ontology.
	 * Range is an optional assertion, so this value can be <code>null</code>.
	 * When no range is declared, the type of a Datatype Property (see
	 * {@link #getPropertyType()}) defaults to <code>java.lang.String</code>,
	 * while Object Properties are always of <code>java.lang.Object</code> type
	 * regardless of the range. Note also that at most one range declaration is
	 * supported: when multiple ranges are set, only the first is taken into
	 * account. The are also limitations on the acceptable ranges: see class-level
	 * comments for the full list of supported ranges and their equivalent Java Class
	 * type.
	 * @return
	 */
	public String getPropertyRange() {
		return range;
	}
	
	@Override
	public String toString() {
		StringBuilder buf = new StringBuilder();
		String propType = getPropertyType() == Object.class ? "REFERENCE_DECLARATION" : "ATTRIBUTE_DECLARATION";
		buf.append(propType).append("[Name=").append(getPropertyName());
		if (getPropertyRange() != null) {
			buf.append("; Range=").append(getPropertyRange());
		}
		buf.append("; Java=").append(getPropertyType().getSimpleName()).append("]");
		return buf.toString();
	}
}
