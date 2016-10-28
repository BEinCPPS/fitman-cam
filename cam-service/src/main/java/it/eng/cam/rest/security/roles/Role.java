package it.eng.cam.rest.security.roles;

/**
 * Created by ascatolo on 17/10/2016.
 */
public class Role {
    public static final String BASIC = "BASIC";
    public static final String ADMIN = "ADMIN";

    public static String valueOf(String name) {
        if (name.equalsIgnoreCase(BASIC)) return BASIC;
        else if (name.toUpperCase().contains(ADMIN)) return ADMIN; //TODO
        else return BASIC;
    }
}