package it.eng.cam.test.rest;

import static com.eclipsesource.restfuse.Assert.assertOk;

import java.util.Random;
import java.util.ResourceBundle;

import org.junit.Assert;
import org.junit.Rule;
import org.junit.runner.RunWith;

import com.eclipsesource.restfuse.Destination;
import com.eclipsesource.restfuse.HttpJUnitRunner;
import com.eclipsesource.restfuse.Method;
import com.eclipsesource.restfuse.RequestContext;
import com.eclipsesource.restfuse.Response;
import com.eclipsesource.restfuse.annotation.Context;
import com.eclipsesource.restfuse.annotation.HttpTest;

@RunWith(HttpJUnitRunner.class)
public class RestTestIT extends Assert {

	@Rule
	public Destination destination = getDestination();

	@Context
	private Response response;

	private static ResourceBundle finder = ResourceBundle.getBundle("cam-service");
	private static int random = getNextRandom();

	private Destination getDestination() {
		Destination destination = new Destination(this, finder.getString("destination.url.integration"));
		RequestContext context = destination.getRequestContext();
		context.addPathSegment("rootName", "Thing").addPathSegment("classNameCreated", "New_Class_" + random)
				.addPathSegment("classNameMoved", "New_Class_2_" + random)
				.addPathSegment("assetNameCreated", "New_Asset_" + random)
				.addPathSegment("assetNameCreated2", "New_Asset_2_" + random)
				.addPathSegment("assetNameCreated3", "New_Asset_3_" + random)
				.addPathSegment("assetModelNameCreated", "New_Model_" + random)
				.addPathSegment("ownerNameCreated", "New_Owner_" + random)
				.addPathSegment("ownerNameCreated2", "New_Owner_2_" + random)
				.addPathSegment("relationShipNameCreated", "New_Relationship_" + random);
		return destination;
	}

	@HttpTest(method = Method.GET, path = "/", order = 1)
	public void testSayHello() {
		assertOk(response);
		assertTrue(response.getBody(), true);
	}

	@HttpTest(method = Method.GET, path = "/classes", order = 2)
	public void testGetClasses() {
		try {
			assertOk(response);
		} catch (Exception e) {
			assertFalse(e.getMessage(), true);
		}
	}

	@HttpTest(method = Method.GET, path = "/classes/{rootName}", order = 3)
	public void testGetIndividualsByClass() {
		assertOk(response);
	}

	// WARNING FAKE CONTENT IS NECESSARY for restfuse library more info at
	// https://github.com/eclipsesource/restfuse/issues/42
	@HttpTest(method = Method.POST, path = "/classes/{classNameCreated}/{rootName}", order = 4, content = "dummy")
	public void testCreateClass() {
		assertOk(response);
	}

	@HttpTest(method = Method.POST, path = "/classes/{classNameMoved}/{rootName}", order = 5, content = "dummy")
	public void testCreateClass2() {
		assertOk(response);
	}

	@HttpTest(method = Method.PUT, path = "/classes/{classNameMoved}/{classNameCreated}", order = 6, content = "dummy")
	public void testMoveClass() {
		assertOk(response);
	}

	@HttpTest(method = Method.DELETE, path = "/classes/{classNameMoved}", order = 7)
	public void testDeleteClass() {
		assertOk(response);
	}

	@HttpTest(method = Method.GET, path = "/classes/{classNameCreated}", order = 8)
	public void testGetIndividual() {
		assertOk(response);
	}

	@HttpTest(method = Method.POST, path = "/owners/{ownerNameCreated}", order = 9, content = "dummy")
	public void testCreateOwner() {
		assertOk(response);
	}

	@HttpTest(method = Method.POST, path = "/owners/{ownerNameCreated2}", order = 10, content = "dummy")
	public void testCreateOwner2() {
		assertOk(response);
	}

	@HttpTest(method = Method.POST, path = "/classes/model/{assetModelNameCreated}/{classNameCreated}/{ownerNameCreated}", order = 11, content = "dummy")
	public void testCreateAssetModel() {
		assertOk(response);
	}

	@HttpTest(method = Method.POST, path = "/classes/{assetNameCreated}/{assetModelNameCreated}/{ownerNameCreated}", order = 12, content = "dummy")
	public void testCreateAsset() {
		assertOk(response);
	}

	@HttpTest(method = Method.POST, path = "/classes/{assetNameCreated2}/{assetModelNameCreated}/{ownerNameCreated}", order = 13, content = "dummy")
	public void testCreateAsset2() {
		assertOk(response);
	}
	
	@HttpTest(method = Method.POST, path = "/classes/{assetNameCreated3}/{assetModelNameCreated}/{ownerNameCreated}", order = 14, content = "dummy")
	public void testCreateAsset3() {
		assertOk(response);
	}

	@HttpTest(method = Method.PUT, path = "/classes/{relationShipNameCreated}/{assetNameCreated}/{assetNameCreated2}", order = 15, content = "dummy")
	public void testSetRelationship() {
		assertOk(response);
	}

	@HttpTest(method = Method.DELETE, path = "/classes/individual/{assetNameCreated3}", order = 16)
	public void testDeleteIndividual() {
		assertOk(response);
	}

	// TODO
	// @HttpTest(method = Method.DELETE, path
	// ="/classes/{propertyName}/{assetName}", order = 0)
	public void testRemoveProperty() {
		assertOk(response);
	}

	@HttpTest(method = Method.GET, path = "/assets", order = 17)
	public void testGetIndividuals() {
		assertOk(response);
	}
	
	@HttpTest(method = Method.GET, path = "/assets/{assetNameCreated}", order = 18)
	public void testGetIndividualAttributes() {
		assertOk(response);
	}

	@HttpTest(method = Method.GET, path = "/owners", order = 19)
	public void testGetOwners() {
		assertOk(response);
	}

	@HttpTest(method = Method.DELETE, path = "/owners/{ownerNameCreated2}", order = 20)
	public void testDeleteOwner() {
		assertOk(response);
	}

	//@HttpTest(method = Method.POST, path = "/classes/attribute",
//			content = "{\"name\":\"New_Attribute_1\",\"individualName\":\"Massi_Asset\",\"value\":\"1354\",\"type\":\"java.lang.Integer\"}", order = 20)
	public void testSetAttribute() {
		assertOk(response);
	}

	@HttpTest(method = Method.GET, path = "/models", order = 22)
	public void testGetModels() {
		assertOk(response);
	}

	private static int getNextRandom() {
		Random rand = new Random();
		return Math.abs(rand.nextInt(Integer.MAX_VALUE));
	}

}
