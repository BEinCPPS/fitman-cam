package msee.sp3.cm.api;

import msee.sp3.cm.api.resources.ServiceTemplateResource;
import msee.sp3.cm.api.resources.ServiceTemplatesResource;
import msee.sp3.cm.api.resources.UsdlRepositoriesResource;
import msee.sp3.cm.api.resources.UsdlRepositoryResource;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.cxf.jaxrs.client.WebClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.Assert;
import org.testng.annotations.Test;

import javax.ws.rs.core.Response;

/**
 *
 */
@Test(groups = "service-tests")
public class UsdlRepositoryApiTest {

    private Logger logger = LoggerFactory.getLogger(UsdlRepositoryApiTest.class);

    public static final String BASE_URL = "http://localhost:8080/cm-api/api/v1";

    public void createUsdlRepository() {
        UsdlRepositoryResource sp = new UsdlRepositoryResource();
        String name = RandomStringUtils.randomAlphabetic(7);
        sp.setName(name);
        sp.setUrl("http://www.msee.eu");
        Response wc = WebClient.create(BASE_URL).path("/usdlrepositories/").path(name).type("application/xml").put(sp);
        Assert.assertEquals(wc.getStatus(), 201);
    }

    public void getUsdlRepositories() {
        UsdlRepositoriesResource spr = WebClient.create(BASE_URL).path("/usdlrepositories").query("from", "0").
                            query("to", "-1").get(UsdlRepositoriesResource.class);
        Assert.assertNotNull(spr);
        logger.debug("Obtained {} usdl repositories", spr.getTotalNumberUsdlRepositories());
    }

    /// Requires a FiwareRepository instance at localhost:7081 - mvn tomcat6:run in Repository-RI folder
    public void uploadUsdl() {
        UsdlRepositoryResource sp = new UsdlRepositoryResource();
        String name = RandomStringUtils.randomAlphabetic(7);
        sp.setName(name);
        sp.setUrl("http://localhost:7081/FiwareRepository/v1");
        Response wc = WebClient.create(BASE_URL).path("/usdlrepositories/").path(name).type("application/xml").put(sp);
        Assert.assertEquals(wc.getStatus(), 201);

        String usdlId = RandomStringUtils.randomAlphabetic(7);
        Response response = WebClient.create(BASE_URL).path("/usdlrepositories/").path(name).path("/usdl/").path(usdlId).put("<THIS IS A TEST STRING>");
        Assert.assertEquals(response.getStatus(), Response.Status.OK.getStatusCode());
    }
}
