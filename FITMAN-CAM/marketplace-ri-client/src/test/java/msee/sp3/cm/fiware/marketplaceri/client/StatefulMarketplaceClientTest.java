package msee.sp3.cm.fiware.marketplaceri.client;

import msee.sp3.cm.fiware.marketplaceri.client.exception.AuthenticationException;
import msee.sp3.cm.fiware.marketplaceri.client.exception.UserAlreadyExistsException;
import org.apache.commons.lang.RandomStringUtils;
import org.fiware.apps.marketplace.model.Localuser;
import org.fiware.apps.marketplace.model.Service;
import org.fiware.apps.marketplace.model.Store;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.Assert;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import javax.ws.rs.NotFoundException;
import java.util.Date;
import java.util.List;

/**
 *
 */
public class StatefulMarketplaceClientTest {

    private static final Logger logger = LoggerFactory.getLogger(StatefulMarketplaceClientTest.class);

    private StatefulMarketplaceClient client;

    @BeforeMethod
    public void createInstance() {
        client = new StatefulMarketplaceClient();
    }

    @Test(dependsOnMethods = {"testStartSessionWithBuiltinPrincipal", "testSaveLocalUser"})
    public void testStartSession() throws Exception {
        client.startSessionWithBuiltinPrincipal(StatefulMarketplaceClient.DEFAULT_BASE_URL);
        Assert.assertEquals(client.isAuthenticatedAsLocaluser(), false);
        Assert.assertEquals(client.isAuthenticatedWithBuiltinPrincipal(), true);
        Localuser u = TestHelper.generateUser();
        client.saveLocalUser(u);
        client.startSession(StatefulMarketplaceClient.DEFAULT_BASE_URL, u.getUsername(), "1234");
        Assert.assertEquals(client.isAuthenticatedAsLocaluser(), true);
        Assert.assertEquals(client.isAuthenticatedWithBuiltinPrincipal(), false);
    }

    @Test
    public void testStartSessionWithBuiltinPrincipal() throws Exception {
        client.startSessionWithBuiltinPrincipal(StatefulMarketplaceClient.DEFAULT_BASE_URL);
        Assert.assertEquals(client.isAuthenticatedAsLocaluser(), false);
        Assert.assertEquals(client.isAuthenticatedWithBuiltinPrincipal(), true);
    }

    @Test
    public void testUpdateLocaluser() throws Exception {

    }

    @Test
    public void testDeleteLocaluser() throws Exception {
        client.startSessionWithBuiltinPrincipal(StatefulMarketplaceClient.DEFAULT_BASE_URL);
        Assert.assertEquals(client.isAuthenticatedAsLocaluser(), false);
        Assert.assertEquals(client.isAuthenticatedWithBuiltinPrincipal(), true);

        Localuser u = TestHelper.generateUser();
        client.saveLocalUser(u);

        // make sure user exists
        Localuser user = client.findLocaluser(u.getUsername());

        Assert.assertEquals(user.getEmail(), u.getEmail());
        Assert.assertEquals(user.getCompany(), u.getCompany());
        Assert.assertEquals(user.getUsername(), u.getUsername());
        Assert.assertEquals(user.getId(), u.getId());
        Assert.assertEquals(user.getPassword(), u.getPassword());

        // delete user
        client.deleteLocaluser(u.getUsername());

        try {
            client.findLocaluser(u.getUsername());
            Assert.fail("findLocalUser did not throw NotFoundException - delete failed");
        }
        catch (NotFoundException e){
            // expected
        }
    }

    @Test
    public void testFindLocaluser() throws Exception {

        client.startSessionWithBuiltinPrincipal(StatefulMarketplaceClient.DEFAULT_BASE_URL);
        Assert.assertEquals(client.isAuthenticatedAsLocaluser(), false);
        Assert.assertEquals(client.isAuthenticatedWithBuiltinPrincipal(), true);

        Localuser u = TestHelper.generateUser();
        client.saveLocalUser(u);

        Localuser user = client.findLocaluser(u.getUsername());

        Assert.assertEquals(user.getEmail(), u.getEmail());
        Assert.assertEquals(user.getCompany(), u.getCompany());
        Assert.assertEquals(user.getUsername(), u.getUsername());
        Assert.assertEquals(user.getId(), u.getId());
        Assert.assertEquals(user.getPassword(), u.getPassword());
    }

    @Test
    public void testFindLocalusers() throws Exception {
        client.startSessionWithBuiltinPrincipal(StatefulMarketplaceClient.DEFAULT_BASE_URL);
        List<Localuser> allUsers = client.findLocalusers();
        if (allUsers != null) {
            logger.info("{} users exist in local FIWARE DB", allUsers.size());
            for (Localuser u : allUsers) {
                logger.info("User: {}", u);
            }
        }
    }

    @Test
    public void testSaveLocalUser() throws Exception {
        client.startSessionWithBuiltinPrincipal(StatefulMarketplaceClient.DEFAULT_BASE_URL);
        Assert.assertEquals(client.isAuthenticatedAsLocaluser(), false);
        Assert.assertEquals(client.isAuthenticatedWithBuiltinPrincipal(), true);

        Localuser u = TestHelper.generateUser();
        client.saveLocalUser(u);
    }

    @Test
    public void testSaveStore() throws UserAlreadyExistsException, AuthenticationException {
        Localuser u = TestHelper.generateUser();
        client = TestHelper.initMarketplaceClientWithLocaluser(u);
        Store s = new Store();
        s.setCreator(u);
        s.setDescription("Super Duper store!");
        s.setName("store" + RandomStringUtils.randomAlphanumeric(5));
        s.setRegistrationDate(new Date());
        s.setUrl("http://www.thisdoesnotexist.gr/" + RandomStringUtils.randomAlphanumeric(5));
        client.saveStore(s);
    }

    @Test(dependsOnMethods = {"testFindStore"})
    public void testUpdateStore() throws UserAlreadyExistsException, AuthenticationException {
        Localuser u = TestHelper.generateUser();
        client = TestHelper.initMarketplaceClientWithLocaluser(u);
        Store s = new Store();
        s.setCreator(u);
        s.setDescription("Super Duper store!");
        s.setName("store" + RandomStringUtils.randomAlphanumeric(5));
        s.setRegistrationDate(new Date());
        s.setUrl("http://www.thisdoesnotexist.gr/" + RandomStringUtils.randomAlphanumeric(5));
        client.saveStore(s);

        // Ensure saved store is OK
        Store retrieved = client.findStore(s.getName());
        Assert.assertEquals(retrieved.getName(), s.getName());
        Assert.assertEquals(retrieved.getDescription(), s.getDescription());
        Assert.assertEquals(retrieved.getUrl(), s.getUrl());
        Assert.assertEquals(retrieved.getCreator(), s.getCreator());

        // now update
        s.setUrl("http://www.google.com/"+RandomStringUtils.randomAlphanumeric(5));
        client.updateStore(s.getName(), s);

        // ensure description is updated
        retrieved = client.findStore(s.getName());
        Assert.assertEquals(retrieved.getUrl(), s.getUrl());
    }


    @Test(dependsOnMethods = {"testSaveStore"})
    public void testFindStore() throws Exception {

        Localuser u = TestHelper.generateUser();
        client = TestHelper.initMarketplaceClientWithLocaluser(u);
        Store s = new Store();
        s.setCreator(u);
        s.setDescription("Super Duper store!");
        s.setName("store" + RandomStringUtils.randomAlphanumeric(5));
        s.setRegistrationDate(new Date());
        s.setUrl("http://www.thisdoesnotexist.gr/" + RandomStringUtils.randomAlphanumeric(5));
        client.saveStore(s);

        Store retrieved = client.findStore(s.getName());
        Assert.assertEquals(retrieved.getName(), s.getName());
        Assert.assertEquals(retrieved.getDescription(), s.getDescription());
        Assert.assertEquals(retrieved.getUrl(), s.getUrl());
        Assert.assertEquals(retrieved.getCreator(), s.getCreator());
    }

    @Test
    public void testSaveService() throws UserAlreadyExistsException, AuthenticationException {
        Localuser u = TestHelper.generateUser();
        client = TestHelper.initMarketplaceClientWithLocaluser(u);
        Store s = new Store();
        s.setCreator(u);
        s.setDescription("Super Duper store!");
        s.setName("store" + RandomStringUtils.randomAlphanumeric(5));
        s.setRegistrationDate(new Date());
        s.setUrl("http://www.thisdoesnotexist.gr/" + RandomStringUtils.randomAlphanumeric(5));
        client.saveStore(s);

        Service svc = new Service();
        svc.setName("TangibleAssetsService");
        svc.setDescription("Tangible Assets Service RDF v13");
        svc.setUrl("http://192.168.33.12/repos/BAO_v13_tangible.rdf");

        client.saveService(s.getName(), svc);
        logger.warn("Tangible Assets Service at store {}", s.getName());
    }
}
