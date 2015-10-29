package msee.sp3.cm.api;

import msee.sp3.cm.api.resources.ServiceTemplateInstantiationRequest;
import msee.sp3.cm.api.resources.ServiceTemplateResource;

import msee.sp3.cm.api.resources.ServiceTemplateVariables;
import msee.sp3.cm.api.resources.ServiceTemplatesResource;
import msee.sp3.cm.beans.IServiceTemplateBean;
import msee.sp3.cm.domain.ServiceTemplate;
import org.apache.commons.lang.StringUtils;
import org.dozer.DozerBeanMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.ws.rs.*;
import javax.ws.rs.core.GenericEntity;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

/**
 *
 */
@Service("serviceTemplateApi")
@Path("/servicetemplates")
public class ServiceTemplateApi {

    private Logger logger = LoggerFactory.getLogger(ServiceTemplateApi.class);

    @Resource
    private IServiceTemplateBean serviceTemplateBean;

    @Resource
    private DozerBeanMapper mapper;

    private class ListOfStringsEntity extends GenericEntity<List<String>> {

        private ListOfStringsEntity(List<String> entity) throws IllegalArgumentException {
            super(entity);
        }

        private ListOfStringsEntity(List<String> entity, Type genericType) throws IllegalArgumentException {
            super(entity, genericType);
        }
    };

    @GET
    @Path("/{name}")
    @Produces({"application/json", "application/xml"})
    public Response getServiceTemplateByName(@PathParam("name") String templateName) {
        ServiceTemplate st = serviceTemplateBean.getServiceTemplate(templateName);
        if (st != null) {
            return Response.ok(mapper.map(st, ServiceTemplateResource.class)).build();
        }
        else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

    @PUT
    @Path("/{name}")
    @Consumes({"application/json", "application/xml"})
    @Produces({"application/json", "application/xml"})
    public Response createServiceTemplate(@PathParam("name") String name, ServiceTemplateResource serviceTemplate) {

        if ((StringUtils.isBlank(name)) || (serviceTemplate == null) || (StringUtils.isBlank(serviceTemplate.getName())) ||
                (StringUtils.isBlank(serviceTemplate.getTemplateText())) || (!name.equals(serviceTemplate.getName()))) {
            return Response.status(Response.Status.BAD_REQUEST).entity("Invalid input: service template names " +
                    "must not be empty and match between URL and body; template text must not be empty.").build();
        }

        try {
            serviceTemplateBean.createServiceTemplate(name, serviceTemplate.getTemplateText(),serviceTemplate.getTemplateDescription());
        }
        catch (Exception e) {
            logger.error(String.format("Could not create service template with name %s", name), e);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.CREATED).build();
    }

    @POST
    @Path("/{name}")
    @Consumes({"application/json", "application/xml"})
    @Produces({"application/json", "application/xml"})
    public Response updateServiceTemplateByName(@PathParam("name") String name, ServiceTemplateResource serviceTemplate) {
        try {
            serviceTemplateBean.updateServiceTemplate(name, serviceTemplate.getName(), serviceTemplate.getTemplateText(), serviceTemplate.getTemplateDescription());
        }
        catch  (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }

        return Response.status(Response.Status.FOUND).build();
    }

    @DELETE
    @Path("/{name}")
    public Response deleteServiceTemplateByName(@PathParam("name") String name) {
        try {
            serviceTemplateBean.deleteServiceTemplate(name);
        }
        catch  (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }

        return Response.status(Response.Status.FOUND).build();
    }

    /**
     * Paged request for service templates
     * @param from
     * @param to
     * @return
     */
    @GET
    @Produces({"application/json", "application/xml"})
    public ServiceTemplatesResource getServiceTemplates(@QueryParam("from") int from, @QueryParam("to") int to) {

        ServiceTemplatesResource response = new ServiceTemplatesResource();

        List<ServiceTemplate> providers;

        if ((from == to) && (to == 0)) {
            providers = serviceTemplateBean.getServiceTemplates(0, -1);
        }
        else {
            providers = serviceTemplateBean.getServiceTemplates(from, to);
        }
        if (providers != null) {
            List<ServiceTemplateResource> sps = new ArrayList<ServiceTemplateResource>(providers.size());
            for (ServiceTemplate sp : providers) {
                sps.add(mapper.map(sp, ServiceTemplateResource.class));
            }
            response.setServiceTemplates(sps);
        }

        int totalNumServiceTemplates = serviceTemplateBean.countServiceTemplates();
        response.setTotalNumberServiceTemplates(totalNumServiceTemplates);

        return response;
    }

    @GET
    @Path("/{name}/variables")
    @Produces({"application/json", "application/xml"})
    public Response getTemplateVariables(@PathParam("name") String name) {
        try {
            List<String> variables = serviceTemplateBean.getVariableNames(name);
            if (variables != null) {
//                ListOfStringsEntity entity = new ListOfStringsEntity(variables);
                ServiceTemplateVariables vars = new ServiceTemplateVariables(variables);
                return Response.ok().entity(vars).build();
            }
            else {
                return Response.ok().build();
            }
        }
        catch  (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

    @POST
    @Path("/{name}/instance")
    @Consumes({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
    @Produces(MediaType.TEXT_PLAIN)
    public Response instantiateTemplate(@PathParam("name") String name, ServiceTemplateInstantiationRequest instantiate) {
        String serviceDescription = serviceTemplateBean.instantiateTemplate(name, instantiate.getVariableValues());
        return Response.ok().entity(serviceDescription).build();
    }


}
