package msee.sp3.cm.api;

import javax.annotation.Resource;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import msee.sp3.cm.api.resources.ServiceResourceExtended;
import msee.sp3.cm.beans.IServiceBean;
import msee.sp3.cm.domain.Service;

import org.dozer.DozerBeanMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@org.springframework.stereotype.Service("serviceApi")
@Path("/serviceapi")
public class ServiceApi {
	
	 private Logger logger = LoggerFactory.getLogger(ServiceApi.class);

	    @Resource
	    private IServiceBean serviceBean;
	    
	    @Resource
	    private DozerBeanMapper mapper;
	    
	    @POST
	    @Path("/service")
	    @Consumes({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
	    @Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
	    public Response createService(ServiceResourceExtended serviceResource) {

	    	Service service = mapper.map(serviceResource, Service.class);
	        try {
	        	serviceBean.createService(service);
	        }
	        catch (Exception e) {
	            logger.error(String.format("Could not create service ", serviceResource.getServiceName()), e);
	            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
	        }
	        return Response.status(Response.Status.CREATED).build();
	    }

	    
	    
	    @GET
	    @Path("/servicetest/")
	    @Produces({MediaType.APPLICATION_JSON})
	    public Response testService() {

	    	System.out.println("IT WORKS!!!");
	        return Response.status(Response.Status.ACCEPTED).build();
	    }




}
