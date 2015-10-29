package org.fiware.apps.marketplace.rest;

import org.fiware.apps.marketplace.model.SearchByCriteria;
import org.fiware.apps.marketplace.model.SearchResult;
import org.fiware.apps.marketplace.model.SearchResultOffering;

import javax.ws.rs.*;
import javax.ws.rs.core.Response;

@Path("/search")
public interface SearchService {

	@GET
	@Produces({ "application/xml", "application/json" })
	@Path("/offerings/fulltext/{searchstring}")
	SearchResult findStore(@PathParam("searchstring") String searchstring);

    @POST
    @Produces({ "application/xml", "application/json" })
    @Consumes({ "application/xml", "application/json" })
    @Path("/offerings/criteria")
    SearchResultOffering findOfferingsByCriteria(SearchByCriteria searchByCriteria);
}
