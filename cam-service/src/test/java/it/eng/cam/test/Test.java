package it.eng.cam.test;

import it.eng.cam.rest.CAMRestImpl;
import it.eng.cam.rest.Constants;
import it.eng.cam.rest.sesame.SesameRepoManager;
import it.eng.cam.rest.sesame.dto.AssetJSON;
import it.eng.ontorepo.*;
import org.junit.*;
import org.w3c.dom.Document;

import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

public class Test extends Assert {

    public static final String DOMAIN_NAME = Constants.IDM_PROJECTS_PREFIX + "/8388a90dc4fa494a8cefc11138da060c#Engineering";
    RepositoryDAO dao;

    @BeforeClass
    public static void oneTimeSetUp() {
        System.out.println("CAMService Test Starting......");
    }

    @AfterClass
    public static void oneTimeTearDown() {
        System.out.println("CAMService Test has ended!");
    }

    @Before
    public void setUp() {
        dao = SesameRepoManager.getRepoInstanceInMemoryImpl(getClass());
    }

    @After
    public void tearDown() {
        SesameRepoManager.releaseRepoDaoConn(dao);
    }

    @org.junit.Test
    public void getClassHierarchy() {
        ClassItem classHierarchy = CAMRestImpl.getClassHierarchy(dao);
        assertNotNull("Class Hierarchy is null", classHierarchy);

    }

    @org.junit.Test
    public void getClasses() {
        List<ClassItem> classes = CAMRestImpl.getClasses(dao, true, false);
        assertNotNull("Null classes", classes);
        assertFalse("Empty classes list", classes.isEmpty());
    }

    @org.junit.Test
    public void getIndividuals() {
        List<IndividualItem> individuals;
        try {
            String className = "NewClass_" + getNextRandom();
            ClassItem root = dao.getClassHierarchy();
            String parentName = root.getClassName();
            try {
                CAMRestImpl.createClass(dao, className, parentName);
            } catch (Exception e) {
                assertFalse(e.getMessage(), true);
            }
            tearDown();
            setUp();
            String assetModelName = "NewAssetModelName_" + getNextRandom();
            try {
                CAMRestImpl.createAssetModel(dao, assetModelName, className, DOMAIN_NAME);
            } catch (Exception e) {
                assertFalse(e.getMessage(), true);
            }
            tearDown();
            setUp();
            String assetName = "NewAsset_" + getNextRandom();
            try {
                CAMRestImpl.createAsset(dao, assetName, assetModelName, DOMAIN_NAME);
            } catch (Exception e) {
                assertFalse(e.getMessage(), true);
            }
            individuals = dao.getIndividuals();
            assertNotNull("Null individuals", individuals);
            assertFalse("Empty indivduals list", individuals.isEmpty());
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    // TODO Always Fail :-(
    // @org.junit.Test
    public void getIndividualForClassAndAsset() {
        String className = dao.getClassHierarchy().getClassName();
        String assetName = "New_Asset_" + getNextRandom();
        IndividualItem individual = CAMRestImpl.getIndividual(dao, className);
        assertNotNull("Individuals for class " + className + " are null", individual);
    }

    @org.junit.Test()
    public void createClass() {
        String name = "NewClass_" + getNextRandom();
        String parentName = dao.getClassHierarchy().getClassName();
        try {
            CAMRestImpl.createClass(dao, name, parentName);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        List<ClassItem> subClasses = dao.getClassHierarchy().getSubClasses();
        List<ClassItem> subClassesFiltered = subClasses.stream().filter(indiv -> indiv.getClassName().equals(name))
                .collect(Collectors.toList());

        assertNotNull("Create class: element created (null) not retrieved for className: " + name, subClassesFiltered);
        assertFalse("Create class: element created (empty) not retrieved for className: " + name,
                subClassesFiltered.isEmpty());
        assertTrue("Create class: element created found :-)", subClassesFiltered.size() == 1);
    }

    @org.junit.Test()
    public void deleteClass() {
        String name = "NewClass_" + getNextRandom();
        String parentName = dao.getClassHierarchy().getClassName();
        try {
            CAMRestImpl.createClass(dao, name, parentName);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        try {
            CAMRestImpl.deleteClass(dao, name);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        List<ClassItem> subClasses = dao.getClassHierarchy().getSubClasses();
        List<ClassItem> classInserted = subClasses.stream().filter(csi -> csi.getClassName().equals(name))
                .collect(Collectors.toList());
        assertNotNull("Delete class: element deleted for className: " + name, classInserted);
        assertTrue("Delete class: element deleted for className: " + name, classInserted.isEmpty());
    }

    @org.junit.Test()
    public void moveClass() {
        String className = "NewClass_" + getNextRandom();
        String rootName = dao.getClassHierarchy().getClassName(); // Thing
        try {
            CAMRestImpl.createClass(dao, className, rootName);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        String className2 = "NewClass_" + getNextRandom();
        try {
            CAMRestImpl.createClass(dao, className2, rootName);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        tearDown();
        setUp();
        try {
            CAMRestImpl.moveClass(dao, className2, className);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        List<ClassItem> subClasses = dao.getClassHierarchy().getSubClasses();
        List<ClassItem> classInserted = subClasses.stream().filter(csi -> csi.getClassName().equals(className))
                .collect(Collectors.toList());
        List<ClassItem> classInserted2 = null;

        try {
            classInserted2 = classInserted.get(0).getSubClasses().stream()
                    .filter(csi -> csi.getClassName().equals(className2)).collect(Collectors.toList());
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        assertNotNull("Move class: element moved (null) not retrieved for className: " + className, classInserted2);
        assertFalse("Move class: element moved (empty) not retrieved for className: " + className,
                classInserted2.isEmpty());
        assertTrue("Move class: element moved found :-)", classInserted2.size() == 1);
    }


    @org.junit.Test
    public void createAssetModel() {
        String className = "NewClass_" + getNextRandom();
        ClassItem root = dao.getClassHierarchy();
        String parentName = root.getClassName();
        try {
            CAMRestImpl.createClass(dao, className, parentName);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        tearDown();
        setUp();
        String assetModelName = "MyAsset_" + getNextRandom();
        try {
            CAMRestImpl.createAssetModel(dao, assetModelName, className, DOMAIN_NAME);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        List<IndividualItem> individuals = dao.getIndividuals();
        List<IndividualItem> individualsFiltered = individuals.stream()
                .filter(ind -> ind.getNormalizedName().equals(assetModelName)).collect(Collectors.toList());

        assertNotNull("Create asset model: asset model created (null) not retrieved with name: " + assetModelName,
                individualsFiltered);
        assertFalse("Create asset model: asset model created (empty) not retrieved with name: " + assetModelName
                + assetModelName, individualsFiltered.isEmpty());
        assertTrue("Create asset model: asset model created :-)", individualsFiltered.size() == 1);
    }

    @org.junit.Test
    public void createAsset() {
        String className = "NewClass_" + getNextRandom();
        ClassItem root = dao.getClassHierarchy();
        String parentName = root.getClassName();
        try {
            CAMRestImpl.createClass(dao, className, parentName);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        tearDown();
        setUp();
        String assetModelName = "NewAssetModelName_" + getNextRandom();
        try {
            CAMRestImpl.createAssetModel(dao, assetModelName, className, DOMAIN_NAME);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        tearDown();
        setUp();
        String assetName = "NewAsset_" + getNextRandom();
        try {
            CAMRestImpl.createAsset(dao, assetName, assetModelName, DOMAIN_NAME);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        List<IndividualItem> individuals = dao.getIndividuals();
        List<IndividualItem> individualsFiltered = individuals.stream()
                .filter(ind -> ind.getNormalizedName().equals(assetName)).collect(Collectors.toList());

        assertNotNull("Create asset: asset created (null) not retrieved with name: " + assetName, individualsFiltered);
        assertFalse("Create asset : asset created (empty) not retrieved with name: " + assetName + assetName,
                individualsFiltered.isEmpty());
        assertTrue("Create asset: asset created :-)", individualsFiltered.size() == 1);

    }

    @org.junit.Test
    public void deleteIndividual() {
        String className = "NewClass_" + getNextRandom();
        ClassItem root = dao.getClassHierarchy();
        String parentName = root.getClassName();
        try {
            CAMRestImpl.createClass(dao, className, parentName);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        tearDown();
        setUp();
        String assetModelName = "NewAssetModelName_" + getNextRandom();
        try {
            CAMRestImpl.createAssetModel(dao, assetModelName, className, DOMAIN_NAME);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        tearDown();
        setUp();
        String assetName = "NewAsset_" + getNextRandom();
        try {
            CAMRestImpl.createAsset(dao, assetName, assetModelName, DOMAIN_NAME);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        tearDown();
        setUp();

        try {
            CAMRestImpl.deleteIndividual(dao, assetName);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }

        List<IndividualItem> individuals = dao.getIndividuals();
        List<IndividualItem> individualsFiltered = individuals.stream()
                .filter(ind -> ind.getNormalizedName().equals(assetName)).collect(Collectors.toList());

        assertNotNull("Delete individual: element deleted for individual: " + assetName, individualsFiltered);
        assertTrue("Delete individual: element deleted for individual: " + assetName, individualsFiltered.isEmpty());
    }

    @org.junit.Test
    public void setRelationship() {
        String className = "NewClass_" + getNextRandom();
        ClassItem root = dao.getClassHierarchy();
        String parentName = root.getClassName();
        try {
            CAMRestImpl.createClass(dao, className, parentName);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        tearDown();
        setUp();
        String assetModelName = "NewAssetModelName_" + getNextRandom();
        try {
            CAMRestImpl.createAssetModel(dao, assetModelName, className, DOMAIN_NAME);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        tearDown();
        setUp();
        String assetName = "NewAsset_" + getNextRandom();
        try {
            CAMRestImpl.createAsset(dao, assetName, assetModelName, DOMAIN_NAME);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        tearDown();
        setUp();
        String assetName2 = "NewAsset2_" + getNextRandom();
        try {
            CAMRestImpl.createAsset(dao, assetName2, assetModelName, DOMAIN_NAME);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        tearDown();
        setUp();
        String relationshipName = "New_Relationship_" + getNextRandom();
        try {
            CAMRestImpl.setRelationship(dao, relationshipName, assetName, assetName2);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        // TEST by Exception
        boolean thrown = false;
        try {
            CAMRestImpl.deleteIndividual(dao, assetName2);
        } catch (IllegalStateException e) {
            thrown = true;
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        assertTrue("Relationship exists!", thrown);
    }


    @org.junit.Test
    public void getIndividualsForClass() {
        String className = "NewClass_" + getNextRandom();
        String rootName = dao.getClassHierarchy().getClassName(); // Thing
        try {
            CAMRestImpl.createClass(dao, className, rootName);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        tearDown();
        setUp();
        String assetModelName = "MyAsset_" + getNextRandom();
        try {
            CAMRestImpl.createAssetModel(dao, assetModelName, className, DOMAIN_NAME);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        tearDown();
        setUp();
        String assetName = "NewAsset_" + getNextRandom();
        try {
            CAMRestImpl.createAsset(dao, assetName, assetModelName, DOMAIN_NAME);
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
        List<IndividualItem> individuals;
        try {
            individuals = dao.getIndividuals();
            assertNotNull("individuals for class " + className + " are null", individuals);
            assertFalse("Empty individuals list", individuals.isEmpty());
            tearDown();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    @org.junit.Test
    public void createOrionConfigs() {
        try {
            List<OrionConfig> orionConfigs = new ArrayList<>();
            OrionConfig orionConfig = new OrionConfig();
            orionConfig.setId("orionConfig_" + getNextRandom());
            orionConfig.setUrl("http://orion.fiware.org");
            orionConfigs.add(orionConfig);
            List<OrionConfig> orionConfigsRet = CAMRestImpl.createOrionConfigs(dao, orionConfigs);
            assertNotNull("Orion Context Broker configurations are null", orionConfigsRet);
            assertFalse("Empty Orion Context Broker configurations list", orionConfigsRet.isEmpty());
            assertSame(orionConfig, orionConfigsRet.get(0));
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
    }

    @org.junit.Test
    public void deleteOrionConfig() {
        try {
            List<OrionConfig> orionConfigs = new ArrayList<>();
            OrionConfig orionConfig = new OrionConfig();
            orionConfig.setId("orionConfig_" + getNextRandom());
            orionConfig.setUrl("http://orion.fiware.org");
            orionConfigs.add(orionConfig);
            List<OrionConfig> orionConfigsRet = CAMRestImpl.createOrionConfigs(dao, orionConfigs);
            tearDown();
            setUp();
            CAMRestImpl.deleteOrionConfig(dao, orionConfig.getId());
        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }

    }

   //@org.junit.Test
    public void createIDASMappingFile() {
        try {
            String className = "NewClass_" + getNextRandom();
            ClassItem root = dao.getClassHierarchy();
            String parentName = root.getClassName();
            try {
                CAMRestImpl.createClass(dao, className, parentName);
            } catch (Exception e) {
                assertFalse(e.getMessage(), true);
            }
            tearDown();
            setUp();
            String assetModelName = "NewAssetModelName_" + getNextRandom();
            try {
                CAMRestImpl.createAssetModel(dao, assetModelName, className, DOMAIN_NAME);
            } catch (Exception e) {
                assertFalse(e.getMessage(), true);
            }
            tearDown();
            setUp();
            String assetName = "NewAsset_" + getNextRandom();
            try {
                CAMRestImpl.createAsset(dao, assetName, assetModelName, DOMAIN_NAME);
            } catch (Exception e) {
                assertFalse(e.getMessage(), true);
            }
            IndividualItem individual = dao.getIndividual(assetName);
            List<IndividualItem> individuals = dao.getIndividuals();
            List<IndividualItem> individualsFiltered = individuals.stream()
                    .filter(ind -> ind.getNormalizedName().equals(assetName)).collect(Collectors.toList());

            List<AssetJSON> assetJSONS = individualsFiltered.stream().map(indiv -> {
                AssetJSON assetJSON = new AssetJSON();
                assetJSON.setName(indiv.getIndividualName());
                return assetJSON;
            }).collect(Collectors.toList());
            tearDown();
            setUp();
            String idasMappingFileJSON = CAMRestImpl.createIDASMappingFile(dao, assetJSONS);
            assertNotNull(idasMappingFileJSON);
            assertNotEquals(idasMappingFileJSON,"");

        } catch (Exception e) {
            assertFalse(e.getMessage(), true);
        }
    }

    private int getNextRandom() {
        Random rand = new Random();
        return Math.abs(rand.nextInt(Integer.MAX_VALUE));
    }

    @SuppressWarnings("unused")
    private void printDocument(Document doc, String file) {
        try {
            OutputStream out = new FileOutputStream(file);
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "no");
            transformer.setOutputProperty(OutputKeys.METHOD, "xml");
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
            transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");
            transformer.transform(new DOMSource(doc), new StreamResult(new OutputStreamWriter(out, "UTF-8")));
        } catch (IllegalArgumentException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (TransformerFactoryConfigurationError e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (TransformerConfigurationException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (TransformerException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


}
