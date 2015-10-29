package msee.sp3.cm.beans;

import msee.sp3.cm.domain.ServiceTemplate;
import msee.sp3.cm.domain.UsdlRepository;
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

/**
 *
 */
@ContextConfiguration(locations = {"/spring/non-servlet-context.xml"})
@TransactionConfiguration(transactionManager = "transactionManager")
public class UsdlRepositoryBeanTest extends AbstractTestNGSpringContextTests {

    private Logger logger = LoggerFactory.getLogger(UsdlRepositoryBeanTest.class);

    @Resource
    private ApplicationContext applicationContext;

    @Resource
    private IUsdlRepositoryBean usdlRepositoryBean;

    @Test(groups = "component-tests")
    public void testCreateUsdlRepository() {
        logger.debug("testCreateUsdlRepository");
        String mrkt = RandomStringUtils.randomAlphanumeric(7);
        logger.debug("Creating Usdl Repository {}", mrkt);
        UsdlRepository ur = usdlRepositoryBean.createUsdlRepository(mrkt, "http://www.google.com");
        Assert.assertEquals(ur.getName(), mrkt);
        Assert.assertTrue(ur.getId() > 0);
    }

    @Test(groups = "component-tests")
    public void testUpdateUsdlRepository() {
        logger.debug("testUpdateUsdlRepository");
        String mrkt = RandomStringUtils.randomAlphanumeric(7);
        logger.debug("Creating Usdl Repository {}", mrkt);
        UsdlRepository ur = usdlRepositoryBean.createUsdlRepository(mrkt, "http://www.google.com");
        Assert.assertEquals(ur.getName(), mrkt);
        Assert.assertTrue(ur.getId() > 0);

        // now update name and url
        String newName = RandomStringUtils.randomAlphanumeric(7);
        UsdlRepository updatedUsdlRepository = usdlRepositoryBean.updateUsdlRepository(mrkt, newName, "http://www.yahoo.com");

        Assert.assertNull(usdlRepositoryBean.getUsdlRepository(mrkt));;

        UsdlRepository retrievedRepository = usdlRepositoryBean.getUsdlRepository(newName);

        Assert.assertNotNull(retrievedRepository);
        Assert.assertEquals(retrievedRepository.getName(), newName);
        Assert.assertEquals(retrievedRepository.getUrl(), "http://www.yahoo.com");

    }

    @Test(groups = "component-tests")
    public void testDeleteUsdlRepository() {
        logger.debug("testDeleteUsdlRepository");
        String mrkt = RandomStringUtils.randomAlphanumeric(7);
        UsdlRepository ur = usdlRepositoryBean.createUsdlRepository(mrkt, "http://www.google.com");
        Assert.assertEquals(ur.getName(), mrkt);
        Assert.assertTrue(ur.getId() > 0);

        usdlRepositoryBean.deleteUsdlRepository(mrkt);

        ur = usdlRepositoryBean.getUsdlRepository(mrkt);

        Assert.assertNull(ur);
    }

    @Test(groups = "component-tests")
    public void testCountUsdlRepository() {
        logger.debug("testCountUsdlRepository");
        int count = usdlRepositoryBean.countUsdlRepositories();
        Assert.assertTrue(count >= 0);
    }

}
