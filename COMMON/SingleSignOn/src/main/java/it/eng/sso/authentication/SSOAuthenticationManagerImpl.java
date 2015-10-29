package it.eng.sso.authentication;

import it.eng.sso.authentication.support.LSAServiceCredentialsAuthenticationHandler;
import it.eng.sso.authentication.util.SSOConstant;

import java.util.HashMap;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.jasig.cas.authentication.AbstractAuthenticationManager;
import org.jasig.cas.authentication.handler.AuthenticationException;
import org.jasig.cas.authentication.handler.AuthenticationHandler;
import org.jasig.cas.authentication.handler.BadCredentialsAuthenticationException;
import org.jasig.cas.authentication.handler.UnsupportedCredentialsException;
import org.jasig.cas.authentication.principal.Credentials;
import org.jasig.cas.authentication.principal.CredentialsToPrincipalResolver;
import org.jasig.cas.authentication.principal.Principal;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;

public class SSOAuthenticationManagerImpl extends AbstractAuthenticationManager {

	private static final String DEFAULT = "default";

	/** A map of authentication handlers. */
	@NotNull
	@Size(min = 1)
	private HashMap<String, AuthenticationHandler> authenticationHandlers;

	/** An array of CredentialsToPrincipalResolvers. **/
	@NotNull
	@Size(min = 1)
	// private List<CredentialsToPrincipalResolver>
	// credentialsToPrincipalResolvers;
	private HashMap<String, CredentialsToPrincipalResolver> credentialsToPrincipalResolvers;

	protected String authority;
	private String defaultEcosystem;

	@Override
	protected Pair<AuthenticationHandler, Principal> authenticateAndObtainPrincipal(final Credentials credentials)
			throws AuthenticationException {
		if (log.isDebugEnabled()) {
			log.debug("Entrato nel nuovo metodo");
		}
		boolean foundSupported = false;
		String handlerName;
		String ecosystem = "";
		// AuthenticationException unAuthSupportedHandlerException =
		// BadCredentialsAuthenticationException.ERROR;
		UsernamePasswordCredentials userPassCredentials = null;
		if (credentials instanceof UsernamePasswordCredentials) {
			userPassCredentials = (UsernamePasswordCredentials) credentials;
			if (userPassCredentials.getUsername() != null) {
				if (userPassCredentials.getUsername().contains(SSOConstant.SEPARATOR_AUTHORITY))
					authority = userPassCredentials.getUsername().substring(
							userPassCredentials.getUsername().indexOf(SSOConstant.SEPARATOR_AUTHORITY) + 1);
				else
					authority = DEFAULT;

			}
		}
		String ahKey = "";
		for (String key : authenticationHandlers.keySet()) {
			String currentKey = key;
			// if (currentKey.contains(SSOConstant.SEPARATOR_AUTHORITY)) {
			// currentKey = currentKey.substring(currentKey
			// .indexOf(SSOConstant.SEPARATOR_AUTHORITY) + 1);
			// }
			if (authority.equals(currentKey)) {
				ahKey = key;
				// if (key.contains(SSOConstant.SEPARATOR_AUTHORITY))
				// ecosystem = key.substring(0,
				// key.indexOf(SSOConstant.SEPARATOR_AUTHORITY));
				ecosystem = key;
				break;
			}
		}
		AuthenticationHandler handler = authenticationHandlers.get(ahKey);
		if (handler == null) {
			// ecosystem = defaultEcosystem;
			ecosystem = "";
			if (!"".equals(ahKey) || authority.equals(DEFAULT)) {
				for (String at : authenticationHandlers.keySet()) {
					// if (at.contains(DEFAULT)) {
					// handler = authenticationHandlers.get(at);
					// break;
					// }
					handler = authenticationHandlers.get(at);
					if (handler.authenticate(credentials)) {
						ecosystem = at;
						break;
					}
				}
			}
		} else {
			handlerName = handler.getClass().getName();
			LSAServiceCredentialsAuthenticationHandler.setEcosystem(ecosystem);
			if (!handler.authenticate(credentials)) {
				log.info("{} failed to authenticate {}", handlerName, credentials);
			} else {
				log.info("{} successfully authenticated {}", handlerName, credentials);
			}
		}
		if ("".equals(ecosystem))
			// throw unAuthSupportedHandlerException;
			throw BadCredentialsAuthenticationException.ERROR;

		// for (final CredentialsToPrincipalResolver
		// credentialsToPrincipalResolver :
		// this.credentialsToPrincipalResolvers) {
		CredentialsToPrincipalResolver credentialsToPrincipalResolver = credentialsToPrincipalResolvers.get(ecosystem);
		if (credentialsToPrincipalResolver.supports(credentials)) {
			final Principal principal = credentialsToPrincipalResolver.resolvePrincipal(credentials);
			log.info("Resolved principal " + principal);
			foundSupported = true;
			if (principal != null) {
				return new Pair<AuthenticationHandler, Principal>(handler, principal);
			}
		}
		// }

		if (foundSupported) {
			if (log.isDebugEnabled()) {
				log.debug("CredentialsToPrincipalResolver found but no principal returned.");
			}
			throw BadCredentialsAuthenticationException.ERROR;
		}
		log.error("CredentialsToPrincipalResolver not found for " + credentials.getClass().getName());
		throw UnsupportedCredentialsException.ERROR;
	}

	public void setCredentialsToPrincipalResolvers(
			HashMap<String, CredentialsToPrincipalResolver> credentialsToPrincipalResolvers) {
		this.credentialsToPrincipalResolvers = credentialsToPrincipalResolvers;
	}

	public void setAuthenticationHandlers(HashMap<String, AuthenticationHandler> authenticationHandlers) {
		this.authenticationHandlers = authenticationHandlers;
	}

	public String getDefaultEcosystem() {
		return defaultEcosystem;
	}

	public void setDefaultEcosystem(String defaultEcosystem) {
		this.defaultEcosystem = defaultEcosystem;
	}

}
