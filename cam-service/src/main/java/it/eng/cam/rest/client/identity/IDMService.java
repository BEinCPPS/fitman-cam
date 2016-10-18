package it.eng.cam.rest.client.identity;


import it.eng.cam.rest.dto.UserContainerJSON;
import it.eng.cam.rest.dto.UserJSON;
import it.eng.cam.rest.dto.UserLoginJSON;
import it.eng.cam.rest.security.keystone.dto.*;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.glassfish.jersey.client.ClientConfig;
import org.glassfish.jersey.filter.LoggingFilter;

import javax.json.JsonObject;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.client.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
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

    //TODO Logging
    public static List<UserJSON> getUsers() {
        Client client = ClientBuilder.newClient(new ClientConfig().register(LoggingFilter.class));
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

    public static UserJSON getUser(HttpServletRequest request) {
        String token = request.getHeader(X_AUTH_TOKEN);
        Client client = ClientBuilder.newClient(new ClientConfig().register(LoggingFilter.class));
        WebTarget webTarget = client.target(IDM_URL).path("auth").path("tokens");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(X_AUTH_TOKEN, ADMIN_TOKEN);
        invocationBuilder.header(X_SUBJECT_TOKEN, token);
        Response response = invocationBuilder.get();
        return buildUser(response);
    }

    public static Response authenticate(UserLoginJSON userLoginJSON) {
        Client client = ClientBuilder.newClient(new ClientConfig().register(LoggingFilter.class));
        WebTarget webTarget = client.target(IDM_URL).path("auth").path("tokens");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(X_AUTH_TOKEN, ADMIN_TOKEN);
        PrincipalJSON principal = buildPrincipal(userLoginJSON.getUsername(), userLoginJSON.getPassword(), null);
        Response response = invocationBuilder.post(Entity.entity(principal, MediaType.APPLICATION_JSON));
        logger.info(response.getHeaders());
        return response;
    }


    public static Response validateAuthToken(String token) {
        Client client = ClientBuilder.newClient(new ClientConfig().register(LoggingFilter.class));
        WebTarget webTarget = client.target(IDM_URL).path("auth").path("tokens");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        invocationBuilder.header(X_AUTH_TOKEN, ADMIN_TOKEN);
        invocationBuilder.header(X_SUBJECT_TOKEN, token);
        Response response = invocationBuilder.head();
        return response;
    }


    private static PrincipalJSON buildPrincipal(String name, String password, String domainId) {
        PrincipalJSON principal = new PrincipalJSON();
        Auth auth = new Auth();
        Identity identity = new Identity();
        Password passwordObj = new Password();
        it.eng.cam.rest.security.keystone.dto.User user = new it.eng.cam.rest.security.keystone.dto.User(name, new Domain(domainId), password);
        passwordObj.setUser(user);
        identity.setPassword(passwordObj);
        auth.setIdentity(identity);
        principal.setAuth(auth);
        return principal;
    }


    private static UserJSON buildUser(Response response) {
        final JsonObject dataJson = response.readEntity(JsonObject.class);
        final JsonObject tokenObj = dataJson.getJsonObject("token");
        final JsonObject userJson = tokenObj.getJsonObject("user");
        UserJSON user = new UserJSON();
        user.setUsername(userJson.getString("name"));
        user.setDomain_id(userJson.getJsonObject("domain").getString("name"));
        return user;
    }
}




