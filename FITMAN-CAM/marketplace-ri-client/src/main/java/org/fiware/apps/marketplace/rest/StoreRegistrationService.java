package org.fiware.apps.marketplace.rest;

import org.fiware.apps.marketplace.model.Store;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import java.util.Date;
import java.util.List;

@Path("/registration")
public interface StoreRegistrationService {


	@PUT
	@Consumes({"application/xml", "application/json"})
	@Path("/store")
	public Response saveStore(Store store);


	@POST
	@Consumes({"application/xml", "application/json"})
	@Path("/store/{storeName}")
	public Response updateStore(@PathParam("storeName") String storeName, Store store);

	@DELETE
	@Path("/store/{storeName}")
	public Response deleteStore(@PathParam("storeName") String storeName);

	@GET
	@Produces({"application/xml", "application/json"})
	@Path("/store/{storeName}")
	public Store findStore(@PathParam("storeName") String storeName);

	@GET
	@Produces({"application/xml", "application/json"})
	@Path("/stores/")
	public List<Store> findStores();


}
