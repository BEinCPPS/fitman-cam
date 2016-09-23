package it.eng.cam.rest;

import java.util.*;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.ws.rs.WebApplicationException;

import it.eng.ontorepo.*;
import it.eng.ontorepo.sesame2.Sesame2RepositoryDAO;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import it.eng.cam.rest.sesame.SesameRepoManager;

public class CAMRestImpl {
    private static final Logger logger = LogManager.getLogger(CAMRestImpl.class.getName());
    public static final String PREFIX = "http://www.w3.org/2002/07/owl#";

    public static ClassItem getClassHierarchy(RepositoryDAO dao) {
        return dao.getClassHierarchy();
    }

    public static List<ClassItem> getClasses(RepositoryDAO dao, boolean checkNormalizedName) {
        ClassItem root = getClassHierarchy(dao);
        List<ClassItem> subClasses = root.getSubClasses();
        if (!checkNormalizedName)
            return subClasses;
        for (ClassItem classItem : subClasses) {
            if (classItem.getNormalizedName().contains("#")) {
                String normName = classItem.getNormalizedName();
                classItem.setNormalizedName(normalizeClassName(normName));
            }
        }
        return subClasses.stream()
                .filter(item -> (item.getNamespace()).equalsIgnoreCase(SesameRepoManager.getNamespace()))
                .collect(Collectors.toList());
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


    public static List<IndividualItem> getIndividualsForChildren(RepositoryDAO dao, String className) {
        List<IndividualItem> results = new ArrayList<>();
        //Add assets for class Father
        results.addAll(dao.getIndividuals(className));
        //Add assets for children. nephews etc....
        List<ClassItem> classes = CAMRestImpl.getClasses(dao, false);
        ClassItem fatherClass = CAMRestImpl.deepSearchClasses(classes, className);
        retrieveAssetsForChildren(dao, fatherClass, results);
        return results;
    }

    private static void retrieveAssetsForChildren(RepositoryDAO dao, ClassItem clazz, List<IndividualItem> results) {
        try {
            if (clazz == null || clazz.getSubClasses() == null || clazz.getSubClasses().size() == 0) return;
            int i = 0;
            for (ClassItem childClazz : clazz.getSubClasses()) {
                // ascatox 23-09-2016
                // This is needed to solve an issue present in rdf4j after 4 query it blocks!!!
                if (i >= 3) {
                    SesameRepoManager.releaseRepoDaoConn(dao);
                    dao = SesameRepoManager.getRepoInstance(null);
                    i = 0;
                }
                String childClassName = childClazz.getNormalizedName();
                results.addAll(dao.getIndividuals(childClassName));
                retrieveAssetsForChildren(dao, childClazz, results);
                i++;
            }
        } catch (Exception ex) {
            logger.error(ex);
        }
    }

    public static IndividualItem getIndividual(RepositoryDAO dao, String className) {
        if (!isNormalized(className))
            className = normalize(className);
        return dao.getIndividual(className);
    }

    public static void createClass(RepositoryDAO dao, String name, String parentName) {
        if (null != parentName && "Thing".equalsIgnoreCase(parentName.trim()) && !isNormalized(parentName))
            parentName = normalize(parentName);
        dao.createClass(name, parentName);
    }

    public static void moveClass(RepositoryDAO dao, String name, String parentName) {
        // if (!isNormalized(parentName))
        // parentName = normalize(parentName);
        dao.moveClass(name, parentName);
    }

    public static void renameClass(RepositoryDAO dao, String oldName, String newName) {
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
        List<PropertyValueItem> individualAttributes = dao.getIndividualAttributes(individualName);
        List<PropertyValueItem> relFound = individualAttributes.stream()
                .filter(item -> item.getNormalizedName().equalsIgnoreCase(name)).collect(Collectors.toList());
        if (null != relFound && !relFound.isEmpty()) {
            throw new RuntimeException("This individual already has the property " + name);
        }
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
        List<PropertyValueItem> individualAttributes = dao.getIndividualAttributes(individualName);
        List<PropertyValueItem> attrFound = individualAttributes.stream()
                .filter(item -> item.getNormalizedName().equalsIgnoreCase(name)).collect(Collectors.toList());
        if (null != attrFound && !attrFound.isEmpty()) {
            throw new RuntimeException("This individual already has the property " + name);
        }
        dao.setAttribute(name, individualName, value, Class.forName(type));
    }

    public static boolean isModel(RepositoryDAO dao, Class clazz, String individualName) {
        SesameRepoManager.releaseRepoDaoConn(dao);
        dao = SesameRepoManager.getRepoInstance(clazz);
        List<PropertyValueItem> individualAttributes = dao.getIndividualAttributes(individualName);
        String model = null;
        for (PropertyValueItem propertyValueItem : individualAttributes) {
            if (propertyValueItem.getNormalizedName().contains("instanceOf")) {
                model = propertyValueItem.getNormalizedValue();
                break;
            }
        }
        if (null == model || "".equalsIgnoreCase(model.trim()))
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

    public static ClassItem deepSearchClasses(List<ClassItem> items, String className) {
        ClassItem retval = null;
        for (ClassItem classItem : items) {
            if (classItem.getNormalizedName().equalsIgnoreCase(className)) {
                return classItem;
            }
        }
//        for (ClassItem classItem : items) {
//            retval = deepSearchClasses(classItem.getSubClasses(), className);
//            if (retval != null)
//                return retval;
//        }
        return null;
    }

    public static List<PropertyDeclarationItem> getAttributes(RepositoryDAO dao) {
        List<PropertyDeclarationItem> attributes = dao.getAttributes();
        List<PropertyDeclarationItem> collectedAttributes = attributes.stream()
                .filter(attr -> (attr.getNamespace().equalsIgnoreCase(SesameRepoManager.getNamespace())
                        && !isURI(attr.getNormalizedName())))
                .collect(Collectors.toList());
        return collectedAttributes;
    }

    public static List<String> getTreePath(String className) {
        RepositoryDAO repoInstance = null;
        try {
            List<String> hierarchy = new ArrayList<String>();
            hierarchy.add(className); //add input class as a first element
            repoInstance = SesameRepoManager.getRepoInstance(CAMRestImpl.class);
            List<ClassItem> classes = CAMRestImpl.getClasses(repoInstance, false);
            ClassItem clazz = CAMRestImpl.deepSearchClasses(classes, className);
            while (null != clazz.getSuperClass() && !clazz.getSuperClass().getNormalizedName().contains("Thing")) {
                // Add recursively ancestors of any class to build path
                String parentName = clazz.getSuperClass().getNormalizedName();
                hierarchy.add(parentName);
                clazz = CAMRestImpl.deepSearchClasses(classes, parentName);
            }
            List<String> retval = new ArrayList<String>();
            for (int i = hierarchy.size() - 1; i >= 0; i--) {//Invert order to find father in the first position
                retval.add(hierarchy.get(i));
            }
            return retval;
        } catch (Exception e) {
            logger.error(e);
            throw new WebApplicationException(e.getMessage());
        } finally {
            SesameRepoManager.releaseRepoDaoConn(repoInstance);
        }
    }


    private static String normalizeClassName(String normName) {
        if (null != normName && normName.contains("#") && !normName.contains("system"))
            return normName.substring(normName.indexOf("#") + 1);
        return normName;
    }

    private static boolean isURI(String normName) {
        if (null != normName && normName.contains("#"))
            return true;
        return false;
    }


}
