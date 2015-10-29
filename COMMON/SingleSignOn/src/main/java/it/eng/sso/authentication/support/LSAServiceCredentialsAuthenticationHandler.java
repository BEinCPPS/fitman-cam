/* agreements. See the NOTICE file distributed with this work
 * for additional information regarding copyright ownership.
 * Jasig licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License.  You may obtain a
 * copy of the License at the following location:
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package it.eng.sso.authentication.support;



import it.eng.sso.authentication.support.rest.AuthenticationClientREST;
import it.eng.sso.authentication.support.rest.SAMLResponseReader;
import it.eng.sso.authentication.util.SSOConstant;

import javax.validation.constraints.NotNull;
import javax.ws.rs.core.Response;

import org.jasig.cas.authentication.handler.AuthenticationHandler;
import org.jasig.cas.authentication.principal.Credentials;
import org.jasig.cas.authentication.principal.CredentialsToPrincipalResolver;
import org.jasig.cas.authentication.principal.Principal;
import org.jasig.cas.authentication.principal.SimplePrincipal;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Class to validate the credentials presented by communicating with the web
 * server and checking the certificate that is returned against the hostname,
 * etc.
 * <p>
 * This class is concerned with ensuring that the protocol is HTTPS and that a
 * response is returned. The SSL handshake that occurs automatically by opening
 * a connection does the heavy process of authenticating.
 * 
 * @author Antonio Scatoloni
 * @version $Revision$ $Date$
 * @since 3.0
 */
public class LSAServiceCredentialsAuthenticationHandler implements
		AuthenticationHandler, CredentialsToPrincipalResolver {

	/** Log instance. */
	private final Logger log = LoggerFactory.getLogger(getClass());
	public static final ThreadLocal<Principal> principalThreadLocal = new ThreadLocal<Principal>();
	@NotNull
	private String URI;
	private static String ecosystem;
	public boolean authenticate(Credentials credentials) {
		log.debug("Attempting to resolve credentials for " + credentials);
		if (credentials instanceof UsernamePasswordCredentials) {
			String principalId = extractPrincipalId(credentials);
			UsernamePasswordCredentials lsaCredentials = (UsernamePasswordCredentials) credentials;
			String password = lsaCredentials.getPassword();
			String user = lsaCredentials.getUsername().contains(SSOConstant.SEPARATOR_AUTHORITY)?lsaCredentials.getUsername().substring(0,
					lsaCredentials.getUsername().indexOf(SSOConstant.SEPARATOR_AUTHORITY)):lsaCredentials.getUsername();
			
//			String user = lsaCredentials.getUsername();
		
			AuthenticationClientREST authenticationREST=new AuthenticationClientREST();
			Response response = authenticationREST.callRESTService(this.URI,user,password);
			if (response.getStatus() == 200) {
				principalThreadLocal.set(new SimplePrincipal(principalId,
						SAMLResponseReader.extractAttributesFromResponse(response.getEntity().toString(), ecosystem)));
				return true;
			}
			if (response.getStatus() != 200) {
				log.error("Failed : HTTP error code : "+ response.getStatus());
			}
		}
		return false;
	}

	public Principal resolvePrincipal(Credentials arg0) {
		Principal principal = principalThreadLocal.get();
		principalThreadLocal.remove();
		return principal;
	}

	protected String extractPrincipalId(final Credentials credentials) {
		final UsernamePasswordCredentials usernamePasswordCredentials = (UsernamePasswordCredentials) credentials;
		if(usernamePasswordCredentials.getUsername().contains(SSOConstant.SEPARATOR_AUTHORITY) )
			return usernamePasswordCredentials.getUsername().substring(0,
					usernamePasswordCredentials.getUsername().indexOf(SSOConstant.SEPARATOR_AUTHORITY));
		return usernamePasswordCredentials.getUsername();
	}

	/**
	 * Return true if Credentials are UsernamePasswordCredentials, false
	 * otherwise.
	 */
	public boolean supports(final Credentials credentials) {
		return credentials != null
				&& UsernamePasswordCredentials.class
						.isAssignableFrom(credentials.getClass());
	}
	
	public void setURI(String uRI) {
		URI = uRI;
	}
	public static void setEcosystem(String ecosystem) {
		LSAServiceCredentialsAuthenticationHandler.ecosystem = ecosystem;
	}
}
