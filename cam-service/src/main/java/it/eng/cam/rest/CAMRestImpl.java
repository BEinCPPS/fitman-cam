package it.eng.cam.rest;

import java.util.List;

import it.eng.cam.rest.sesame.SesameRepoInstance;
import it.eng.ontorepo.ClassItem;
import it.eng.ontorepo.IndividualItem;
import it.eng.ontorepo.PropertyValueItem;
import it.eng.ontorepo.RepositoryDAO;
import it.eng.ontorepo.Util;

public class CAMRestImpl {

	public static final String PREFIX = "http://www.w3.org/2002/07/owl#";

	public static ClassItem getClassHierarchy(RepositoryDAO dao) {
		return dao.getClassHierarchy();
	}

	public static List<ClassItem> getClasses(RepositoryDAO dao, boolean checkNormalizedName) {
		ClassItem root = getClassHierarchy(dao);
		List<ClassItem> subClasses = root.getSubClasses();
		if(!checkNormalizedName)
			return subClasses;
		for (ClassItem classItem : subClasses) {
			if(classItem.getNormalizedName().contains("#")){
				String normName = classItem.getNormalizedName();
				if(null != normName && normName.contains("#") && !normName.contains("system"));
					normName= normName.substring(normName.indexOf("#")+1);
				classItem.setNormalizedName(normName);
			}
		}
		return subClasses;
	}

	public static List<IndividualItem> getIndividuals(RepositoryDAO dao) {
		return dao.getIndividuals();
	}

	public static List<String> getOwners(RepositoryDAO dao) {
		return dao.getOwners();
	}

	public static List<IndividualItem> getIndividuals(RepositoryDAO dao, String className) {
		return dao.getIndividuals(className);
	}

	public static IndividualItem getIndividual(RepositoryDAO dao, String className) {
		if (!isNormalized(className))
			className = normalize(className);
		return dao.getIndividual(className);
	}

	public static void createClass(RepositoryDAO dao, String name, String parentName) {
		if (null!=parentName && "Thing".equalsIgnoreCase(parentName.trim()) && !isNormalized(parentName))
			parentName = normalize(parentName);
		dao.createClass(name, parentName);
	}

	public static void moveClass(RepositoryDAO dao, String name, String parentName) {
//		if (!isNormalized(parentName))
//			parentName = normalize(parentName);
		dao.moveClass(name, parentName);
	}
	
	public static void renameClass(RepositoryDAO dao, String oldName, String newName){
		dao.renameClass(oldName, newName);
	}

	public static void deleteClass(RepositoryDAO dao, String name) {
		dao.deleteClass(name);
	}

	public static List<PropertyValueItem> getIndividualAttributes(RepositoryDAO dao, String assetName) {
		return dao.getIndividualAttributes(assetName);
	}

	public static void createAssetModel(RepositoryDAO dao, String name, String className, String ownerName) {
		dao.createAssetModel(name, className, ownerName);

	}

	public static void createAsset(RepositoryDAO dao, String name, String modelName, String ownerName) {
		dao.createAsset(name, modelName, ownerName);

	}

	public static void setRelationship(RepositoryDAO dao, String name, String individualName, String referredName) {
		dao.setRelationship(name, individualName, referredName);

	}

	public static void deleteIndividual(RepositoryDAO dao, String assetName) {
		dao.deleteIndividual(assetName);
	}

	// TODO Test
	public static void removeProperty(RepositoryDAO dao, String assetName, String propertyName) {
		dao.removeProperty(propertyName, assetName);

	}

	public static void createOwner(RepositoryDAO dao, String ownerName) {
		dao.createOwner(ownerName);
	}

	public static void deleteOwner(RepositoryDAO dao, String ownerName) {
		dao.deleteOwner(ownerName);

	}

	public static void setAttribute(RepositoryDAO dao, String name, String individualName, String value, String type)
			throws IllegalArgumentException, ClassNotFoundException, RuntimeException {
		dao.setAttribute(name, individualName, value, Class.forName(type));
	}
	

	public static boolean isModel(Class clazz, String individualName){
		SesameRepoInstance.releaseRepoDaoConn();
		List<PropertyValueItem> individualAttributes = SesameRepoInstance.getRepoInstance(clazz).getIndividualAttributes(individualName);
		String model =null;
		for (PropertyValueItem propertyValueItem : individualAttributes) {
			if(propertyValueItem.getNormalizedName().contains("instanceOf")){
				model = propertyValueItem.getNormalizedValue();
				break;
			}
		}
		if(null==model || "".equalsIgnoreCase(model.trim()))
			return true;
		return false;
	}

	/**
	 * A name is normalized if contains the prefix
	 * http://www.w3.org/2002/07/owl#
	 * 
	 * @param originalName
	 * @return
	 */
	public static String normalize(String originalName) {
		return PREFIX + originalName;
	}

	public static boolean isNormalized(String value) {
		return value.contains(PREFIX);
	}

	public static String deNormalize(String normalizedName) {
		String[] split = normalizedName.split(PREFIX);
		if (null != split && split.length > 0)
			return split[1];
		return normalizedName;
	}

}
