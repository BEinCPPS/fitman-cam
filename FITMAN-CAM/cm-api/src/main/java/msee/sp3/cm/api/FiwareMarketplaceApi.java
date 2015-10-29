package msee.sp3.cm.api;

import msee.sp3.cm.api.resources.FiwareMarketplaceResource;
import msee.sp3.cm.api.resources.FiwareMarketplacesResource;
import msee.sp3.cm.beans.IFiwareMarketplaceBean;
import msee.sp3.cm.domain.FiwareMarketplace;
import org.dozer.DozerBeanMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;

/**
 *
 */
@Service("fiwareMarketplaceApi")
@Path("/fiware")
public class FiwareMarketplaceApi {

    @Resource
    private DozerBeanMapper mapper;

    @Resource(name = "fiwareMarketplaceBean")
    private IFiwareMarketplaceBean fiwareBean;

    @GET
    @Path("/marketplace/{name}")
    @Produces({"application/json", "application/xml"})
    public FiwareMarketplaceResource getFiwareMarketplaceByUsername(@PathParam("name") String name) {
        FiwareMarketplace fi = fiwareBean.getFiwareMarketplace(name);
        if (fi != null)
            return mapper.map(fi, FiwareMarketplaceResource.class);
        else
            return null;
    }

    @PUT
    @Path("/marketplace/{name}")
    @Consumes({"application/json", "application/xml"})
    @Produces({"application/json", "application/xml"})
    public Response createFiwareMarketplace(@PathParam("name") String name, FiwareMarketplaceResource resource) {

        fiwareBean.createFiwareMarketplace(name, resource.getUrl());

        return Response.status(Response.Status.CREATED).build();
    }

    @POST
    @Path("/marketplace/{name}")
    @Consumes({"application/json", "application/xml"})
    @Produces({"application/json", "application/xml"})
    public Response updateFiwareMarketplaceByName(@PathParam("name") String name, FiwareMarketplaceResource resource) {
        try {
            fiwareBean.updateFiwareMarketplace(name, resource.getName(), resource.getUrl());
        }
        catch  (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }

        return Response.status(Response.Status.FOUND).build();
    }

    @DELETE
    @Path("/marketplace/{name}")
    public Response deleteFiwareMarketplaceByName(@PathParam("name") String name) {
        try {
            fiwareBean.deleteFiwareMarketplace(name);
        }
        catch  (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }

        return Response.status(Response.Status.FOUND).build();
    }

    /**
     * Paged request for service providers
     * @param from
     * @param to
     * @return
     */
    @GET
    @Path("/marketplaces/")
    @Produces({"application/json", "application/xml"})
    public FiwareMarketplacesResource getFiwareMarketplaces(@QueryParam("from") int from, @QueryParam("to") int to) {
        FiwareMarketplacesResource response = new FiwareMarketplacesResource();

        List<FiwareMarketplace> marketplaces = fiwareBean.getFiwareMarketplaces(from, to);
        List<FiwareMarketplaceResource> fi = new ArrayList<FiwareMarketplaceResource>(marketplaces.size());
        for (FiwareMarketplace sp : marketplaces) {
            fi.add(mapper.map(sp, FiwareMarketplaceResource.class));
        }
        response.setFiwareMarketplaces(fi);

        int totalNumFiwareMarketplaces = fiwareBean.countFiwareMarketplaces();
        response.setTotalNumberFiwareMarketplaces(totalNumFiwareMarketplaces);

        return response;
    }
}
