package it.eng.cam.rest.security.service.impl;


import it.eng.cam.rest.security.authentication.CAMPrincipal;
import it.eng.cam.rest.security.authentication.credentials.Credentials;
import it.eng.cam.rest.security.project.Project;
import it.eng.cam.rest.security.project.ProjectContainerJSON;
import it.eng.cam.rest.security.project.ProjectsCacheManager;
import it.eng.cam.rest.Constants;
import it.eng.cam.rest.security.user.User;
import it.eng.cam.rest.security.user.UserContainerJSON;
import it.eng.cam.rest.security.user.UserLoginJSON;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import javax.json.JsonArray;
import javax.json.JsonObject;
import javax.ws.rs.client.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.*;

/**
 * Created by ascatolo on 12/10/2016.
 */
public class IDMKeystoneService implements IDMService {
    private static final Logger logger = LogManager.getLogger(IDMKeystoneService.class.getName());

    public Response getADMINToken(UserLoginJSON userLoginJSON) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("auth").path("tokens");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        Credentials principal = buildCredentials(userLoginJSON.getUsername(), userLoginJSON.getPassword(), null);
        return invocationBuilder.post(Entity.entity(principal, MediaType.APPLICATION_JSON));
    }

    public List<User> getUsers() {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("users");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(Constants.X_AUTH_TOKEN, Constants.ADMIN_TOKEN);
        Response response = invocationBuilder.get();
        UserContainerJSON userContainerJSON = response.readEntity(UserContainerJSON.class);
        if (null == userContainerJSON
                || null == userContainerJSON.getUsers()
                || userContainerJSON.getUsers().isEmpty())
            return null;
        return userContainerJSON.getUsers();
    }

    public List<Project> getProjects() {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("projects");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(Constants.X_AUTH_TOKEN, Constants.ADMIN_TOKEN);
        Response response = invocationBuilder.get();
        ProjectContainerJSON projectContainerJSON = response.readEntity(ProjectContainerJSON.class);
        List<Project> projects = projectContainerJSON.getProjects();
        if ((projects == null || projects.isEmpty()) && !ProjectsCacheManager.getInstance().getCache().isEmpty())
            return new ArrayList<>(ProjectsCacheManager.getInstance().getCache().values());
        buildProjectsCache(projects);
        List<Project> projectsToGive = new ArrayList<>();
        addNoDomainProject(projectsToGive);
        projectsToGive.addAll(projects);
        return projectsToGive;
    }


    public List<Project> getUserProjects(User user) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("users").path(user.getId()).path("projects");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(Constants.X_AUTH_TOKEN, Constants.ADMIN_TOKEN);
        Response response = invocationBuilder.get();
        ProjectContainerJSON projectContainerJSON = response.readEntity(ProjectContainerJSON.class);
        return projectContainerJSON.getProjects();
    }

    private void buildProjectsCache(List<Project> projects) {
        if (projects == null || projects.isEmpty()) return;
        for (Project project :
                projects) {
            ProjectsCacheManager.getInstance().getCache().put(project.getId(), project);
        }
    }


    private void addNoDomainProject(List<Project> projects) {
        Project noName = new Project();
        noName.setId(Constants.NO_DOMAIN);
        noName.setName("(NOT SET)");
        noName.setLinks(new Project.Link(""));
        noName.setDescription("Not set domain");
        projects.add(noName);
    }

    @Override
    public CAMPrincipal getUserPrincipalByToken(String token) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("auth").path("tokens");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(Constants.X_AUTH_TOKEN, Constants.ADMIN_TOKEN);
        invocationBuilder.header(Constants.X_SUBJECT_TOKEN, token);
        Response response = invocationBuilder.get();
        CAMPrincipal user = buildUserFromToken(response);
        user = fetchUser(user);
        user = fetchUserRoles(user);
        return fetchUserOrganizations(user);
    }

    @Override
    public CAMPrincipal getUserPrincipalByResponse(Response response) {
        CAMPrincipal user = buildUserFromToken(response);
        user = fetchUser(user);
        user = fetchUserRoles(user);
        return fetchUserOrganizations(user);
    }


    private CAMPrincipal fetchUser(CAMPrincipal user) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("users").path(user.getId());
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(Constants.X_AUTH_TOKEN, Constants.ADMIN_TOKEN);
        return buildUser(invocationBuilder.get());
    }

    private CAMPrincipal fetchUserRoles(CAMPrincipal user) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("domains")
                .path(user.getDomain_id()).path("users").path(user.getId()).path("roles");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(Constants.X_AUTH_TOKEN, Constants.ADMIN_TOKEN);
        return buildRoles(invocationBuilder.get(), user);
    }

    private CAMPrincipal fetchUserOrganizations(CAMPrincipal user) {
        List<Project> projects = getUserProjects(user);
        for (Project project :
                projects) {
            CAMPrincipal.Organization org = new CAMPrincipal.Organization();
            org.setName(project.getName());
            user.getOrganizations().add(org);
        }
        return user;
    }

    /** At the moment we are using oAuth2 **/
    /**
     * @See IDMOauth2Service
     **/
    public Response authenticate(UserLoginJSON userLoginJSON) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("auth").path("tokens");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(Constants.X_AUTH_TOKEN, Constants.ADMIN_TOKEN);
        Credentials principal = buildCredentials(userLoginJSON.getUsername(), userLoginJSON.getPassword(), null);
        Response response = invocationBuilder.post(Entity.entity(principal, MediaType.APPLICATION_JSON));
        logger.info(response.getHeaders());
        return response;
    }
    /** At the moment we are using oAuth2 **/
    /**
     * @See IDMOauth2Service
     **/
    @Override
    public Response validateAuthToken(String token) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("auth").path("tokens");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(Constants.X_AUTH_TOKEN, Constants.ADMIN_TOKEN);
        invocationBuilder.header(Constants.X_SUBJECT_TOKEN, token);
        Response response = invocationBuilder.get();
        return response;
    }

    private Credentials buildCredentials(String name, String password, String domainId) {
        Credentials principal = new Credentials();
        Credentials.Auth auth = new Credentials.Auth();
        Credentials.Identity identity = new Credentials.Identity();
        Credentials.Password passwordObj = new Credentials.Password();
        Credentials.User user = new Credentials.User(name, new Credentials.Domain(domainId), password);
        passwordObj.setUser(user);
        identity.setPassword(passwordObj);
        auth.setIdentity(identity);
        principal.setAuth(auth);
        return principal;
    }

    private CAMPrincipal buildUserFromToken(Response response) {
        final JsonObject dataJson = response.readEntity(JsonObject.class);
        final JsonObject tokenObj = dataJson.getJsonObject("token");
        final JsonObject userJson = tokenObj.getJsonObject("user");
        CAMPrincipal user = new CAMPrincipal();
        user.setUsername(userJson.getString("name"));
        user.setId(userJson.getString("id"));
        user.setDomain_id(userJson.getJsonObject("domain").getString("name"));
        return user;
    }

    private CAMPrincipal buildUser(Response response) {
        final JsonObject dataJson = response.readEntity(JsonObject.class);
        final JsonObject userJson = dataJson.getJsonObject("user");
        CAMPrincipal user = new CAMPrincipal();
        user.setUsername(userJson.getString("username"));
        user.setId(userJson.getString("id"));
        user.setName(userJson.getString("name"));
        user.setEnabled(userJson.getBoolean("enabled"));
        user.setDomain_id(userJson.getString("domain_id"));
        return user;
    }

    private CAMPrincipal buildRoles(Response response, CAMPrincipal principal) {
        final JsonObject dataJson = response.readEntity(JsonObject.class);
        final JsonArray rolesJsonArray = dataJson.getJsonArray("roles");
        for (int i = 0; i < rolesJsonArray.size(); i++) {
            JsonObject rol = rolesJsonArray.getJsonObject(i);
            String name = rol.getString("name");
            principal.getRoles().add(Constants.roleManager.getRolesLookup().get(name));
        }
        return principal;
    }
}