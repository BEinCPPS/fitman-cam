package it.eng.cam.rest.security.authentication;

import it.eng.cam.rest.security.CAMPrincipal;
import it.eng.cam.rest.security.CAMSecurityContext;
import it.eng.cam.rest.security.IDMService;

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
        if (path.isEmpty() || path.contains("authenticate")) return;
        String token = requestContext.getHeaderString(IDMService.X_AUTH_TOKEN);
        if (null == token || token.isEmpty()) {
            requestContext.abortWith(Response
                    .status(Response.Status.UNAUTHORIZED)
                    .entity("User cannot access the resource.").type(MediaType.TEXT_PLAIN)
                    .build());
            return;
        }
        Response responseAuth = IDMService.validateAuthToken(token);
        if (responseAuth.getStatus() != Response.Status.OK.getStatusCode()) { //TODO
            requestContext.abortWith(Response
                    .status(Response.Status.FORBIDDEN)
                    .entity("User cannot access the resource.").type(MediaType.TEXT_PLAIN)
                    .build());
            return;
        }
        //Build User for Authorization
        CAMPrincipal userPrincipal = IDMService.getUserPrincipalByToken(token);
        requestContext.setSecurityContext(new CAMSecurityContext(userPrincipal));
    }


}
