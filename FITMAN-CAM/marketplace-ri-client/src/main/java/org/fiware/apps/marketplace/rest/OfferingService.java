package org.fiware.apps.marketplace.rest;

import org.fiware.apps.marketplace.model.Service;
import org.fiware.apps.marketplace.model.Store;


import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import java.util.Date;
import java.util.List;

@Path("/offering")
public interface OfferingService {
	

	@PUT
	@Consumes({"application/xml", "application/json"})
	@Path("/store/{storeName}/offering")
	public Response saveService(@PathParam("storeName") String storeName, Service service);


	@POST
	@Consumes({"application/xml", "application/json"})
	@Path("/store/{storeName}/offering/{serviceName}")
	public Response updateService(@PathParam("storeName") String storeName, @PathParam("serviceName") String serviceName, Service service);

	@DELETE
	@Path("/store/{storeName}/offering/{serviceName}")
	public Response deleteService(@PathParam("storeName") String storeName, @PathParam("serviceName") String serviceName);

	@GET
	@Produces({"application/xml", "application/json"})
	@Path("/store/{storeName}/offering/{serviceName}")
	public Service findService(@PathParam("storeName") String storeName, @PathParam("serviceName") String serviceName);

	@GET
	@Produces({"application/xml", "application/json"})
	@Path("/store/{storeName}/offerings/")
	public List<Service> findServices(@PathParam("storeName") String storeName);


}
