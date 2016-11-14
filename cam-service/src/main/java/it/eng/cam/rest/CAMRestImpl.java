package it.eng.cam.rest;

import it.eng.cam.rest.security.project.Project;
import it.eng.cam.rest.security.service.Constants;
import it.eng.cam.rest.security.service.impl.IDMKeystoneService;
import it.eng.cam.rest.sesame.SesameRepoManager;
import it.eng.ontorepo.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import javax.ws.rs.WebApplicationException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class CAMRestImpl {
    private static final Logger logger = LogManager.getLogger(CAMRestImpl.class.getName());
    public static final String PREFIX = "http://www.w3.org/2002/07/owl#";

    public static ClassItem getClassHierarchy(RepositoryDAO dao) {
        return dao.getClassHierarchy();
    }

    public static List<ClassItem> getClasses(RepositoryDAO dao, boolean checkNormalizedName, boolean flat) {
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
        if (!flat)
            return subClasses.stream()
                    .filter(item -> (item.getNamespace()).equalsIgnoreCase(SesameRepoManager.getNamespace()))
                    .collect(Collectors.toList());
        else {
            List<ClassItem> results = new ArrayList<>();
            Map<String, Boolean> visited = new HashMap<>(); // null
            deepSearchFirstRecursive(dao, visited, root, results, false);
            return results.stream()
                    .filter(item -> (item.getNamespace()).equalsIgnoreCase(SesameRepoManager.getNamespace()))
                    .collect(Collectors.toList());
        }
    }

    public static List<Asset> getIndividuals(RepositoryDAO dao) throws Exception {
        return IndividualtemToAssetTransformer.transformAll(dao, dao.getIndividuals());
    }

    public static List<Asset> getIndividuals(RepositoryDAO dao, String className) throws Exception {
        return IndividualtemToAssetTransformer.transformAll(dao, dao.getIndividuals(className));
    }


    public static ClassItem deepSearchClasses(List<ClassItem> items, String className) {
        ClassItem retval = null;
        for (ClassItem classItem : items) {
            if (classItem.getNormalizedName().equalsIgnoreCase(className)) {
                return classItem;
            }
        }
        for (ClassItem classItem : items) {
            retval = deepSearchClasses(classItem.getSubClasses(), className);
            if (retval != null)
                return retval;
        }
        return null;
    }

    public static List<Asset> getIndividualsForChildren(RepositoryDAO dao, String className) throws Exception {
        return IndividualtemToAssetTransformer.transformAll(dao, dao.getIndividualsBySubClasses(className));
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

    public static void createAssetModel(RepositoryDAO dao, String name, String className, String domainName) {
        dao.createAssetModel(name, className, domainName);
    }

    public static void createAsset(RepositoryDAO dao, String name, String modelName, String domainName) {
        dao.createAsset(name, modelName, domainName);

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

    public static void removeProperty(RepositoryDAO dao, String assetName, String propertyName) {
        dao.removeProperty(propertyName, assetName);
    }

    public static List<Asset> getAssetsForDomain(RepositoryDAO dao, String domainId) throws Exception {
        if (Constants.NO_DOMAIN.equalsIgnoreCase(domainId)) {
            List<Asset> individualsToGive = new ArrayList<>();
            //Extract all asset without a domain with IDM IRI!
            List<IndividualItem> individuals = dao.getIndividualsNoDomain();
            for (IndividualItem individual :
                    individuals) {
                Asset asset = IndividualtemToAssetTransformer.transform(dao, individual);
                if (asset != null)
                    individualsToGive.add(asset);
            }
            dao = releaseRepo(dao);
            //Extract and insert Lost Domains assets!
            List<Project> projects = extractLostDomainProjects(dao);
            for (Project project :
                    projects) {
                List<Asset> assets = IndividualtemToAssetTransformer.transformAll(dao,
                        dao.getIndividualsForDomain(Constants.IDM_PROJECTS_PREFIX + "/" + project.getId()));
                individualsToGive.addAll(assets);
            }
            return individualsToGive;
        } else
            return IndividualtemToAssetTransformer.transformAll(dao, dao.getIndividualsForDomain(Constants.IDM_PROJECTS_PREFIX + "/" + domainId));
    }

    private static List<Project> extractLostDomainProjects(RepositoryDAO dao) {
        List<Project> projectsFromAssets = getProjectsFromAssets(dao);
        IDMKeystoneService idmKeystoneService = new IDMKeystoneService();
        final List<Project> projects = idmKeystoneService.getProjects();
        return projectsFromAssets.stream()
                .filter(projects::contains)
                .collect(Collectors.toList());
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
            hierarchy.add(className); // add input class as a first element
            repoInstance = SesameRepoManager.getRepoInstance(CAMRestImpl.class);
            List<ClassItem> classes = CAMRestImpl.getClasses(repoInstance, false, false);
            ClassItem clazz = CAMRestImpl.deepSearchClasses(classes, className);
            while (null != clazz.getSuperClass() && !clazz.getSuperClass().getNormalizedName().contains("Thing")) {
                // Add recursively ancestors of any class to build path
                String parentName = clazz.getSuperClass().getNormalizedName();
                hierarchy.add(parentName);
                clazz = CAMRestImpl.deepSearchClasses(classes, parentName);
            }
            List<String> retval = new ArrayList<String>();
            for (int i = hierarchy.size() - 1; i >= 0; i--) {// Invert order to
                // find father
                // in the first
                // position
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

    private static void deepSearchFirstRecursive(RepositoryDAO dao, Map<String, Boolean> visited, ClassItem clazz,
                                                 List results, boolean searchIndividuals) {
        visited.put(clazz.getNormalizedName(), true);
        int i = 0;
        for (ClassItem cls : clazz.getSubClasses()) {
            if (null == visited.get(cls.getNormalizedName()) || !visited.get(cls.getNormalizedName())) {
                if (searchIndividuals) {
                    if (i >= 0) {
                        dao = releaseRepo(dao);
                        i = 0;
                    }
                    results.addAll(dao.getIndividuals(cls.getNormalizedName()));
                    i++;
                } else {
                    results.add(cls);
                }
                deepSearchFirstRecursive(dao, visited, cls, results, searchIndividuals);
            }
        }
    }

    private static List<Project> getProjectsFromAssets(RepositoryDAO dao) {
        List<String> domains = dao.getProjects();
        return extractProjects(domains);
    }

    private static List<Project> extractProjects(List<String> domains) {
        List<Project> projects = new ArrayList<>();
        for (String domain :
                domains) {
            if (domain.contains("#")) {
                String[] split = domain.split("#");
                String domainUri = split[0];
                String id = StringUtils.replace(domainUri, Constants.IDM_PROJECTS_PREFIX, "");
                Project project = new Project();
                project.setId(id);
                project.setName(split[1]);
                projects.add(project);
            }
        }
        return projects;
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

    private static RepositoryDAO releaseRepo(RepositoryDAO dao) {
        SesameRepoManager.releaseRepoDaoConn(dao);
        dao = SesameRepoManager.getRepoInstance(null);
        return dao;
    }
}
