package it.eng.ontorepo;

/**
 * DTO representing the (single) Value of an Object Property
 * or of a Datatype Property, as assigned to a given Individual.
 * if multiple Value declarations exist, only the first one is
 * considered, while the others are silently discarded.  
 * This is an extension of the {@link PropertyDeclarationItem} class:
 * see the documentation of the superclass for more info on other
 * constraints imposed on Reference Ontology assertions.
 * 
 * @author Mauro Isaja mauro.isaja@eng.it
 *
 */
public class PropertyValueItem extends PropertyDeclarationItem {
	
	private final String originalTarget;
	private final String target;
	private final String originalValue;
	private final String value;
	
	/**
	 * Initialize a new instance with its own Name, Assertion Type, Range, Individual Name and Value.
	 * @param namespace the implicit namespace of the Reference Ontology (mandatory)
	 * @param name full URI which identifies the Property (mandatory)
	 * @param type OWL type of the assertion - either owl:DatatypeProperty or owl:ObjectProperty (mandatory)
	 * @param range full URI which identifies a standard XSD type (optional)
	 * @param target full URI which identifies the Individual (mandatory)
	 * @param value string value of the Property (optional)
	 */
	public PropertyValueItem(String namespace, String name, String type, String range, String target, String value) {
		super(namespace, name, type, range);
		if (null == target || target.isEmpty()) {
			throw new IllegalArgumentException("Target is mandatory");
		}
		this.originalTarget = target;
		this.target = Util.getLocalName(namespace, target);
		this.originalValue = value;
		this.value = Util.getLocalName(namespace, value);
	}
	
	/**
	 * Returns the original Target of the Property - i.e., without
	 * any normalization applied.
	 * @return
	 */
	public String getPropertyOriginalTarget() {
		return originalTarget;
	}
	
	/**
	 * Returns the <i>normalized</i> Target of the Property - i.e., the
	 * <i>local</i> Name of the Individual it refers to: the implicit
	 * namespace, if present, is stripped from the result. URIs which
	 * do not contain a reference to the implicit namespace are left unchanged.
	 * @return
	 */
	public String getPropertyTarget() {
		return target;
	}
	
	/**
	 * Returns the original Value of the Property - i.e., without
	 * any normalization applied.
	 * @return
	 */
	public String getPropertyOriginalValue() {
		return originalValue;
	}
	
	/**
	 * Returns the <i>normalized</i> Value of the Property: the implicit
	 * namespace, if the value is a URI, is stripped from the result.
	 * Non-URI values, and URIs which do not contain a reference to the implicit
	 * namespace, are left unchanged.
	 * @return
	 */
	public String getPropertyValue() {
		return value;
	}
	
	@Override
	public String toString() {
		StringBuilder buf = new StringBuilder();
		String propType = getPropertyType() == Object.class ? "REFERENCE_VALUE" : "ATTRIBUTE_VALUE";
		buf.append(propType).append("[Name=").append(getPropertyName());
		buf.append("; Target=").append(getPropertyTarget());
		buf.append("; Value=").append(getPropertyValue());
		if (getPropertyRange() != null) {
			buf.append("; Range=").append(getPropertyRange());
		}
		buf.append("]");
		return buf.toString();
	
	}
}
