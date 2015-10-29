package msee.sp3.cm.repository.client;

import org.fiware.apps.repository.model.ResourceCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * @since 25/8/13 2:28
 */
@Test
public class RepositoryClientTest {

    public static final String REPOSITORY_URL = "http://localhost:7081/FiwareRepository/v1";

    private Logger logger = LoggerFactory.getLogger(RepositoryClientTest.class);

    public void repositoryCollectionWrite() {
        CollectionClient cc = new CollectionClient(REPOSITORY_URL);

        ResourceCollection rc = new ResourceCollection();
//        rc.setCreationDate(new Date());
        rc.setCreator("baggos");
//        rc.setId("/msee/");
        String randomName = "msee" + (Math.random()*10000000f);
        boolean success = cc.put("/msee/" + randomName + "/", rc);
        logger.info("Success is {}", success);
        Assert.assertTrue(success);
    }

    @Test
    public void resourceWrite() {
        ResourceClient rc = new ResourceClient(REPOSITORY_URL);
        boolean b = rc.insertResourceContentRDF("/msee2/blakentios", "/Users/bekiarisv/workspace/personal/msee/remote/github/Repository-RI/usdl1.ttl", "example/rdf+ttl");
        Assert.assertTrue(b);
    }

    @Test
    public void resourceWriteAndDelete() {
        ResourceClient rc = new ResourceClient(REPOSITORY_URL);
        logger.debug("resourceWriteAndDelete - 1");
        boolean result = rc.insertResourceContentRDF("/msee3/to-be-deleted", "/Users/bekiarisv/workspace/personal/msee/remote/github/Repository-RI/usdl1.ttl", "example/rdf+ttl");
        Assert.assertTrue(result);
//        logger.debug("resourceWriteAndDelete - 2");
//        result = rc.deleteResource("/msee3/to-be-deleted");
//        Assert.assertTrue(result);
//        CollectionClient cc = new CollectionClient(REPOSITORY_URL);
//        result = cc.delete("/msee3/");
//        Assert.assertTrue(result);
    }

    @Test
    public void resourceWriteString() {
        ResourceClient rc = new ResourceClient(REPOSITORY_URL);
        Boolean b = rc.insertResourceString("/msee4/string", "<usdl/>", "example/rdf+ttl");
        Assert.assertTrue(b);
//        b = rc.deleteResource("/msee4/string");
//        Assert.assertTrue(b);
//        CollectionClient cc = new CollectionClient(REPOSITORY_URL);
//        b = cc.delete("/msee4/");
//        Assert.assertTrue(b);
    }
}
