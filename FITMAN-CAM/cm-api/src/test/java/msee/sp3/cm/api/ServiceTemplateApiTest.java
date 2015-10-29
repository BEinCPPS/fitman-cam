package msee.sp3.cm.api;

import msee.sp3.cm.api.resources.*;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.cxf.jaxrs.client.WebClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.Assert;
import org.testng.annotations.Test;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 */
@Test(groups = "service-tests")
public class ServiceTemplateApiTest {

    private Logger logger = LoggerFactory.getLogger(ServiceTemplateApiTest.class);

    public static final String BASE_URL = "http://localhost:8080/cm-api/api/v1";

    public void createServiceTemplate() {
        ServiceTemplateResource sp = new ServiceTemplateResource();
        String name = RandomStringUtils.randomAlphabetic(7);
        sp.setName(name);
        sp.setTemplateText("1234");
        Response wc = WebClient.create(BASE_URL).path("/servicetemplates/").path(name).type("application/xml").put(sp);
        Assert.assertEquals(wc.getStatus(), 201);
    }

    public void getServiceTemplates() {
        ServiceTemplatesResource spr = WebClient.create(BASE_URL).path("/servicetemplates").query("from", "0").
                            query("to", "-1").get(ServiceTemplatesResource.class);
        Assert.assertNotNull(spr);
        logger.debug("Obtained {} service templates", spr.getTotalNumberServiceTemplates());
    }

    public void getServiceVariables() {
        ServiceTemplateResource sp = new ServiceTemplateResource();
        String name = RandomStringUtils.randomAlphabetic(7);
        sp.setName(name);
        sp.setTemplateText("<?xml version=\"1.0\" xmlns:rdf=\"http://test.com\">\n" +
                "<usdl:Service rdf:about=\"${serviceAbout}\">\n" +
                "<dcterms:abstract xml:lang=\"en\">\n" +
                "${serviceAbstract}\n" +
                "</dcterms:abstract>" +
                "</usdl:service>");
        Response wc = WebClient.create(BASE_URL).path("/servicetemplates/").path(name).type("application/xml").put(sp);
        Assert.assertEquals(wc.getStatus(), 201);

        ServiceTemplateVariables varNames = WebClient.create(BASE_URL).path("/servicetemplates/").
                path(name).path("/variables").type("application/xml").get(ServiceTemplateVariables.class);
        Assert.assertNotNull(varNames);
        Assert.assertEquals(varNames.getVariables().size(), 2);
        Assert.assertTrue(varNames.getVariables().contains("serviceAbout"));
        Assert.assertTrue(varNames.getVariables().contains("serviceAbstract"));
    }

    public void instantiateServiceTemplate() {

        // create a standard template
        ServiceTemplateResource sp = new ServiceTemplateResource();
        String name = RandomStringUtils.randomAlphabetic(7);
        sp.setName(name);
        sp.setTemplateText("<?xml version=\"1.0\" xmlns:rdf=\"http://test.com\">\n" +
                "<usdl:Service rdf:about=\"${serviceAbout}\">\n" +
                "<dcterms:abstract xml:lang=\"en\">\n" +
                "${serviceAbstract}\n" +
                "</dcterms:abstract>" +
                "</usdl:service>");
        Response wc = WebClient.create(BASE_URL).path("/servicetemplates/").path(name).type("application/xml").put(sp);
        Assert.assertEquals(wc.getStatus(), 201);

        // now instantiate the template
        ServiceTemplateInstantiationRequest req = new ServiceTemplateInstantiationRequest();
        Map<String, String> vars = new HashMap<String, String>();
        vars.put("serviceAbout", "http://www.bivolino.com/DCS-2500");
        vars.put("serviceAbstract", "DCS-2500 Cutting Machine");

        req.setVariableValues(vars);
        String usdl = WebClient.create(BASE_URL).path("/servicetemplates/").path(name).path("/instance").type(MediaType.APPLICATION_XML_TYPE).accept(MediaType.TEXT_PLAIN_TYPE).
                post(req, String.class);
        Assert.assertEquals(usdl, "<?xml version=\"1.0\" xmlns:rdf=\"http://test.com\">\n" +
                "<usdl:Service rdf:about=\"http://www.bivolino.com/DCS-2500\">\n" +
                "<dcterms:abstract xml:lang=\"en\">\n" +
                "DCS-2500 Cutting Machine\n" +
                "</dcterms:abstract>" +
                "</usdl:service>");
    }
}
