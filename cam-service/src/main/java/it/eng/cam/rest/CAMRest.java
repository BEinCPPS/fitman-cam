package it.eng.cam.rest;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.eclipse.rdf4j.model.vocabulary.OWL;
import org.glassfish.jersey.server.ResourceConfig;

import it.eng.cam.rest.dto.AssetJSON;
import it.eng.cam.rest.dto.AssetModelJSON;
import it.eng.cam.rest.dto.AttributeJSON;
import it.eng.cam.rest.dto.ClassJSON;
import it.eng.cam.rest.dto.OwnerJSON;
import it.eng.cam.rest.dto.RelationshipJSON;
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

	// CLASSES

	@GET
	@Path("/classes")
	@Produces(MediaType.APPLICATION_JSON)
	public List<ClassItem> getClassHierarchy() {
		try {
			return CAMRestImpl.getClasses(SesameRepoInstance.getRepoInstance(getClass()), true);
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
			List<ClassItem> classes = CAMRestImpl.getClasses(SesameRepoInstance.getRepoInstance(getClass()), false);			
			classes = classes.stream().filter(item -> item.getNormalizedName().equalsIgnoreCase(className)).collect(Collectors.toList());
			if(classes != null && classes.size()>0){
			ClassItem superClass = classes.get(0);
			return superClass.getSubClasses();
			}else{
				return new ArrayList<ClassItem>();
			}
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@POST
	@Path("/classes")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response createClass(ClassJSON clazz) {
		try {
			CAMRestImpl.createClass(SesameRepoInstance.getRepoInstance(getClass()), clazz.getName(),
					clazz.getParentName());
			return Response.ok("Class with name '" + clazz.getName() + "' was successfully created!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@PUT
	@Path("/classes/{className}")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updateClass(@PathParam("className") String className, ClassJSON clazz) {
		try {
			if (!className.equalsIgnoreCase(clazz.getName())) {
				try {
					CAMRestImpl.renameClass(SesameRepoInstance.getRepoInstance(getClass()), className, clazz.getName());
				} catch (Exception e) {
					logger.error(e);
					throw new WebApplicationException(e.getMessage());
				} finally {
					SesameRepoInstance.releaseRepoDaoConn();
				}
				className = clazz.getName();
			}
			CAMRestImpl.moveClass(SesameRepoInstance.getRepoInstance(getClass()), className, clazz.getParentName());
			return Response.ok("Class with name '" + className + "' has parent Class " + clazz.getParentName()).build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@DELETE
	@Path("/classes/{className}")
	public Response deleteClass(@PathParam("className") String className) {
		try {
			CAMRestImpl.deleteClass(SesameRepoInstance.getRepoInstance(getClass()), className);
			return Response.ok("Class with name '" + className + "' was successfully deleted!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	// FINE CLASSES

	// ASSETS

	@GET
	@Path("/assets/{assetName}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<IndividualItem> getAssetByName(@PathParam("assetName") String assetName) {
		try {
			List<IndividualItem> assets = CAMRestImpl.getIndividuals(SesameRepoInstance.getRepoInstance(getClass()));
			if (null == assetName || "".equals(assetName.trim()))
				return assets.stream()
						.filter(asset -> !CAMRestImpl.isModel(getClass(), asset.getIndividualName())).collect(Collectors.toList());
			return assets.stream().filter(asset -> asset.getNormalizedName().equalsIgnoreCase(assetName))
					.collect(Collectors.toList());
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
	public List<IndividualItem> getAssetsForClass(@QueryParam("className") String className) {
		try {
			if (null == className)
				return getAssetByName(null);
			return CAMRestImpl.getIndividuals(SesameRepoInstance.getRepoInstance(getClass()), className).stream()
					.filter(asset -> !CAMRestImpl.isModel(getClass(), asset.getIndividualName())).collect(Collectors.toList());
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@POST
	@Path("/assets")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response createAsset(AssetJSON asset) {
		try {
			CAMRestImpl.createAsset(SesameRepoInstance.getRepoInstance(getClass()), asset.getName(),
					asset.getModelName(), asset.getOwnerName());
			return Response.ok("Asset with name '" + asset.getName() + "' for Model '" + asset.getModelName()
					+ "' for Owner '" + asset.getOwnerName() + "' was successfully created!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@PUT
	@Path("/assets/{assetName}")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updateAsset(@PathParam("assetName") String assetName, AssetJSON asset) {
		List<PropertyValueItem> individualAttributes = null;
		try {
			individualAttributes = CAMRestImpl.getIndividualAttributes(SesameRepoInstance.getRepoInstance(getClass()),
					assetName);
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
		if (individualAttributes != null) {
			try {
				CAMRestImpl.deleteIndividual(SesameRepoInstance.getRepoInstance(getClass()), assetName);
			} catch (Exception e) {
				logger.error(e);
				throw new WebApplicationException(e.getMessage());
			} finally {
				SesameRepoInstance.releaseRepoDaoConn();
			}
			try {
				CAMRestImpl.createAsset(SesameRepoInstance.getRepoInstance(getClass()), asset.getName(),
						asset.getModelName(), asset.getOwnerName());
				return Response.ok("Asset with name '" + asset.getName() + "' for Model '" + asset.getModelName()
						+ "' for Owner '" + asset.getOwnerName() + "' was successfully updated!").build();

			} catch (Exception e) {
				logger.error(e);
				throw new WebApplicationException(e.getMessage());
			} finally {
				SesameRepoInstance.releaseRepoDaoConn();
			}
		} else {
			return Response.notModified("Asset with name '" + asset.getName() + "' for Model '" + asset.getModelName()
					+ "' for Owner '" + asset.getOwnerName() + "' does not exist").build();
		}

	}

	@DELETE
	@Path("/assets/{assetName}")
	public Response deleteAsset(@PathParam("assetName") String assetName) {
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

	@GET
	@Path("/assets/{assetName}/attributes")
	@Produces(MediaType.APPLICATION_JSON)
	public List<PropertyValueItem> getIndividualAttributes(@PathParam("assetName") String assetName) {
		try {
			List<PropertyValueItem> individualAttributes = CAMRestImpl.getIndividualAttributes(SesameRepoInstance.getRepoInstance(getClass()), assetName);
			return individualAttributes.stream().filter(item -> !item.getNormalizedValue().equals(OWL.OBJECTPROPERTY.stringValue()) || item.getNormalizedName().contains("system")).collect(Collectors.toList());
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@GET
	@Path("/assets/{assetName}/attributes/{attributeName}")
	@Produces(MediaType.APPLICATION_JSON)
	public PropertyValueItem getIndividualAttribute(@PathParam("assetName") String assetName,
			@PathParam("attributeName") String attributeName) {
		try {
			List<PropertyValueItem> attrs = CAMRestImpl
					.getIndividualAttributes(SesameRepoInstance.getRepoInstance(getClass()), assetName);
			for (PropertyValueItem attr : attrs) {
				if (attr.getNormalizedName().equalsIgnoreCase(attributeName))
					return attr;
			}
			return null;
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@POST
	@Path("/assets/{assetName}/attributes/")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response setAttribute(@PathParam("assetName") String assetName, AttributeJSON attribute) {
		try {
			CAMRestImpl.setAttribute(SesameRepoInstance.getRepoInstance(getClass()), attribute.getName(), assetName,
					attribute.getValue(), attribute.getType());
			return Response.ok("Attribute with name '" + attribute.getName() + "'for individual '" + attribute.getName()
					+ "' and value '" + attribute.getValue() + "' of type '" + attribute.getType()
					+ "' was successfully added!").build();
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

	@PUT
	@Path("/assets/{assetName}/attributes/{attributeName}")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response setAttribute(@PathParam("assetName") String assetName,
			@PathParam("attributeName") String attributeName, AttributeJSON attribute) {
		try {
			CAMRestImpl.removeProperty(SesameRepoInstance.getRepoInstance(getClass()), assetName, attributeName);
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
		try {
			CAMRestImpl.setAttribute(SesameRepoInstance.getRepoInstance(getClass()), attribute.getName(), assetName,
					attribute.getValue(), attribute.getType());
			return Response.ok(
					"Attribute with name '" + attribute.getName() + "'for individual '" + assetName + "' and value '"
							+ attribute.getValue() + "' of type '" + attribute.getType() + "' was successfully added!")
					.build();
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
	@Path("/assets/{assetName}/attributes/{attributeName}")
	public Response removeAttribute(@PathParam("assetName") String assetName,
			@PathParam("attributeName") String attributeName) {
		try {
			CAMRestImpl.removeProperty(SesameRepoInstance.getRepoInstance(getClass()), assetName, attributeName);
			return Response.ok("Attribute with name '" + attributeName + "'for individual '" + assetName
					+ "' was successfully deleted!").build();
		} catch (IllegalArgumentException e) {
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

	@GET
	@Path("/assets/{assetName}/relationships")
	@Produces(MediaType.APPLICATION_JSON)
	public List<PropertyValueItem> getRelationships(@PathParam("assetName") String assetName) {
		try {
//			List<PropertyValueItem> retval = new ArrayList<PropertyValueItem>();
			List<PropertyValueItem> individualAttributes = CAMRestImpl
					.getIndividualAttributes(SesameRepoInstance.getRepoInstance(getClass()), assetName);
//			for (PropertyValueItem propertyValueItem : individualAttributes) {
//				if (propertyValueItem.getPropertyType().equals(OWL.OBJECTPROPERTY)) {
//					retval.add(propertyValueItem);
//				}
//			}
//			return retval;
			return individualAttributes.stream().filter(item -> item.getNormalizedValue().equals(OWL.OBJECTPROPERTY.stringValue()) && !item.getNormalizedName().contains("system")).collect(Collectors.toList());
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@GET
	@Path("/assets/{assetName}/relationships/{relationshipName}")
	@Produces(MediaType.APPLICATION_JSON)
	public PropertyValueItem getRelationship(@PathParam("assetName") String assetName,
			@PathParam("relationshipName") String relationshipName) {
		try {
			List<PropertyValueItem> individualAttributes = CAMRestImpl
					.getIndividualAttributes(SesameRepoInstance.getRepoInstance(getClass()), assetName);
			for (PropertyValueItem propertyValueItem : individualAttributes) {
				if (propertyValueItem.getNormalizedName().equalsIgnoreCase(relationshipName)) {
					return propertyValueItem;
				}
			}
			return null;
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@POST
	@Path("/assets/{assetName}/relationships")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response createRelationship(@PathParam("assetName") String assetName, RelationshipJSON relationship) {
		try {
			CAMRestImpl.setRelationship(SesameRepoInstance.getRepoInstance(getClass()), relationship.getName(),
					assetName, relationship.getReferredName());
			return Response.ok("Relation with name '" + relationship.getName() + "'between '" + assetName + "' and '"
					+ relationship.getReferredName() + "' was successfully created!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@PUT
	@Path("/assets/{assetName}/relationships/{relationshipName}")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updateRelationship(@PathParam("assetName") String assetName,
			@PathParam("relationshipName") String relationshipName, RelationshipJSON relationship) {
		try {
			CAMRestImpl.removeProperty(SesameRepoInstance.getRepoInstance(getClass()), assetName, relationshipName);
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
		try {
			CAMRestImpl.setRelationship(SesameRepoInstance.getRepoInstance(getClass()), relationship.getName(),
					assetName, relationship.getReferredName());
			return Response.ok("Relation with name '" + relationshipName + "'between '" + assetName + "' and '"
					+ relationship.getReferredName() + "' was successfully updated!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@DELETE
	@Path("/assets/{assetName}/relationships/{relationshipName}")
	public Response deleteRelationship(@PathParam("assetName") String assetName,
			@PathParam("relationshipName") String relationshipName) {
		try {
			CAMRestImpl.removeProperty(SesameRepoInstance.getRepoInstance(getClass()), assetName, relationshipName);
			return Response.ok("Relation with name '" + relationshipName + "'with '" + assetName
					+ "' was successfully deleted!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	// FINE ASSETS

	@GET
	@Path("/models/{modelName}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<IndividualItem> getModelByName(@PathParam("modelName") String modelName) {
		try {

			List<IndividualItem> models = CAMRestImpl.getIndividuals(SesameRepoInstance.getRepoInstance(getClass()));
			if (null == modelName)
				return models;
			return models.stream()
					.filter(model -> model.getNormalizedName().equalsIgnoreCase(modelName) && CAMRestImpl
							.isModel(getClass(), model.getIndividualName()))
					.collect(Collectors.toList());
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@GET
	@Path("/models")
	@Produces(MediaType.APPLICATION_JSON)
	public List<IndividualItem> getModelsForClass(@QueryParam("className") String className) {
		try {
			if (null == className)
				return getModelByName(null);
			List<IndividualItem> individuals = CAMRestImpl
					.getIndividuals(SesameRepoInstance.getRepoInstance(getClass()), className);
			return individuals.stream().filter(indiv -> CAMRestImpl
					.isModel(getClass(), indiv.getIndividualName()))
					.collect(Collectors.toList());
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@POST
	@Path("/models")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response createAssetModel(AssetModelJSON model) {
		try {
			CAMRestImpl.createAssetModel(SesameRepoInstance.getRepoInstance(getClass()), model.getName(),
					model.getClassName(), model.getOwnerName());
			return Response.ok("Model with name '" + model.getName() + "' for Model '" + model.getClassName()
					+ "' for Owner '" + model.getOwnerName() + "' was successfully created!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@PUT
	@Path("/models/{modelName}")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updateAssetModel(@PathParam("modelName") String modelName, AssetModelJSON model) {
		try {
			List<PropertyValueItem> individualAttributes = CAMRestImpl
					.getIndividualAttributes(SesameRepoInstance.getRepoInstance(getClass()), modelName);
			if (individualAttributes != null) {
				try {
					CAMRestImpl.deleteIndividual(SesameRepoInstance.getRepoInstance(getClass()), modelName);
				} catch (Exception e) {
					logger.error(e);
					throw new WebApplicationException(e.getMessage());
				} finally {
					SesameRepoInstance.releaseRepoDaoConn();
				}
				try {
					CAMRestImpl.createAssetModel(SesameRepoInstance.getRepoInstance(getClass()), model.getName(),
							model.getClassName(), model.getOwnerName());
					return Response.ok("Model with name '" + model.getName() + "' for Model '" + model.getClassName()
							+ "' for Owner '" + model.getOwnerName() + "' was successfully updated!").build();
				} catch (Exception e) {
					logger.error(e);
					throw new WebApplicationException(e.getMessage());
				} finally {
					SesameRepoInstance.releaseRepoDaoConn();
				}
			} else {
				return Response.notModified("Model with name '" + model.getName() + "' for Model '"
						+ model.getClassName() + "' for Owner '" + model.getOwnerName() + "' does not exist").build();
			}
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@DELETE
	@Path("/models/{modelName}")
	public Response deleteModel(@PathParam("modelName") String modelName) {
		try {
			CAMRestImpl.deleteIndividual(SesameRepoInstance.getRepoInstance(getClass()), modelName);
			return Response.ok("Model with name '" + modelName + "' was successfully deleted!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@GET
	@Path("/models/{modelName}/attributes")
	@Produces(MediaType.APPLICATION_JSON)
	public List<PropertyValueItem> getModelAttributes(@PathParam("modelName") String modelName) {
		try {
			List<PropertyValueItem> individualAttributes = CAMRestImpl.getIndividualAttributes(SesameRepoInstance.getRepoInstance(getClass()), modelName);
			return individualAttributes.stream().filter(item -> item.getNormalizedName().contains("system") || !item.getNormalizedValue().equals(OWL.OBJECTPROPERTY.stringValue())).collect(Collectors.toList());
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@GET
	@Path("/models/{modelName}/attributes/{attributeName}")
	@Produces(MediaType.APPLICATION_JSON)
	public PropertyValueItem getModelAttribute(@PathParam("modelName") String modelName,
			@PathParam("attributeName") String attributeName) {
		try {
			List<PropertyValueItem> attrs = CAMRestImpl
					.getIndividualAttributes(SesameRepoInstance.getRepoInstance(getClass()), modelName);
			for (PropertyValueItem attr : attrs) {
				if (attr.getNormalizedName().equalsIgnoreCase(attributeName))
					return attr;
			}
			return null;
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@POST
	@Path("/models/{modelName}/attributes/")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response setModelAttribute(@PathParam("modelName") String modelName, AttributeJSON attribute) {
		try {
			CAMRestImpl.setAttribute(SesameRepoInstance.getRepoInstance(getClass()), attribute.getName(), modelName,
					attribute.getValue(), attribute.getType());
			return Response.ok("Attribute with name '" + attribute.getName() + "'for individual '" + attribute.getName()
					+ "' and value '" + attribute.getValue() + "' of type '" + attribute.getType()
					+ "' was successfully added!").build();
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

	@PUT
	@Path("/models/{modelName}/attributes/{attributeName}")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response setModelAttribute(@PathParam("modelName") String modelName,
			@PathParam("attributeName") String attributeName, AttributeJSON attribute) {
		try {
			CAMRestImpl.removeProperty(SesameRepoInstance.getRepoInstance(getClass()), modelName, attributeName);
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
		try {
			CAMRestImpl.setAttribute(SesameRepoInstance.getRepoInstance(getClass()), attribute.getName(), modelName,
					attribute.getValue(), attribute.getType());
			return Response.ok(
					"Attribute with name '" + attribute.getName() + "'for individual '" + modelName + "' and value '"
							+ attribute.getValue() + "' of type '" + attribute.getType() + "' was successfully added!")
					.build();
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
	@Path("/models/{modelName}/attributes/{attributeName}")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response removeModelAttribute(@PathParam("modelName") String modelName,
			@PathParam("attributeName") String attributeName) {
		try {
			CAMRestImpl.removeProperty(SesameRepoInstance.getRepoInstance(getClass()), modelName, attributeName);
			return Response.ok("Attribute with name '" + attributeName + "'for individual '" + modelName
					+ "' was successfully deleted!").build();
		} catch (IllegalArgumentException e) {
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

	@GET
	@Path("/models/{modelName}/relationships")
	@Produces(MediaType.APPLICATION_JSON)
	public List<PropertyValueItem> getModelRelationships(@PathParam("modelName") String modelName) {
		try {
			List<PropertyValueItem> individualAttributes = CAMRestImpl
					.getIndividualAttributes(SesameRepoInstance.getRepoInstance(getClass()), modelName);
			return individualAttributes.stream().filter(item -> !item.getNormalizedName().contains("system") && item.getNormalizedValue().equals(OWL.OBJECTPROPERTY.stringValue())).collect(Collectors.toList());
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@GET
	@Path("/models/{modelName}/relationships/{relationshipName}")
	@Produces(MediaType.APPLICATION_JSON)
	public PropertyValueItem getModelRelationship(@PathParam("modelName") String modelName,
			@PathParam("relationshipName") String relationshipName) {
		try {
			List<PropertyValueItem> individualAttributes = CAMRestImpl
					.getIndividualAttributes(SesameRepoInstance.getRepoInstance(getClass()), modelName);
			for (PropertyValueItem propertyValueItem : individualAttributes) {
				if (propertyValueItem.getNormalizedName().equalsIgnoreCase(relationshipName)) {
					return propertyValueItem;
				}
			}
			return null;
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@POST
	@Path("/models/{modelName}/relationships")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response createModelRelationship(@PathParam("modelName") String modelName, RelationshipJSON relationship) {
		try {
			CAMRestImpl.setRelationship(SesameRepoInstance.getRepoInstance(getClass()), relationship.getName(),
					modelName, relationship.getReferredName());
			return Response.ok("Relation with name '" + relationship.getName() + "'between '" + modelName + "' and '"
					+ relationship.getReferredName() + "' was successfully created!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@PUT
	@Path("/models/{modelName}/relationships/{relationshipName}")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updateModelRelationship(@PathParam("modelName") String modelName,
			@PathParam("relationshipName") String relationshipName, RelationshipJSON relationship) {
		try {
			CAMRestImpl.removeProperty(SesameRepoInstance.getRepoInstance(getClass()), modelName, relationshipName);
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
		try {
			CAMRestImpl.setRelationship(SesameRepoInstance.getRepoInstance(getClass()), relationship.getName(),
					modelName, relationship.getReferredName());
			return Response.ok("Relation with name '" + relationshipName + "'between '" + modelName + "' and '"
					+ relationship.getReferredName() + "' was successfully updated!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@DELETE
	@Path("/models/{modelName}/relationships/{relationshipName}")
	public Response deleteModelRelationship(@PathParam("modelName") String modelName,
			@PathParam("relationshipName") String relationshipName) {
		try {
			CAMRestImpl.removeProperty(SesameRepoInstance.getRepoInstance(getClass()), modelName, relationshipName);
			return Response.ok("Relation with name '" + relationshipName + "'with '" + modelName
					+ "' was successfully deleted!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}
	// FINE MODELS

	// OWNERS

	@GET
	@Path("/owners/")
	@Produces(MediaType.APPLICATION_JSON)
	public List<OwnerJSON> getOwners() {
		try {
			List<OwnerJSON> retval = new ArrayList<OwnerJSON>();
			List<String> owners = CAMRestImpl.getOwners(SesameRepoInstance.getRepoInstance(getClass()));
//			if (null == ownerName || "".equalsIgnoreCase(ownerName))
				owners.forEach(item -> retval.add(new OwnerJSON(item)));
//			else
//				owners.stream().filter(owner -> owner.equalsIgnoreCase(ownerName)).collect(Collectors.toList())
//						.forEach(item -> retval.add(new OwnerJSON(item)));
			return retval;
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}
	
	@GET
	@Path("/owners/{ownerName}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<OwnerJSON> getOwner(@PathParam("ownerName") String ownerName) {
		try {
			List<OwnerJSON> retval = new ArrayList<OwnerJSON>();
			List<String> owners = CAMRestImpl.getOwners(SesameRepoInstance.getRepoInstance(getClass()));
			if (null == ownerName || "".equalsIgnoreCase(ownerName))
				owners.forEach(item -> retval.add(new OwnerJSON(item)));
			else
				owners.stream().filter(owner -> owner.equalsIgnoreCase(ownerName)).collect(Collectors.toList())
						.forEach(item -> retval.add(new OwnerJSON(item)));
			return retval;
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@POST
	@Path("/owners/")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response createOwner(OwnerJSON owner) {
		try {
			CAMRestImpl.createOwner(SesameRepoInstance.getRepoInstance(getClass()), owner.getName());
			return Response.ok("Owner with name '" + owner.getName() + "' was successfully created!").build();
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
	}

	@PUT
	@Path("/owners/{ownerName}")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updateOwner(@PathParam("ownerName") String ownerName, OwnerJSON owner) {
		try {
			CAMRestImpl.deleteOwner(SesameRepoInstance.getRepoInstance(getClass()), ownerName);
		} catch (Exception e) {
			logger.error(e);
			throw new WebApplicationException(e.getMessage());
		} finally {
			SesameRepoInstance.releaseRepoDaoConn();
		}
		try {
			CAMRestImpl.createOwner(SesameRepoInstance.getRepoInstance(getClass()), owner.getName());
			return Response.ok("Owner with name '" + owner.getName() + "' was successfully updated!").build();
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

	// FINE OWNERS

	@GET
	@Produces("text/html")
	public String summary(@Context HttpServletRequest httpRequest) {
		String content = "";
		StringBuilder contentBuilder = new StringBuilder();
		ResourceBundle finder = ResourceBundle.getBundle("cam-service");
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
			if (serverPort == 443)
				protocol = "https";
			content = content.replaceAll("camServiceUrl",
					protocol + "://" + serverUrl + ":" + serverPort + "/CAMService");
			content = content.replaceAll("artifactInfo",
					finder.getString("artifact.id") + " v" + finder.getString("version"));
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
