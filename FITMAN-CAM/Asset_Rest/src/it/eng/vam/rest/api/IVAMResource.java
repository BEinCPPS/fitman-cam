package it.eng.vam.rest.api;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.StreamingOutput;

@Path("/")
public interface IVAMResource {

	
	@GET
	@Path("classes")
	@Produces(MediaType.APPLICATION_JSON)
	public StreamingOutput getClasses();	
	
	@GET
	@Path("classes/{class}/assets")
	@Produces(MediaType.APPLICATION_JSON)
	public StreamingOutput getAssets(@PathParam("class") String class_name);
	
	@GET
	@Path("assets/{asset}")
	@Produces(MediaType.APPLICATION_JSON)
	public StreamingOutput getAsset(@PathParam("asset") String asset_name);
	
	
	@GET
	@Path("services/public")
	@Produces(MediaType.APPLICATION_JSON)
	public StreamingOutput GetPublicServices();	
	
	@GET
	@Path("services/local")
	@Produces(MediaType.APPLICATION_JSON)
	public StreamingOutput GetLocalServices();	
	
	@GET
	@Path("services/public/{service}")
	@Produces(MediaType.APPLICATION_JSON)
	public StreamingOutput GetPublicService(@PathParam("service") String public_service_name);
	
	@GET
	@Path("services/local/{service}")
	@Produces(MediaType.APPLICATION_JSON)
	public StreamingOutput GetLocalService(@PathParam("service") String local_service_name);
	
	
}
