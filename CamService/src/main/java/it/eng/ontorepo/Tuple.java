package it.eng.ontorepo;

/**
 * DTO representing a generic RDF assertion. It also implements
 * Name and Value <i>normalization</i>: when they are relative to
 * the implicit namespace of the Reference Ontology, they are
 * also stored in a compact, <i>normalized</i> version without
 * the namespace prefix - see {@link #getNormalizedName()} and
 * {@link #getNormalizedValue()}. 
 * 
 * @author Mauro Isaja mauro.isaja@eng.it
 *
 */
public class Tuple {

	private final String namespace;
	private final String name;
	private final String normalizedName;
	private final String value;
	private final String normalizedValue;
	
	/**
	 * Initializes a new instance with its Name and Value.
	 * @param namespace the implicit namespace of the Reference Ontology (mandatory)
	 * @param name full URI of the assertion target  (mandatory)
	 * @param value value of the assertion (optional)
	 */
	public Tuple(String namespace, String name, String value) {
		if (null == namespace || namespace.isEmpty()) {
			throw new IllegalArgumentException("Namespace is mandatory");
		}
		if (null == name || name.isEmpty()) {
			throw new IllegalArgumentException("Name is mandatory");
		}
		this.namespace = namespace;
		this.name = name;
		this.normalizedName = Util.getLocalName(namespace, name);
		this.value = value;
		this.normalizedValue = Util.getLocalName(namespace, value);
	}
	
	/**
	 * Returns the implicit namespace of the Reference Ontology.
	 * @return
	 */
	public String getNamespace() {
		return this.namespace;
	}

	/**
	 * Returns the original URI of the assertion target, without modifications.
	 * @return
	 */
	public String getOriginalName() {
		return name;
	}

	/**
	 * Returns the <i>local</i> Name of the assertion target: the implicit namespace,
	 * if is part of the full URI, is stripped from the result. URIs which do not
	 * contain a reference to the implicit namespace are left unchanged.  
	 * @return
	 */
	public String getNormalizedName() {
		return normalizedName;
	}

	/**
	 * Returns the original Value of the assertion, without modifications.
	 * @return
	 */
	public String getOriginalValue() {
		return value;
	}

	/**
	 * Returns the <i>normalized</i> Value of the assertion: the implicit
	 * namespace, if the value is a URI, is stripped from the result.
	 * Non-URI values, and URIs which do not contain a reference to the implicit
	 * namespace, are left unchanged.
	 * @return
	 */
	public String getNormalizedValue() {
		return normalizedValue;
	}
}
