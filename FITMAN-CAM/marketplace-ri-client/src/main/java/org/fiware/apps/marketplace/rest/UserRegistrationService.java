package org.fiware.apps.marketplace.rest;

import org.fiware.apps.marketplace.model.Localuser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import java.util.Date;
import java.util.List;

@Path("/registration/userManagement")
public interface UserRegistrationService {

	@PUT
	@Consumes({"application/xml", "application/json"})
	@Path("/user")
	public Response saveLocaluser(Localuser lucaluser);


	@POST
	@Consumes({"application/xml", "application/json"})
	@Path("/user/{username}")
	public Response updateLocaluser(@PathParam("username") String username, Localuser localuser);

	@DELETE
	@Path("/user/{username}")
	public Response deleteLocaluser(@PathParam("username") String username);

	@GET
	@Produces({"application/xml", "application/json"})
	@Path("/user/{username}")
	public Localuser findLocaluser(@PathParam("username") String username);

	@GET
	@Produces({"application/xml", "application/json"})
	@Path("/users/")
	public List<Localuser> findLocalusers();

	
}
