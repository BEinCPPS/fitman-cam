package it.eng.cam.rest.security;


import it.eng.cam.rest.security.authentication.credentials.json.*;
import it.eng.cam.rest.security.roles.RoleManager;
import it.eng.cam.rest.security.user.json.*;
import it.eng.cam.rest.security.user.json.User;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.glassfish.jersey.client.ClientConfig;
import org.glassfish.jersey.filter.LoggingFilter;

import javax.json.JsonArray;
import javax.json.JsonObject;
import javax.ws.rs.client.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ascatolo on 12/10/2016.
 */
public class IDMService {
    private static final Logger logger = LogManager.getLogger(IDMService.class.getName());
    public static final String IDM_URL = "http://161.27.159.76:8080/v3";
    private static final String ADMIN_TOKEN = "ADMIN"; //TODO
    public static final String X_AUTH_TOKEN = "X-Auth-Token";
    public static final String X_SUBJECT_TOKEN = "X-Subject-Token";
    public static final RoleManager roleManager = new RoleManager(); //TODO


    //TODO Logging
    public static List<User> getUsers() {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(IDM_URL).path("users");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(X_AUTH_TOKEN, ADMIN_TOKEN);
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
        WebTarget webTarget = client.target(IDM_URL).path("auth").path("tokens");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(X_AUTH_TOKEN, ADMIN_TOKEN);
        invocationBuilder.header(X_SUBJECT_TOKEN, token);
        Response response = invocationBuilder.get();
        CAMPrincipal user = buildUserFromToken(response);
        user = fetchUser(user);
        return fetchUserRoles(user);
    }

    public static List<String> getRoles() {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(IDM_URL).path("roles");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(X_AUTH_TOKEN, ADMIN_TOKEN);
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
        WebTarget webTarget = client.target(IDM_URL).path("users").path(user.getId());
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(X_AUTH_TOKEN, ADMIN_TOKEN);
        return buildUser(invocationBuilder.get());
    }

    private static CAMPrincipal fetchUserRoles(CAMPrincipal user) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(IDM_URL).path("domains")
                .path(user.getDomain_id()).path("users").path(user.getId()).path("roles");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(X_AUTH_TOKEN, ADMIN_TOKEN);
        return buildRoles(invocationBuilder.get(), user);
    }

    public static Response authenticate(UserLoginJSON userLoginJSON) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(IDM_URL).path("auth").path("tokens");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(X_AUTH_TOKEN, ADMIN_TOKEN);
        Credentials principal = buildCredentials(userLoginJSON.getUsername(), userLoginJSON.getPassword(), null);
        Response response = invocationBuilder.post(Entity.entity(principal, MediaType.APPLICATION_JSON));
        logger.info(response.getHeaders());
        return response;
    }

    public static Response validateAuthToken(String token) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(IDM_URL).path("auth").path("tokens");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(X_AUTH_TOKEN, ADMIN_TOKEN);
        invocationBuilder.header(X_SUBJECT_TOKEN, token);
        Response response = invocationBuilder.head();
        return response;
    }

    private static Credentials buildCredentials(String name, String password, String domainId) {
        Credentials principal = new Credentials();
        Auth auth = new Auth();
        Identity identity = new Identity();
        Password passwordObj = new Password();
        it.eng.cam.rest.security.authentication.credentials.json.User user = new it.eng.cam.rest.security.authentication.credentials.json.User(name, new Domain(domainId), password);
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
            principal.getRoles().add(roleManager.getRolesLookup().get(name));
        }
        return principal;
    }
}




