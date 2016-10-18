package it.eng.cam.rest.security;

import javax.ws.rs.core.SecurityContext;
import java.security.Principal;

/**
 * Created by ascatolo on 13/10/2016.
 */
public class CAMSecurityContext implements SecurityContext {
    private CAMPrincipal principal; //TODO
    private String scheme;

    public CAMSecurityContext(CAMPrincipal principal, String scheme) {
        this.principal = principal;
        this.scheme = scheme;
    }


    public CAMSecurityContext(CAMPrincipal principal) {
        this.principal = principal;
    }

    @Override
    public Principal getUserPrincipal() {
        return this.principal;
    }

    @Override
    public boolean isUserInRole(String s) {
        if (principal.getRole() != null) {
            return principal.getRole().contains(s);
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
