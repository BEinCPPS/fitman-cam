package it.eng.cam.rest;

import java.util.List;
import java.util.stream.Collectors;

import it.eng.ontorepo.ClassItem;
import it.eng.ontorepo.IndividualItem;
import it.eng.ontorepo.PropertyValueItem;
import it.eng.ontorepo.RepositoryDAO;

public class CAMRestImpl {

	public static final String PREFIX = "http://www.w3.org/2002/07/owl#";

	
	public static ClassItem getClassHierarchy(RepositoryDAO dao) {
		return dao.getClassHierarchy();
	}
	
	public static List<ClassItem> getClasses(RepositoryDAO dao){
		ClassItem root = getClassHierarchy(dao);
		return root.getSubClasses();
	}

	public static List<IndividualItem> getIndividuals(RepositoryDAO dao) {
		return dao.getIndividuals();
	}

	public static List<String> getOwners(RepositoryDAO dao) {
		return dao.getOwners();
	}

//TODO
//	public static List<IndividualItem> getIndividuals(RepositoryDAO dao, String className) {
//		if(!isNormalized(className))
//			className = normalize(className);
//		return dao.getIndividuals(className);
//	}
	
	public static List<ClassItem> getIndividuals(RepositoryDAO dao, String className) {
		List<ClassItem> subClasses = dao.getClassHierarchy().getSubClasses();
		return subClasses.stream().filter(cls -> cls.getClassName().equals(className))
				.collect(Collectors.toList());
	}

	public static IndividualItem getIndividual(RepositoryDAO dao, String className) {
		if(!isNormalized(className))
			className = normalize(className);
		return dao.getIndividual(className);
	}

	public static void createClass(RepositoryDAO dao, String name, String parentName) {
		if(!isNormalized(parentName))
			parentName = normalize(parentName);
		dao.createClass(name, parentName);
	}

	public static void moveClass(RepositoryDAO dao, String name, String parentName) {
		dao.moveClass(name, parentName);
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
		dao.removeProperty(assetName, propertyName);

	}

	// TODO Test
	public static List<IndividualItem> getModelsIndividuals(RepositoryDAO dao) {
		// Neccessita di un filtro ulteriore per estrarre solo i modelli
		return dao.getIndividuals();
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

	/**
	 *  A name is normalized if contains the prefix http://www.w3.org/2002/07/owl#
	 * @param originalName 
	 * @return
	 */
	public static String normalize(String originalName) {
		return PREFIX + originalName;
	}
	
	public static boolean isNormalized(String value){
		return value.contains(PREFIX);
	}

	public static String deNormalize(String normalizedName) {
		String[] split = normalizedName.split(PREFIX);
		if (null != split && split.length > 0)
			return split[1];
		return normalizedName;
	}
	
	
}
