package it.eng.cam.rest.security;

import it.eng.cam.rest.client.identity.IDMService;

import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.Provider;

/**
 * Created by ascatolo on 13/10/2016.
 */
//@Secured
@Provider
public class XAuthenticationFilter implements ContainerRequestFilter {



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
        //Build User for Authorization va fatta sull'Ontologia


    }


}
