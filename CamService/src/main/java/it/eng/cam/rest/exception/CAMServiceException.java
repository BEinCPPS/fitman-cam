package it.eng.cam.rest.exception;

import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class CAMServiceException extends Throwable implements ExceptionMapper<Throwable> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5715612167673325904L;

	@Override
	public Response toResponse(Throwable exception) {
		return Response.status(500).entity(exception.getMessage()).type("text/plain").build();
	}
}
