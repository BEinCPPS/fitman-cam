package it.eng.cam.rest;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.glassfish.jersey.server.ResourceConfig;

import it.eng.cam.rest.sesame.Attribute;
import it.eng.cam.rest.sesame.SesameRepoInstance;
import it.eng.ontorepo.ClassItem;
import it.eng.ontorepo.IndividualItem;
import it.eng.ontorepo.PropertyValueItem;

@Path("/")
public class CAMRest extends ResourceConfig {
	private static final Logger logger = LogManager.getLogger(CAMRest.class.getName());

	public CAMRest() {
		packages("it.eng.cam.rest");
	}

	@GET
	@Path("/classes")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ClassItem> getClassHierarchy() {
		try {
			return CAMRestImpl.getClasses(SesameRepoInstance.getRepoInstance(getClass()));
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@GET
	@Path("/classes/{className}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ClassItem> getIndividuals(@PathParam("className") String className) {
		try {
			return CAMRestImpl.getIndividuals(SesameRepoInstance.getRepoInstance(getClass()), className);
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@POST
	@Path("/classes/{name}/{parentName}")
	public Response createClass(@PathParam("name") String name, @PathParam("parentName") String parentName) {
		try {
			CAMRestImpl.createClass(SesameRepoInstance.getRepoInstance(getClass()), name, parentName);
			return Response.ok("Class with name '" + name + "' was successfully created!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@PUT
	@Path("/classes/{name}/{parentName}")
	public Response moveClass(@PathParam("name") String name, @PathParam("parentName") String parentName) {
		try {
			CAMRestImpl.moveClass(SesameRepoInstance.getRepoInstance(getClass()), name, parentName);
			return Response.ok("Class with name '" + name + "' has parent Class " + parentName).build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@DELETE
	@Path("/classes/{name}")
	public Response deleteClass(@PathParam("name") String name) {
		try {
			CAMRestImpl.deleteClass(SesameRepoInstance.getRepoInstance(getClass()), name);
			return Response.ok("Class with name '" + name + "' was successfully deleted!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@POST
	@Path("/classes/model/{name}/{className}/{ownerName}")
	public Response createAssetModel(@PathParam("name") String name, @PathParam("className") String className,
			@PathParam("ownerName") String ownerName) {
		try {
			CAMRestImpl.createAssetModel(SesameRepoInstance.getRepoInstance(getClass()), name, className, ownerName);
			return Response.ok("Asset Model with name '" + name + "' for Class '" + className + "' for Owner '"
					+ ownerName + "' was successfully created!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@POST
	@Path("/classes/{name}/{modelName}/{ownerName}")
	public Response createAsset(@PathParam("name") String name, @PathParam("modelName") String modelName,
			@PathParam("ownerName") String ownerName) {
		try {
			CAMRestImpl.createAsset(SesameRepoInstance.getRepoInstance(getClass()), name, modelName, ownerName);
			return Response.ok("Asset with name '" + name + "' for Model '" + modelName + "' for Owner '" + ownerName
					+ "' was successfully created!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@PUT
	@Path("/classes/{name}/{individualName}/{referredName}")
	public Response setRelationship(@PathParam("name") String name, @PathParam("individualName") String individualName,
			@PathParam("referredName") String referredName) {
		try {
			CAMRestImpl.setRelationship(SesameRepoInstance.getRepoInstance(getClass()), name, individualName,
					referredName);
			return Response.ok("Relation with name '" + name + "'between '" + individualName + "' and '" + referredName
					+ "' was successfully created!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@POST
	// @Path("/classes/{name}/{individualName}/{value}/{type}")
	@Path("/classes/attribute")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response setAttribute(Attribute attribute) {
		try {
			CAMRestImpl.setAttribute(SesameRepoInstance.getRepoInstance(getClass()), attribute.getName(),
					attribute.getIndividualName(), attribute.getValue(), attribute.getType());
			return Response.ok("Attribute with name '" + attribute.getName() + "'for individual '"
					+ attribute.getIndividualName() + "' and value '" + attribute.getValue() + "' of type '"
					+ attribute.getType() + "' was successfully added!").build();
		} catch (IllegalArgumentException e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} catch (ClassNotFoundException e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} catch (RuntimeException e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@DELETE
	@Path("/classes/individual/{assetName}")
	public Response deleteIndividual(@PathParam("assetName") String assetName) {
		try {
			CAMRestImpl.deleteIndividual(SesameRepoInstance.getRepoInstance(getClass()), assetName);
			return Response.ok("Individual with name '" + assetName + "' was successfully deleted!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@DELETE
	@Path("/classes/property/{propertyName}/{assetName}")
	public Response removeProperty(@PathParam("propertyName") String propertyName,
			@PathParam(" assetName") String assetName) {
		try {
			CAMRestImpl.removeProperty(SesameRepoInstance.getRepoInstance(getClass()), propertyName, assetName);
			return Response.ok(
					"Property with name '" + propertyName + "'for asset '" + assetName + "' was successfully removed!")
					.build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@GET
	@Path("/assets")
	@Produces(MediaType.APPLICATION_JSON)
	public List<IndividualItem> getIndividuals() {
		try {
			return CAMRestImpl.getIndividuals(SesameRepoInstance.getRepoInstance(getClass()));
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}
	
	@GET
	@Path("/assets/{assetName}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<PropertyValueItem> getIndividualAttributes(@PathParam("assetName") String assetName) {
		try {
			return CAMRestImpl.getIndividualAttributes(SesameRepoInstance.getRepoInstance(getClass()), assetName);
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}


	// TODO Da affinare
	@GET
	@Path("/models")
	@Produces(MediaType.APPLICATION_JSON)
	public List<IndividualItem> getModelsIndividuals() {
		try {
			return CAMRestImpl.getIndividuals(SesameRepoInstance.getRepoInstance(getClass()));
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
		// necessita di un filtro ulteriore
	}

	@GET
	@Path("/owners")
	@Produces(MediaType.APPLICATION_JSON)
	public List<String> getOwners() {
		try {
			return CAMRestImpl.getOwners(SesameRepoInstance.getRepoInstance(getClass()));
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@POST
	@Path("/owners/{ownerName}")
	public Response createOwner(@PathParam("ownerName") String ownerName) {
		try {
			CAMRestImpl.createOwner(SesameRepoInstance.getRepoInstance(getClass()), ownerName);
			return Response.ok("Owner with name '" + ownerName + "' was successfully created!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@DELETE
	@Path("/owners/{ownerName}")
	public Response deleteOwner(@PathParam("ownerName") String ownerName) {
		try {
			CAMRestImpl.deleteOwner(SesameRepoInstance.getRepoInstance(getClass()), ownerName);
			return Response.ok("Owner with name '" + ownerName + "' was successfully deleted!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@GET
	@Produces("text/html")
	public String summary(@Context HttpServletRequest httpRequest) {
		String content ="";
		StringBuilder contentBuilder = new StringBuilder();
		try {
			URL url = getClass().getResource("/summary.html");
			File file = new File(url.toURI());
			BufferedReader in = new BufferedReader(new FileReader(file));
			String str;
			while ((str = in.readLine()) != null) {
				contentBuilder.append(str);
			}
			in.close();
			content = contentBuilder.toString();
			String serverUrl = httpRequest.getServerName();
			int serverPort = httpRequest.getServerPort();
			String protocol = "http";
			if(serverPort == 443)
				protocol="https";
			content = content.replaceAll("camServiceUrl", protocol+"://"+serverUrl+":"+serverPort+"/CAMService");
		} catch (IOException e) {
			logger.error(e);
		} catch (URISyntaxException e) {
			logger.error(e);
		} catch (Exception e) {
			logger.error(e);
		}
		return content;
	}

}
