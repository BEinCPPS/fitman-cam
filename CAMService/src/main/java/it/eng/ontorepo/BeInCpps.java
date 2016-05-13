package it.eng.ontorepo;

/* @author Antonio Scatoloni */
public class BeInCpps {

	// TODO Ontology
	public static final String SYSTEM_NS = "http://www.msee-ip.eu/ontology/system#";
	public static final String OWNER_CLASS = SYSTEM_NS + "ResourceOwner";
	public static final String instanceOf = "instanceOf";
	public static final String ownedBy = "ownedBy";
	public static final String createdOn = "createdOn";

	/**
	 * If the given name belongs to the "system" namespace, returns the local
	 * version of the name; otherwise, returns the name unchanged.
	 * 
	 * @param name
	 * @return
	 */
	public static String getLocalName(String name) {
		if (null != name && name.startsWith(SYSTEM_NS)) {
			name = name.substring(SYSTEM_NS.length());
		}
		return name;
	}

	public BeInCpps() {
		super();
	}

}
