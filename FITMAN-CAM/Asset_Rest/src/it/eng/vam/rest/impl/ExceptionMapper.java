package it.eng.vam.rest.impl;

import it.eng.vam.util.WarningException;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.Provider;

@Provider
public class ExceptionMapper implements javax.ws.rs.ext.ExceptionMapper<RuntimeException> {

	@Override
	public Response toResponse(RuntimeException re) {
		if (re instanceof WarningException){
			return Response
					.status(Response.Status.BAD_REQUEST)
					.entity(re.getMessage())
					.type(MediaType.TEXT_PLAIN).build();
		}else {
			return Response
				.status(Response.Status.INTERNAL_SERVER_ERROR)
				.entity(re.getMessage())
				.type(MediaType.TEXT_PLAIN).build();
		}
	}

}
