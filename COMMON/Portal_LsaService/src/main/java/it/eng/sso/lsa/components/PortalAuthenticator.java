package it.eng.sso.lsa.components;

import it.eng.liferay.cas.integration.LiferayAuthenticationHandler;
import it.eng.sso.lsa.Principal;
import it.eng.sso.lsa.ver.VerManager;

import org.jasig.cas.authentication.Authentication;
import org.jasig.cas.authentication.AuthenticationManager;
import org.jasig.cas.authentication.handler.AuthenticationException;
import org.jasig.cas.authentication.handler.AuthenticationHandler;
import org.jasig.cas.authentication.handler.BlockedCredentialsAuthenticationException;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PortalAuthenticator implements IAuthenticator {

	private static final Logger logger = LoggerFactory
			.getLogger(PortalAuthenticator.class);
	private AuthenticationHandler ah;
	private VerManager verManager;

	@Override
	public Principal authenticateUserInBackend(String uid, String password)
			throws UserNotAllowedException, UserNotFoundException {
		logger.debug("authenticateUserInBackend({}, {})", uid, password);
		UsernamePasswordCredentials credentials = new UsernamePasswordCredentials();
		credentials.setUsername(uid);
		credentials.setPassword(password);
		try {
			ah.authenticate(credentials);
		} catch (BlockedCredentialsAuthenticationException blocked) {
			if (logger.isInfoEnabled()) {
				logger.info(String.format("User %s was blocked", uid), blocked);
			}
			throw new UserNotAllowedException(String.format(
					"User %s is blocked", uid), blocked);
		} catch (AuthenticationException e) {
			logger.info(
					"Caught authentication exception in CAS backend implementation",
					e);
			throw new UserNotFoundException(String.format(
					"CAS exception in backend: %s", e.getCode()), e);
		}
		// trasform to Principal
		org.jasig.cas.authentication.principal.Principal princ = LiferayAuthenticationHandler
				.getPrincipal();
		if(princ == null) return null;
		if (verManager != null)
			return new Principal(princ.getId(),
					verManager.obtainVirtualEnterprises(princ.getAttributes()));
		else
			return new Principal(princ.getId(), princ.getAttributes());
	}

	/**
	 * Transform an {@link Authentication} object returned by CAS
	 * {@link AuthenticationManager} to an MSEE {@link Principal}
	 * 
	 * @param auth
	 * @return
	 */
	public AuthenticationHandler getAh() {
		return ah;
	}

	public void setAh(AuthenticationHandler ah) {
		this.ah = ah;
	}

	public void setVerManager(VerManager verManager) {
		this.verManager = verManager;
	}

}
