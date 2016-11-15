package it.eng.cam.rest.security.service;

import it.eng.cam.rest.security.roles.RoleManager;

import java.util.ResourceBundle;

/**
 * Created by ascatolo on 26/10/2016.
 */
public class Constants {
    public static ResourceBundle finder = ResourceBundle.getBundle("cam-service");
    public static final String IDM_URL = finder.getString("keyrock.url");
    public static final String IDM_URL_KEYSTONE = IDM_URL + ":8080/v3";
    public static final String ADMIN_USER = finder.getString("keyrock.admin.user");
    public static final String ADMIN_PASSWORD = finder.getString("keyrock.admin.password");
    public static final String X_AUTH_TOKEN = "X-Auth-Token";
    public static final String X_SUBJECT_TOKEN = "X-Subject-Token";
    public static final RoleManager roleManager = new RoleManager();
    public static final String AUTHENTICATION_SERVICE = finder.getString("keyrock.authentication.service");
    public static final String IDM_PROJECTS_PREFIX = IDM_URL_KEYSTONE + "/projects";
    public static final String NO_DOMAIN = "NO_DOMAIN";
    public static String ADMIN_TOKEN;
}
