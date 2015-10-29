package msee.sp3.cm.api;

import msee.sp3.cm.api.resources.CreateNewOfferingRequest;
import msee.sp3.cm.api.resources.ServiceResource;
import msee.sp3.cm.beans.*;
import msee.sp3.cm.domain.FiwareMarketplace;
import msee.sp3.cm.domain.ServiceProvider;
import msee.sp3.cm.fiware.marketplaceri.client.StatefulMarketplaceClient;
import msee.sp3.cm.fiware.marketplaceri.client.exception.AuthenticationException;
import org.dozer.Mapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 *
 */
@Service("integrationApi")
@Path("/integration")
public class IntegrationApi {

    private Logger logger = LoggerFactory.getLogger(IntegrationApi.class);

    @Resource
    IUsdlRepositoryBean usdlRepositoryBean;

    @Resource
    IServiceTemplateBean serviceTemplateBean;

    @Resource
    IUserBean userBean;

    @Resource
    IFiwareMarketplaceBean fiwareMarketplaceBean;

    @Resource
    Mapper mapper;

    @PUT
    @Path("/offering")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public Response createNewOffering(CreateNewOfferingRequest newOfferingRequest) {

        // validations first: locate user and marketplaces exist
        ServiceProvider sp = userBean.getServiceProvider(newOfferingRequest.getCreatorUsername());
        if (sp == null) {
            return Response.status(Response.Status.BAD_REQUEST).entity("Could not locate creator username " + newOfferingRequest.getCreatorUsername()).build();
        }

        FiwareMarketplace fm = fiwareMarketplaceBean.getFiwareMarketplace(newOfferingRequest.getMarketplaceName());
        if (fm == null) {
            return Response.status(Response.Status.BAD_REQUEST).entity("Could not locate marketplace " + newOfferingRequest.getMarketplaceName()).build();
        }

        // Format USDL based on template and variable values
        logger.debug("Creating new offering with request {}", newOfferingRequest);
        String formattedUsdl = serviceTemplateBean.instantiateTemplate(newOfferingRequest.getServiceTemplateName(),
                newOfferingRequest.getVariableValues());
        if (formattedUsdl == null) {
            return Response.status(Response.Status.BAD_REQUEST).entity("Could not locate service template " + newOfferingRequest.getServiceTemplateName()).build();
        }

        logger.debug("Formatted USDL is {}", formattedUsdl);

        // Upload USDL to repository and obtain URL
        String usdlUrl = null;
        try {
            usdlUrl = usdlRepositoryBean.uploadUsdlToRepository(newOfferingRequest.getUsdlRepositoryName(),
                    newOfferingRequest.getServiceName(), formattedUsdl);
        }
        catch (IllegalArgumentException e) {
            return Response.status(Response.Status.BAD_REQUEST).entity(e.getMessage()).build();
        }
        catch (RuntimeException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).
                    entity("Could not upload USDL to repository " + newOfferingRequest.getUsdlRepositoryName()).build();
        }
        logger.debug("Uploaded USDL to repository, URL is {}", usdlUrl);

        // Create service
        ServiceResource sr = new ServiceResource();
        sr.setUrl(usdlUrl);
        sr.setName(newOfferingRequest.getServiceName());
        sr.setDescription(newOfferingRequest.getServiceDescription());
        sr.setStoreName(newOfferingRequest.getStoreName());

        StatefulMarketplaceClient smc = obtainMarketplaceClient(fm, newOfferingRequest.getCreatorUsername(), sp.getPasswordHash());
        if (smc != null) {
            org.fiware.apps.marketplace.model.Service svc = new org.fiware.apps.marketplace.model.Service();
            mapper.map(sr, svc);
            logger.info("Service to be registered: {}", svc);
            try {
                smc.saveService(newOfferingRequest.getStoreName(), svc);
            }
            catch (Exception e) {
                logger.error("Failed saving service {} to marketplace {}", sr, fm.getName());
            }
        }

        logger.debug("Service created successfully: {}", fm.getUrl() + "/v1/offering/store/" + sr.getStoreName() + "/offering/" + sr.getName());
        
        return Response.ok().build();
    }

    /**
     * helper method to obtain a configured, ready-to-use instance of fiware marketplace client
     */
    private StatefulMarketplaceClient obtainMarketplaceClient(FiwareMarketplace fiMarketplace, String username, String password) {
        StatefulMarketplaceClient smc = new StatefulMarketplaceClient();
        if (username == null) {
            try {
                smc.startSessionWithBuiltinPrincipal(fiMarketplace.getUrl());
            } catch (AuthenticationException e) {
                logger.error("Failed to authenticate with marketplace at " + fiMarketplace.getUrl(), e);
                return null;
            }
        }
        else {
            try {
                smc.startSession(fiMarketplace.getUrl(), username, password);
            } catch (AuthenticationException e) {
                logger.error(String.format("Failed to authenticate as %s with marketplace at %s", username,
                        fiMarketplace.getUrl()), e);
                return null;
            }
        }
        return smc;
    }
}
