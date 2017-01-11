package it.eng.ontorepo;

import it.eng.cam.rest.Constants;

/* @author Antonio Scatoloni */
public class BeInCpps {

    // TODO Ontology
    public static final String NS = Constants.ONTOLOGY_NAMESPACE_DEFAULT;
    public static final String SYSTEM_NS = NS + "/ontology/system#";
    public static final String OWNER_CLASS = SYSTEM_NS + "ResourceOwner";
    public static final String USER_CLASS = SYSTEM_NS + "ResourceUser";
    public static final String ORION_CONFIG_CLASS = SYSTEM_NS + "ResourceOrionConfig";
    public static final String instanceOf = "instanceOf";
    public static final String ownedBy = "ownedBy";
    public static final String createdOn = "createdOn";
    public static final String syncTo = "syncTo";

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
