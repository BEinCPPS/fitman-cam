package msee.sp3.cm.beans;

import msee.sp3.cm.domain.FiwareMarketplace;
import msee.sp3.cm.domain.ServiceTemplate;
import org.apache.commons.lang.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.testng.AbstractTestNGSpringContextTests;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.testng.Assert;
import org.testng.annotations.Test;

import javax.annotation.Resource;
import javax.persistence.NoResultException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 */
@ContextConfiguration(locations = {"/spring/non-servlet-context.xml"})
@TransactionConfiguration(transactionManager = "transactionManager")
public class ServiceTemplateBeanTest extends AbstractTestNGSpringContextTests {

    private Logger logger = LoggerFactory.getLogger(ServiceTemplateBeanTest.class);

    @Resource
    private ApplicationContext applicationContext;

    @Resource
    private IServiceTemplateBean serviceTemplateBean;

    @Test(groups = "component-tests")
    public void testCreateServiceTemplate() {
        logger.debug("testCreateServiceTemplate");
        String mrkt = RandomStringUtils.randomAlphanumeric(7);
        logger.debug("Creating service template {}", mrkt);
        ServiceTemplate st = serviceTemplateBean.createServiceTemplate(mrkt, "Hello ${world}", "A Short Description");
        Assert.assertEquals(st.getName(), mrkt);
        Assert.assertTrue(st.getId() > 0);

        serviceTemplateBean.getVariableNames(mrkt);
    }

    @Test(groups = "component-tests")
    public void testGetVariableNames() {
        logger.debug("testGetVariableNames");
        String mrkt = RandomStringUtils.randomAlphanumeric(7);
        ServiceTemplate st = serviceTemplateBean.createServiceTemplate(mrkt, "Hello ${world}", "A Short Description");
        List<String> vars = serviceTemplateBean.getVariableNames(mrkt);

        Assert.assertNotNull(vars);
        Assert.assertEquals(vars.size(), 1);
        Assert.assertEquals(vars.get(0), "world");

        Map<String, String> variableValues = new HashMap<String, String>();
        variableValues.put("world", "Greece");
        String instance = serviceTemplateBean.instantiateTemplate(mrkt, variableValues);

        Assert.assertNotNull(instance);
        Assert.assertEquals(instance, "Hello Greece");
        ///
        mrkt = RandomStringUtils.randomAlphanumeric(7);
        st = serviceTemplateBean.createServiceTemplate(mrkt, "<?xml version=\"1.0\" xmlns:rdf=\"http://test.com\">\n" +
                "<usdl:Service rdf:about=\"${serviceAbout}\">\n" +
                "<dcterms:abstract xml:lang=\"en\">\n" +
                "${serviceAbstract}\n" +
                "</dcterms:abstract>" +
                "</usdl:service>", "A Short Description");
        vars = serviceTemplateBean.getVariableNames(mrkt);
        Assert.assertNotNull(vars);
        Assert.assertEquals(vars.size(), 2);
        Assert.assertEquals(vars.get(0), "serviceAbout");
        Assert.assertEquals(vars.get(1), "serviceAbstract");

        variableValues.put("serviceAbout", "http://www.bivolino.com/machinery/DCS-2500/");
        variableValues.put("serviceAbstract", "DCS-2500 cutting machine");

        instance = serviceTemplateBean.instantiateTemplate(mrkt, variableValues);

        Assert.assertNotNull(instance);
        Assert.assertEquals(instance, "<?xml version=\"1.0\" xmlns:rdf=\"http://test.com\">\n" +
                "<usdl:Service rdf:about=\"http://www.bivolino.com/machinery/DCS-2500/\">\n" +
                "<dcterms:abstract xml:lang=\"en\">\n" +
                "DCS-2500 cutting machine\n" +
                "</dcterms:abstract>" +
                "</usdl:service>");

    }

    @Test(groups = "component-tests")
    public void testDeleteServiceTemplate() {
        logger.debug("testDeleteServiceTemplate");
        String mrkt = RandomStringUtils.randomAlphanumeric(7);
        ServiceTemplate st = serviceTemplateBean.createServiceTemplate(mrkt, mrkt, "A Short Description");
        Assert.assertEquals(st.getName(), mrkt);
        Assert.assertTrue(st.getId() > 0);

        serviceTemplateBean.deleteServiceTemplate(mrkt);

        st = serviceTemplateBean.getServiceTemplate(mrkt);

        Assert.assertNull(st);
    }

    @Test(groups = "component-tests")
    public void testCountServiceTemplates() {
        logger.debug("testCountServiceTemplates");
        int count = serviceTemplateBean.countServiceTemplates();
        Assert.assertTrue(count >= 0);
    }

}
