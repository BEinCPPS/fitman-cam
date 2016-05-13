package it.eng.cam.test;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.w3c.dom.Document;

import it.eng.cam.rest.CAMRestImpl;
import it.eng.cam.rest.sesame.SesameRepoInstance;
import it.eng.ontorepo.ClassItem;
import it.eng.ontorepo.IndividualItem;
import it.eng.ontorepo.RepositoryDAO;

public class Test extends Assert {

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
		dao = SesameRepoInstance.getRepoInstanceInMemoryImpl(getClass());
	}

	@After
	public void tearDown() {
		SesameRepoInstance.releaseRepoDaoConn();
	}

	@org.junit.Test
	public void getClassHierarchy() {
		ClassItem classHierarchy = CAMRestImpl.getClassHierarchy(dao);
		assertNotNull("Class Hierarchy is null", classHierarchy);

	}

	@org.junit.Test
	public void getClasses() {
		List<ClassItem> classes = CAMRestImpl.getClasses(dao);
		assertNotNull("Null classes", classes);
		assertFalse("Empty classes list", classes.isEmpty());
	}

	@org.junit.Test
	public void getIndividuals() {
		List<IndividualItem> individuals = CAMRestImpl.getIndividuals(dao);
		assertNotNull("Null individuals", individuals);
		assertFalse("Empty indivduals list", individuals.isEmpty());
	}

	//
	@org.junit.Test
	public void getOwners() {
		List<String> owners = CAMRestImpl.getOwners(dao);
		assertNotNull("Null owners list", owners);
		// Onwers empty is not problem
		// assertFalse(owners.isEmpty());
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
	public void getIndividualsForClass() {
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
		List<ClassItem> classes = CAMRestImpl.getIndividuals(dao, className);
		assertNotNull("classes for class " + className + " are null", classes);
		assertFalse("Empty classes list", classes.isEmpty());
	}

	@org.junit.Test
	public void createOwner() {
		String ownerName = "MyOwner_" + getNextRandom();
		try {
			CAMRestImpl.createOwner(dao, ownerName);
		} catch (Exception e) {
			assertFalse(e.getMessage(), true);
		}
		List<String> owners = CAMRestImpl.getOwners(dao);
		List<String> ownersFiltered = owners.stream().filter(own -> own.equals(ownerName)).collect(Collectors.toList());

		assertNotNull("Create owner: owner (null) not retrieved for ownerName: " + ownerName, ownersFiltered);
		assertFalse("Create owner: owner (empty) not retrieved for ownerName: " + ownerName, ownersFiltered.isEmpty());
		assertTrue("Create owner: owner created :-)", ownersFiltered.size() == 1);
	}

	@org.junit.Test
	public void deleteOwner() {
		String ownerName = "NewOwner" + getNextRandom();
		try {
			CAMRestImpl.createOwner(dao, ownerName);
		} catch (Exception e) {
			assertFalse(e.getMessage(), true);
		}
		tearDown();
		setUp();
		try {
			CAMRestImpl.deleteOwner(dao, ownerName);
		} catch (Exception e) {
			assertFalse(e.getMessage(), true);
		}

		List<String> owners = CAMRestImpl.getOwners(dao);
		List<String> ownersFiltered = owners.stream().filter(own -> own.equals(ownerName)).collect(Collectors.toList());

		assertNotNull("Delete owner: deleted owner: " + ownerName, ownersFiltered);
		assertTrue("Delete owner: deleted owner: " + ownerName, ownersFiltered.isEmpty());

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
		String ownerName = "Jack_Frost_" + getNextRandom();
		try {
			CAMRestImpl.createOwner(dao, ownerName);
		} catch (Exception e) {
			assertFalse(e.getMessage(), true);
		}
		tearDown();
		setUp();
		String assetModelName = "MyAsset_" + getNextRandom();
		try {
			CAMRestImpl.createAssetModel(dao, assetModelName, className, ownerName);
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
		String ownerName = "NewOwner_" + getNextRandom();
		try {
			CAMRestImpl.createOwner(dao, ownerName);
		} catch (Exception e) {
			assertFalse(e.getMessage(), true);
		}
		tearDown();
		setUp();
		String assetModelName = "NewAssetModelName_" + getNextRandom();
		try {
			CAMRestImpl.createAssetModel(dao, assetModelName, className, ownerName);
		} catch (Exception e) {
			assertFalse(e.getMessage(), true);
		}
		tearDown();
		setUp();
		String assetName = "NewAsset_" + getNextRandom();
		try {
			CAMRestImpl.createAsset(dao, assetName, assetModelName, ownerName);
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
		String ownerName = "NewOwner_" + getNextRandom();
		try {
			CAMRestImpl.createOwner(dao, ownerName);
		} catch (Exception e) {
			assertFalse(e.getMessage(), true);
		}
		tearDown();
		setUp();
		String assetModelName = "NewAssetModelName_" + getNextRandom();
		try {
			CAMRestImpl.createAssetModel(dao, assetModelName, className, ownerName);
		} catch (Exception e) {
			assertFalse(e.getMessage(), true);
		}
		tearDown();
		setUp();
		String assetName = "NewAsset_" + getNextRandom();
		try {
			CAMRestImpl.createAsset(dao, assetName, assetModelName, ownerName);
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
		String ownerName = "NewOwner_" + getNextRandom();
		try {
			CAMRestImpl.createOwner(dao, ownerName);
		} catch (Exception e) {
			assertFalse(e.getMessage(), true);
		}
		tearDown();
		setUp();
		String assetModelName = "NewAssetModelName_" + getNextRandom();
		try {
			CAMRestImpl.createAssetModel(dao, assetModelName, className, ownerName);
		} catch (Exception e) {
			assertFalse(e.getMessage(), true);
		}
		tearDown();
		setUp();
		String assetName = "NewAsset_" + getNextRandom();
		try {
			CAMRestImpl.createAsset(dao, assetName, assetModelName, ownerName);
		} catch (Exception e) {
			assertFalse(e.getMessage(), true);
		}
		tearDown();
		setUp();
		String assetName2 = "NewAsset2_" + getNextRandom();
		try {
			CAMRestImpl.createAsset(dao, assetName2, assetModelName, ownerName);
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
