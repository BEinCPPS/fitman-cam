package it.eng.cam.rest.security.authentication;

import it.eng.cam.rest.security.roles.Role;

import javax.ws.rs.core.SecurityContext;
import java.security.Principal;

/**
 * Created by ascatolo on 13/10/2016.
 */
public class CAMSecurityContext implements SecurityContext {
    private CAMPrincipal principal;
    private String scheme;

    public CAMSecurityContext(CAMPrincipal principal, String scheme) {
        this.principal = principal;
        this.scheme = scheme;
    }

    public CAMSecurityContext(CAMPrincipal principal) {
        this.principal = principal;
    }

    public CAMSecurityContext() {
    }

    @Override
    public Principal getUserPrincipal() {
        return this.principal;
    }


    @Override
    public boolean isUserInRole(String role) {
        if (principal.getRoles() != null) {
            return principal.getRoles().contains(Role.valueOf(role.toUpperCase()));
        }
        return false;
    }

    @Override
    public boolean isSecure() {
        return "https".equals(this.scheme);
    }

    @Override
    public String getAuthenticationScheme() {
        return SecurityContext.DIGEST_AUTH;
    }
}
