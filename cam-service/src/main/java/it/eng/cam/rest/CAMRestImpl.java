package it.eng.cam.rest;

import com.fasterxml.jackson.databind.ObjectMapper;
import it.eng.cam.rest.orion.AssetToContextTrasformer;
import it.eng.cam.rest.orion.ContextToAssetTransformer;
import it.eng.cam.rest.orion.OrionRestClient;
import it.eng.cam.rest.orion.context.ContextElement;
import it.eng.cam.rest.idas.AssetToIDASMappingTrasformer;
import it.eng.cam.rest.idas.IDASMappingContext;
import it.eng.cam.rest.orion.context.ContextResponse;
import it.eng.cam.rest.security.project.Project;
import it.eng.cam.rest.security.service.impl.IDMKeystoneService;
import it.eng.cam.rest.sesame.SesameRepoManager;
import it.eng.cam.rest.sesame.dto.AssetJSON;
import it.eng.ontorepo.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.eclipse.rdf4j.IsolationLevels;
import org.eclipse.rdf4j.repository.RepositoryConnection;

import java.net.MalformedURLException;
import java.text.ParseException;
import java.util.*;
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
                dao = releaseRepo(dao);
                List<Asset> assets = IndividualtemToAssetTransformer.transformAll(dao,
                        dao.getIndividualsForDomain(Util.getIdmURI(Constants.IDM_PROJECTS_PREFIX_WITH_SLASH + project.getId())), true);
                individualsToGive.addAll(assets);
            }
            return individualsToGive;
        } else
            return IndividualtemToAssetTransformer.transformAll(dao,
                    dao.getIndividualsForDomain(Util.getIdmURI(Constants.IDM_PROJECTS_PREFIX_WITH_SLASH + domainId)));
    }

    private static List<Project> extractLostDomainProjects(RepositoryDAO dao) {
        List<Project> projectsFromAssets = getProjectsFromAssets(dao);
        IDMKeystoneService idmKeystoneService = new IDMKeystoneService();
        final List<Project> projects = idmKeystoneService.getProjects();
        return projectsFromAssets.stream()
                .filter(project -> !projects.contains(project))
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
        try {
            dao.setAttribute(name, individualName, value, Class.forName(type));
            // sendContext(dao, individualName);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
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

    public static List<String> getTreePath(RepositoryDAO dao, String className) throws Exception {
        List<String> hierarchy = new ArrayList<String>();
        hierarchy.add(className); // add input class as a first element
        dao = SesameRepoManager.getRepoInstance(CAMRestImpl.class);
        List<ClassItem> classes = CAMRestImpl.getClasses(dao, false, false);
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
    }


    public static List<ContextElement> sendContexts(RepositoryDAO dao, List<AssetJSON> assetJSONs,
                                                    boolean isNew) throws Exception {
        if (assetJSONs == null || assetJSONs.isEmpty()) throw new IllegalArgumentException("No assets in input.");
        List<OrionConfig> orionConfigs = getOrionConfigs(dao);
        List<ContextElement> contextElements = null;
        try {
            contextElements = AssetToContextTrasformer.transformAll(dao, assetJSONs, true);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        List<ContextElement> contextElementsCreated = new ArrayList<>();
        if (null == contextElements || contextElements.isEmpty())
            throw new IllegalStateException("No assets transformed in contexts.");
        for (ContextElement contextElement : contextElements) {
            Optional<OrionConfig> configFound = orionConfigs.stream()
                    .filter(cfg -> cfg.getId().equals(contextElement.getOrionConfigId())).findAny();
            if (!configFound.isPresent() || configFound.get().isEmpty())
                throw new IllegalStateException("Orion configuration '" + contextElement.getOrionConfigId() + "' not exists.");
            OrionRestClient.postContext(configFound.get(), contextElement);
            dao = releaseRepo(dao);
            if (!dao.isIndividualConnectedToOrionConfig(contextElement.getOriginalAssetName(),
                    contextElement.getOrionConfigId()) && isNew)
                dao.connectIndividualToOrionConfig(contextElement.getOriginalAssetName(), contextElement.getOrionConfigId());
            contextElementsCreated.add(contextElement);
        }
        return contextElementsCreated;
    }


    public static void sendContext(RepositoryDAO dao, String individualName) throws Exception {
        if (StringUtils.isBlank(individualName))
            throw new IllegalArgumentException("No asset in input.");
        dao = releaseRepo(dao);
        IndividualItem individual = dao.getIndividual(individualName);
        if (null == individual) throw new IllegalStateException("Individual " + individualName + " not found.");
        AssetJSON assetJSON = new AssetJSON();
        assetJSON.setClassName(individual.getClassName());
        assetJSON.setName(individual.getIndividualName());
        String individualOrionConfig = dao.getIndividualOrionConfig(individualName);
        if (StringUtils.isBlank(individualOrionConfig)) return;
        assetJSON.setOrionConfigId(individualOrionConfig);
        List<AssetJSON> assets = new ArrayList<>();
        assets.add(assetJSON);
        dao = releaseRepo(dao);
        sendContexts(dao, assets, false);
    }


    public static void disconnectAssetsFromOrion(RepositoryDAO dao, String assetName) {
        if (assetName == null || assetName.isEmpty()) throw new IllegalArgumentException("No asset in input.");
        dao = releaseRepo(dao);
        dao.disconnectIndividualFromOrionConfig(assetName);
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
                String id = StringUtils.replace(domainUri, Constants.IDM_PROJECTS_PREFIX_WITH_SLASH, "");
                Project project = new Project();
                project.setId(id);
                project.setName(split[1]);
                projects.add(project);
            }
        }
        return projects;
    }

    public static List<OrionConfig> getOrionConfigs(RepositoryDAO dao) {
        List<String> orionConfigIds = dao.getOrionConfigs();
        List<OrionConfig> orionConfigs = new ArrayList<>();
        if (null != orionConfigIds && orionConfigIds.size() > 0) {
            for (String orionConfigId : orionConfigIds) {
                OrionConfig orionConfig = new OrionConfig();
                orionConfig.setId(orionConfigId);
                dao = releaseRepo(dao);
                List<PropertyValueItem> attributesByNS = dao.getAttributesByNS(orionConfigId, BeInCpps.SYSTEM_NS);
                if (null != attributesByNS && attributesByNS.size() > 0) {
                    for (PropertyValueItem attribute : attributesByNS) {
                        if (attribute.getNormalizedName().equalsIgnoreCase(OrionConfig.hasURL)
                                || attribute.getNormalizedName().equalsIgnoreCase(BeInCpps.SYSTEM_NS + OrionConfig.hasURL))
                            orionConfig.setUrl(attribute.getPropertyValue());
                        else if (attribute.getNormalizedName().equalsIgnoreCase(OrionConfig.hasService)
                                || attribute.getNormalizedName().equalsIgnoreCase(BeInCpps.SYSTEM_NS + OrionConfig.hasService))
                            orionConfig.setService(attribute.getPropertyValue());
                        else if (attribute.getNormalizedName().equalsIgnoreCase(OrionConfig.hasServicePath)
                                || attribute.getNormalizedName().equalsIgnoreCase(BeInCpps.SYSTEM_NS + OrionConfig.hasServicePath))
                            orionConfig.setServicePath(attribute.getPropertyValue());
                    }
                }
                orionConfigs.add(orionConfig);
            }
        }
        return orionConfigs;
    }

    public static List<OrionConfig> createOrionConfigs(RepositoryDAO dao, List<OrionConfig> orionConfigs) {
        List<OrionConfig> orionConfigsCreated = new ArrayList<>();
        if (orionConfigs == null || orionConfigs.size() == 0)
            throw new IllegalArgumentException("No orion configurations in input");
        for (OrionConfig orionConfig : orionConfigs) {
            if (orionConfig == null || orionConfig.isEmpty())
                throw new IllegalStateException("Orion configuration is not correct");
            dao.createOrionConfig(orionConfig);
            orionConfigsCreated.add(orionConfig);
        }

        return orionConfigsCreated;
    }

    public static void deleteOrionConfig(RepositoryDAO dao, String orionConfigId) {
        List<IndividualItem> individualsByOrionConfig = dao.getIndividualsByOrionConfig(orionConfigId);
        if (null != individualsByOrionConfig && individualsByOrionConfig.size() > 0) {
            throw new IllegalStateException("Orion Configuration cannot be deleted as it is referenced somewhere else.");
        }
        dao.deleteOrionConfig(orionConfigId);
    }


    //Transaction
    public static List<OrionConfig> editOrionConfigs(RepositoryDAO dao, List<OrionConfig> orionConfigs) {
        List<OrionConfig> orionConfigsCreated = new ArrayList<>();
        if (orionConfigs == null || orionConfigs.size() == 0)
            throw new IllegalArgumentException("No orion configurations in input");
        for (OrionConfig orionConfig : orionConfigs) {
            if (orionConfig == null || orionConfig.isEmpty())
                throw new IllegalStateException("Orion configuration is not correct");
            List<OrionConfig> orionConfigs1 = new ArrayList<>();
            orionConfigs1.add(orionConfig);
            dao.deleteOrionConfig(orionConfig.getId());
            dao.createOrionConfig(orionConfig);
            orionConfigsCreated.add(orionConfig);
        }
        return orionConfigsCreated;
    }


    public static void editAsset(RepositoryDAO dao, String assetName, AssetJSON assetJSON) throws MalformedURLException {
        if (!StringUtils.isBlank(assetJSON.getDomainName()))
            dao.setAttribute(BeInCpps.ownedBy, assetName, Util.getIdmURI(assetJSON.getDomainName()), null, BeInCpps.SYSTEM_NS);
        dao = releaseRepo(dao);
        if (!StringUtils.isBlank(assetJSON.getOrionConfigId()))
            dao.setAttribute(BeInCpps.syncTo, assetName, assetJSON.getOrionConfigId(), null, BeInCpps.SYSTEM_NS);
    }

    public static List<Asset> getAssetsForOrionConfig(RepositoryDAO dao, String orionConfig) throws Exception {
        if (StringUtils.isBlank(orionConfig))
            throw new IllegalArgumentException("Orion Config Id is mandatory");
        List<IndividualItem> individualsByOrionConfig = dao.getIndividualsByOrionConfig(orionConfig);
        return IndividualtemToAssetTransformer.transformAll(dao, individualsByOrionConfig);
    }

    public static String createIDASMappingFile(RepositoryDAO dao, List<AssetJSON> assetJSONs) throws Exception {
        if (null == assetJSONs || assetJSONs.isEmpty())
            throw new IllegalArgumentException("No Context in input");
        List<IDASMappingContext> contextElements = AssetToIDASMappingTrasformer.transformAll(dao, assetJSONs, false);
        if (null == contextElements || contextElements.isEmpty())
            throw new IllegalStateException("No assets transformed in contexts.");
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(contextElements);
    }

    public static void refreshAssetFromOCB(RepositoryDAO dao, final String assetName) throws Exception {
        if (StringUtils.isBlank(assetName))
            throw new Exception("Asset name is mandatory!");
        IndividualItem individual = dao.getIndividual(assetName);
        Asset asset = IndividualtemToAssetTransformer.transform(releaseRepo(dao), individual);
        List<OrionConfig> orionConfigs = getOrionConfigs(releaseRepo(dao));
        Optional<OrionConfig> orionConfig = orionConfigs.stream().filter(oc ->
                oc.getId().equals(asset.getConnectedToOrion())).findAny();
        if (!orionConfig.isPresent() || null == orionConfig.get() || orionConfig.get().isEmpty())
            throw new Exception("Could not determine Orion configuration for the Individual");
        final ContextResponse contextResponse = OrionRestClient.queryContext(orionConfig.get(),
                asset.getNormalizedName());
        if (null == contextResponse || null == contextResponse.getContextElement())
            throw new Exception("Data from OCB for the Individual not retrieved correctly!");

        ContextElement contextElement = contextResponse.getContextElement();
        contextElement.setOrionConfigId(orionConfig.get().getId());
        contextElement.setOriginalAssetName(asset.getOriginalName());
        contextElement.setDomainName(asset.getDomain());

        Asset assetRetrieved = ContextToAssetTransformer.transform(releaseRepo(dao), contextElement);
        if (null == assetRetrieved || StringUtils.isBlank(assetRetrieved.getIndividualName()))
            throw new Exception("Data from OCB for the Individual not transformed correctly!");
        dao = releaseRepo(dao);
        try {
            if (null != assetRetrieved.getAttributes() && !assetRetrieved.getAttributes().isEmpty())
                for (PropertyValueItem propertyValueItem : assetRetrieved.getAttributes()) {
                    if (propertyValueItem.getNormalizedName().startsWith(Constants.NGSI)) {
                        if (asset.getAttributes() != null) {
                            long count = asset.getAttributes().stream().filter(attOrig -> attOrig.getNormalizedName().equals(propertyValueItem.getNormalizedName())).count();
                            if (count > 0)
                                removeProperty(dao, assetRetrieved.getNormalizedName(), propertyValueItem.getNormalizedName());
                        }
                        setAttribute(dao, propertyValueItem.getNormalizedName(),
                                assetRetrieved.getNormalizedName(), propertyValueItem.getPropertyOriginalValue(),
                                propertyValueItem.getPropertyType().getName());
                    }
                }
        } catch (Exception e) {
            logger.error("Error in refreshing: " + e.getMessage());
            throw new Exception(e);
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

    private static RepositoryDAO releaseRepo(RepositoryDAO dao) {
//        SesameRepoManager.releaseRepoDaoConn(dao);
//        dao = SesameRepoManager.getRepoInstance(null);
        dao = SesameRepoManager.restartRepoDaoConn(dao);
        return dao;
    }

}
