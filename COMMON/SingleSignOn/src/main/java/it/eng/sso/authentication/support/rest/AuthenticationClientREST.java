package it.eng.sso.authentication.support.rest;

import javax.ws.rs.core.Response;
import org.jboss.resteasy.client.ClientRequest;
import org.jboss.resteasy.client.ClientResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AuthenticationClientREST {
	
	/** Log instance. */
    private static final Logger log = LoggerFactory.getLogger(AuthenticationClientREST.class);
    
	public Response callRESTService(String uri, String user,String password) {
		ClientResponse<String> response;
		try {
			ClientRequest request = new ClientRequest(createURI(uri, user,password));
			request.accept("text/xml");
			response=  request.get(String.class);
			return response;
		
		} catch (Exception e) {
			log.debug(e.getMessage());
			return null;
		}
	}

	private String createURI(String uri, String user,
			String password) {
		return uri + "?" + "uid=" + user + "&" + "password=" + password;

	}

}