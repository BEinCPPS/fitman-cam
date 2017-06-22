package it.eng.cam.rest;

import it.eng.cam.rest.security.roles.RoleManager;

import java.util.ResourceBundle;

/**
 * Created by ascatolo on 26/10/2016.
 */
public class Constants {
    public static final String DATE_PATTERN_DATE_TIME_TIMEZONE = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX";
    public static ResourceBundle finder = ResourceBundle.getBundle("cam-service");
    public static final String ONTOLOGY_NAMESPACE_DEFAULT = finder.getString("ontology.namespace.default");
    public static final String IDM_URL_HORIZON = finder.getString("horizon.url");
    public static final String IDM_URL_KEYSTONE = finder.getString("keystone.url") + "/v3";
    public static final String ADMIN_USER = finder.getString("keystone.admin.user");
    public static final String ADMIN_PASSWORD = finder.getString("keystone.admin.password");
    public static final String X_AUTH_TOKEN = "X-Auth-Token";
    public static final String X_SUBJECT_TOKEN = "X-Subject-Token";
    public static final RoleManager roleManager = new RoleManager();
    public static final String AUTHENTICATION_SERVICE = finder.getString("keyrock.authentication.service");
    public static final String IDM_PROJECTS_PREFIX = IDM_URL_KEYSTONE + "/projects";
    public static final String IDM_PROJECTS_PREFIX_WITH_SLASH = Constants.IDM_PROJECTS_PREFIX + "/";
    public static final String NO_DOMAIN = "NO_DOMAIN";
    public static String ADMIN_TOKEN;
    /**
     * Orion Context Broker
     **/
    public static final String SUB_SERVICE_HEADER = finder.getString("orion.service.sub.header");
    public static final String SERVICE_HEADER = finder.getString("orion.service.header");
    public static final String DEFAULT_SERVICE = finder.getString("orion.service.default");
    public static final String DEFAULT_SUB_SERVICE = finder.getString("orion.service.sub.default");

    public static final String NGSI = "ngsi_";
}
