package it.eng.sso.lsa.components;

import it.eng.sso.lsa.Principal;

import org.jasig.cas.authentication.Authentication;
import org.jasig.cas.authentication.AuthenticationManager;
import org.jasig.cas.authentication.handler.AuthenticationException;
import org.jasig.cas.authentication.handler.BlockedCredentialsAuthenticationException;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * An authenticator using Jasig CAS authentication manager backends
 */
public class CasAuthenticator implements IAuthenticator {

    private static final Logger logger = LoggerFactory.getLogger(CasAuthenticator.class);

    private AuthenticationManager authenticationManager;

    @Override
    public Principal authenticateUserInBackend(String uid, String password) throws UserNotAllowedException, UserNotFoundException {
        logger.debug("authenticateUserInBackend({}, {})", uid, password);
        UsernamePasswordCredentials credentials = new UsernamePasswordCredentials();
        credentials.setUsername(uid);
        credentials.setPassword(password);
        Authentication casAuth = null;
        try {
             casAuth = authenticationManager.authenticate(credentials);
        }
        catch (BlockedCredentialsAuthenticationException blocked ) {
            if (logger.isInfoEnabled()) {
                logger.info(String.format("User %s was blocked", uid), blocked);
            }
            throw new UserNotAllowedException(String.format("User %s is blocked", uid) , blocked);
        }
        catch (AuthenticationException e) {
            logger.info("Caught authentication exception in CAS backend implementation", e);
            throw new UserNotFoundException(String.format("CAS exception in backend: %s", e.getCode()) , e);
        }
        // trasform to Principal
        return transform(casAuth);
    }

    /**
     * Transform an {@link Authentication} object returned by CAS {@link AuthenticationManager} to an MSEE {@link Principal}
     * @param auth
     * @return
     */
    private Principal transform(Authentication auth) {
        Principal p = null;
        if (auth != null) {
            p = new Principal(auth.getPrincipal().getId(), auth.getPrincipal().getAttributes());
        }
        return p;
    }

    public AuthenticationManager getAuthenticationManager() {
        return authenticationManager;
    }

    public void setAuthenticationManager(AuthenticationManager authenticationManager) {
        this.authenticationManager = authenticationManager;
    }
}
