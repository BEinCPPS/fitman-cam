package org.fiware.apps.marketplace.rest;

import org.fiware.apps.marketplace.model.ServiceManifestation;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import java.util.List;

@Path("/serviceManifestationIndex")
public interface ServiceManifestationIndexerService {
	
	@GET
	@Produces({ "application/xml", "application/json" })
	@Path("/all")
	public List<ServiceManifestation> getAllServiceManifestations();
	
	@GET
	@Produces({ "application/xml", "application/json" })
	@Path("/id/{id}")
	public ServiceManifestation getServiceManifestationById(@PathParam("id") String idString);
}
