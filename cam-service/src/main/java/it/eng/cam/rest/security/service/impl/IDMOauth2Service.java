package it.eng.cam.rest.security.service.impl;

import it.eng.cam.rest.security.authentication.CAMPrincipal;
import it.eng.cam.rest.security.roles.Role;
import it.eng.cam.rest.Constants;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import javax.json.JsonArray;
import javax.json.JsonObject;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Response;

/**
 * Created by ascatolo on 26/10/2016.
 */
public class IDMOauth2Service implements IDMService {
    private static final Logger logger = LogManager.getLogger(IDMOauth2Service.class.getName());

    public  Response validateAuthToken(String token) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_HORIZON).path("user")
                .queryParam("access_token", token);
        Invocation.Builder invocationBuilder = webTarget.request();
        Response response = invocationBuilder.get();
        return response;
    }

    public CAMPrincipal getUserPrincipalByToken(String token) {
        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(Constants.IDM_URL_HORIZON).path("user")
                .queryParam("access_token", token);
        Invocation.Builder invocationBuilder = webTarget.request();
        Response response = invocationBuilder.get();
        return buildUser(response);
    }

    public CAMPrincipal getUserPrincipalByResponse(Response response) {
        return buildUser(response);
    }


    private static CAMPrincipal buildUser(Response response) {
        final JsonObject userJson = response.readEntity(JsonObject.class);
        CAMPrincipal user = new CAMPrincipal();
        user.setUsername(userJson.getString("displayName"));
        user.setId(userJson.getString("id"));
        user.setName(userJson.getString("email"));
        JsonArray rolesJson = userJson.getJsonArray("roles");
        if (rolesJson != null && rolesJson.size() > 0) {
            for (int i = 0; i < rolesJson.size(); i++) {
                JsonObject rol = rolesJson.getJsonObject(i);
                user.getRoles().add(Constants.roleManager.getRolesLookup().get(rol.getString("name")));
            }
        } else
            user.getRoles().add(Role.BASIC); //TODO
        JsonArray organizationsJson = userJson.getJsonArray("organizations");
        if (organizationsJson != null)
            for (int i = 0; i < organizationsJson.size(); i++) {
                JsonObject orgJson = rolesJson.getJsonObject(i);
                CAMPrincipal.Organization org = new CAMPrincipal.Organization();
                org.setName(orgJson.getString("name"));
                org.setId(orgJson.getJsonNumber("id").intValue());
                JsonArray organizationsRoles = orgJson.getJsonArray("roles");
                if (organizationsRoles != null)
                    for (int j = 0; j < organizationsRoles.size(); j++) {
                        JsonObject orgRoleJson = organizationsRoles.getJsonObject(i);
                        org.getRoles().add(Constants.roleManager.getRolesLookup().get(orgRoleJson.getString("name")));
                    }
                user.getOrganizations().add(org);
            }
        return user;
    }

}
