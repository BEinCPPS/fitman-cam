package it.eng.ontorepo;

/**
 * DTO representing an Individual.
 * Only Name and Class are supported.
 * 
 * @author Mauro Isaja mauro.isaja@eng.it
 *
 */
public class IndividualItem extends Tuple {

	/**
	 * Initialize a new instance with its own Name and its Class Name.
	 * @param namespace the implicit namespace of the Reference Ontology (mandatory)
	 * @param name full URI which identifies the the Individual (mandatory)
	 * @param clazz
	 */
	public IndividualItem(String namespace, String name, String clazz) {
		super(namespace, name, clazz);
		if (null == clazz || clazz.isEmpty()) {
			throw new IllegalArgumentException("Class is mandatory");
		}
	}
	
	/**
	 * Returns the <i>local</i> Name of the Individual: the implicit namespace,
	 * if is part of the full URI, is stripped from the result. URIs which do not
	 * contain a reference to the implicit namespace are left unchanged.
	 * <p />
	 * To obtain the original full URI, use {@link Tuple#getOriginalName()}. 
	 * @return
	 */
	public String getIndividualName() {
		return getNormalizedName();
	}
	
	/**
	 * Returns the <i>local</i> Name of the Class the Individual belongs to: the
	 * implicit namespace, if is part of the full URI, is stripped from the result.
	 * URIs which do not contain a reference to the implicit namespace are left unchanged.  
	 * <p />
	 * To obtain the original full URI, use {@link Tuple#getOriginalValue()}.
	 * @return
	 */
	public String getClassName() {
		return getNormalizedValue();
	}
	
	@Override
	public String toString() {
		StringBuilder buf = new StringBuilder();
		buf.append("ASSET_OBJECT[Name=").append(getIndividualName());
		buf.append("; Class=").append(getClassName()).append("]");
		return buf.toString();
	}
}
