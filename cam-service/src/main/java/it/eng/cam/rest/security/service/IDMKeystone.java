package it.eng.cam.rest.security.service;


import it.eng.cam.rest.security.authentication.CAMPrincipal;
import it.eng.cam.rest.security.authentication.credentials.Credentials;
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
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

/**
 * Created by ascatolo on 12/10/2016.
 */
public class IDMKeystone {
    private static final Logger logger = LogManager.getLogger(IDMKeystone.class.getName());


    public static List<User> getUsers() {
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

    public static CAMPrincipal getUserPrincipalByToken(String token) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("auth").path("tokens");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(Constants.X_AUTH_TOKEN, Constants.ADMIN_TOKEN);
        invocationBuilder.header(Constants.X_SUBJECT_TOKEN, token);
        Response response = invocationBuilder.get();
        CAMPrincipal user = buildUserFromToken(response);
        user = fetchUser(user);
        return fetchUserRoles(user);
    }

    public static List<String> getRoles() {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("roles");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(Constants.X_AUTH_TOKEN, Constants.ADMIN_TOKEN);
        Response response = invocationBuilder.get();
        JsonObject jsonObject = response.readEntity(JsonObject.class);
        JsonArray roles = jsonObject.getJsonArray("roles");
        List<String> ruoli = new ArrayList<>();
        for (int i = 0; i < roles.size(); i++) {
            JsonObject role = roles.getJsonObject(i);
            ruoli.add(role.getString("name"));
        }
        return ruoli;
    }

    private static CAMPrincipal fetchUser(CAMPrincipal user) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("users").path(user.getId());
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(Constants.X_AUTH_TOKEN, Constants.ADMIN_TOKEN);
        return buildUser(invocationBuilder.get());
    }

    private static CAMPrincipal fetchUserRoles(CAMPrincipal user) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("domains")
                .path(user.getDomain_id()).path("users").path(user.getId()).path("roles");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(Constants.X_AUTH_TOKEN, Constants.ADMIN_TOKEN);
        return buildRoles(invocationBuilder.get(), user);
    }

    /** At the moment we are using oAuth2 **/
    /**
     * @See IDMOauth2
     **/
    public static Response authenticate(UserLoginJSON userLoginJSON) {
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
     * @See IDMOauth2
     **/
    public static Response validateAuthToken(String token) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_KEYSTONE).path("auth").path("tokens");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(Constants.X_AUTH_TOKEN, Constants.ADMIN_TOKEN);
        invocationBuilder.header(Constants.X_SUBJECT_TOKEN, token);
        Response response = invocationBuilder.head();
        return response;
    }

    private static Credentials buildCredentials(String name, String password, String domainId) {
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

    private static CAMPrincipal buildUserFromToken(Response response) {
        final JsonObject dataJson = response.readEntity(JsonObject.class);
        final JsonObject tokenObj = dataJson.getJsonObject("token");
        final JsonObject userJson = tokenObj.getJsonObject("user");
        CAMPrincipal user = new CAMPrincipal();
        user.setUsername(userJson.getString("name"));
        user.setId(userJson.getString("id"));
        user.setDomain_id(userJson.getJsonObject("domain").getString("name"));
        return user;
    }

    private static CAMPrincipal buildUser(Response response) {
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

    private static CAMPrincipal buildRoles(Response response, CAMPrincipal principal) {
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




