package it.eng.cam.rest.exception;

/**
 * Created by ascatox on 27/09/2016.
 */

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

public class CAMServiceWebException extends WebApplicationException {

    public CAMServiceWebException(String message) {
        super(Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity(message).type(MediaType.TEXT_PLAIN).build());
    }

    public CAMServiceWebException(Response.Status status, String message) {
        super(Response.status(status).entity(message).type(MediaType.TEXT_PLAIN).build());
    }
}
