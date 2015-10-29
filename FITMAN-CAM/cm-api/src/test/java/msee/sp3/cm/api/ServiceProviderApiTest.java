package msee.sp3.cm.api;

import msee.sp3.cm.api.resources.ServiceProviderResource;
import msee.sp3.cm.api.resources.ServiceProvidersResource;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.cxf.jaxrs.client.WebClient;
import org.testng.Assert;
import org.testng.annotations.Test;

import javax.ws.rs.core.Response;

/**
 *
 */
@Test(groups = "service-tests")
public class ServiceProviderApiTest {

    public static final String BASE_URL = "http://localhost:8080/cm-api/api/v1";

    public void createSP() {
        ServiceProviderResource sp = new ServiceProviderResource();
        String name = RandomStringUtils.randomAlphabetic(7);
        sp.setEmail(name + "@msee.eu");
        sp.setUsername(name);
        sp.setCompany("MSEE");
        sp.setPassword("1234");
        Response wc = WebClient.create(BASE_URL).path("/serviceprovider/").path(name).type("application/xml").put(sp);
        Assert.assertEquals(wc.getStatus(), 201);
    }

    public void authenticateSP() {
        ServiceProviderResource spr = WebClient.create(BASE_URL).path("/authenticate").query("username", "test-account").
                            query("password", "1234").get(ServiceProviderResource.class);
    }
}
