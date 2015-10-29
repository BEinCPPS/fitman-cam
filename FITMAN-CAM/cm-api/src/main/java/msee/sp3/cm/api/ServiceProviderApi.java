package msee.sp3.cm.api;

import msee.sp3.cm.api.resources.ServiceProviderResource;
import msee.sp3.cm.api.resources.ServiceProvidersResource;
import msee.sp3.cm.api.resources.TrustedMarketplaceResource;
import msee.sp3.cm.beans.IUserBean;
import msee.sp3.cm.domain.ServiceProvider;
import org.dozer.DozerBeanMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;

/**
 *
 */
@Service("serviceProviderApi")
public class ServiceProviderApi {

    private Logger logger = LoggerFactory.getLogger(ServiceProviderApi.class);

    @Resource
    private DozerBeanMapper mapper;

    @Resource
    private IUserBean userBean;

    @GET
    @Path("/serviceprovider/{username}")
    @Produces({"application/json", "application/xml"})
    public Response getServiceProviderByUsername(@PathParam("username") String username) {
        ServiceProvider sp = userBean.getServiceProvider(username);
        if (sp != null) {
            return Response.ok(mapper.map(sp, ServiceProviderResource.class)).build();
        }
        else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

    @GET
    @Path("/authenticate")
    @Produces({"application/json", "application/xml"})
    public Response authenticate(@QueryParam("username") String username, @QueryParam("password") String password) {
        ServiceProvider sp = userBean.authenticate(username, password);
        if (sp != null) {
            return Response.ok(mapper.map(sp, ServiceProviderResource.class)).build();
        }
        else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

    @PUT
    @Path("/serviceprovider/{username}")
    @Consumes({"application/json", "application/xml"})
    @Produces({"application/json", "application/xml"})
    public Response createServiceProvider(@PathParam("username") String username, ServiceProviderResource serviceProvider) {

        try {
            userBean.createServiceProvider(username, serviceProvider.getPassword(), serviceProvider.getEmail(), serviceProvider.getCompany());
        }
        catch (Exception e) {
            logger.error(String.format("Could not create service provider with username %s", username), e);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.CREATED).build();
    }

    /**
     *
     * @param username
     * @param serviceProvider from the service provider's list of TrustedMarketplaces, we only care about fiware marketplace's name.
     * @return
     */
    @POST
    @Path("/serviceprovider/{username}")
    @Consumes({"application/json", "application/xml"})
    @Produces({"application/json", "application/xml"})
    public Response updateServiceProviderByUsername(@PathParam("username") String username, ServiceProviderResource serviceProvider) {
        try {
            List<String> trustedMrktsNames = new ArrayList<String>();
            if (serviceProvider.getTrustedMarketplaces() != null) {
                for (TrustedMarketplaceResource tm : serviceProvider.getTrustedMarketplaces()) {
                    trustedMrktsNames.add(tm.getFiwareMarketplace().getName());
                }
            }
            userBean.updateServiceProvider(username, serviceProvider.getPassword(), serviceProvider.getEmail(), serviceProvider.getCompany(), trustedMrktsNames);
        }
        catch  (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }

        return Response.status(Response.Status.FOUND).build();
    }

    @DELETE
    @Path("/serviceprovider/{username}")
    public Response deleteServiceProviderByUsername(@PathParam("username") String username, ServiceProviderResource serviceProvider) {
        try {
            userBean.deleteServiceProvider(username);
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
    @Path("/serviceproviders")
    @Produces({"application/json", "application/xml"})
    public ServiceProvidersResource getServiceProviders(@QueryParam("from") int from, @QueryParam("to") int to) {
        ServiceProvidersResource response = new ServiceProvidersResource();

        List<ServiceProvider> providers = userBean.getServiceProviders(from, to);
        List<ServiceProviderResource> sps = new ArrayList<ServiceProviderResource>(providers.size());
        for (ServiceProvider sp : providers) {
            sps.add(mapper.map(sp, ServiceProviderResource.class));
        }
        response.setServiceProviders(sps);

        int totalNumServiceProviders = userBean.countServiceProviders();
        response.setTotalNumberServiceProviders(totalNumServiceProviders);

        return response;
    }
}
