package it.eng.cam.rest.security.authentication;

import it.eng.cam.rest.Constants;
import it.eng.cam.rest.security.service.impl.IDMService;
import it.eng.cam.rest.security.service.IDMServiceManager;
import org.apache.commons.lang3.StringUtils;

import javax.annotation.Priority;
import javax.ws.rs.Priorities;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.container.PreMatching;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.Provider;

/**
 * Created by ascatolo on 13/10/2016.
 */

@Provider
@Priority(Priorities.AUTHENTICATION)
@PreMatching

public class AuthenticationFilter implements ContainerRequestFilter {

    @Override
    public void filter(ContainerRequestContext requestContext) {
        String path = requestContext.getUriInfo().getPath();
        if (path.isEmpty() || path.contains("authenticate") || path.contains("authorize")) return;
        String token = requestContext.getHeaderString(Constants.X_AUTH_TOKEN);
        if (StringUtils.isBlank(token)) {
            requestContext.abortWith(Response
                    .status(Response.Status.UNAUTHORIZED)
                    .entity("User cannot access the resource.").type(MediaType.TEXT_PLAIN)
                    .build());
            return;
        }
        IDMService authService = IDMServiceManager.getAuthService();
        Response responseAuth = authService.validateAuthToken(token);
        if (responseAuth.getStatus() != Response.Status.OK.getStatusCode()) { //TODO
            requestContext.abortWith(Response
                    .status(Response.Status.FORBIDDEN)
                    .entity("User cannot access the resource.").type(MediaType.TEXT_PLAIN)
                    .build());
            return;
        }
        //Build User for Authorization
        CAMPrincipal userPrincipal = authService.getUserPrincipalByResponse(responseAuth);
        requestContext.setSecurityContext(new CAMSecurityContext(userPrincipal));
    }


}
