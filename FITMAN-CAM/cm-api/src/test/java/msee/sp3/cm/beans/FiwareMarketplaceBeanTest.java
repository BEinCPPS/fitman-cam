package msee.sp3.cm.beans;

import msee.sp3.cm.domain.FiwareMarketplace;
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

/**
 *
 */
@ContextConfiguration(locations = {"/spring/non-servlet-context.xml"})
@TransactionConfiguration(transactionManager = "transactionManager")
public class FiwareMarketplaceBeanTest extends AbstractTestNGSpringContextTests {

    private Logger logger = LoggerFactory.getLogger(FiwareMarketplaceBeanTest.class);

    @Resource
    private ApplicationContext applicationContext;

    @Resource(name = "fiwareMarketplaceBean")
    private IFiwareMarketplaceBean fiwareMarketplaceBean;

    @Test(groups = "component-tests")
    public void testCreateFiwareMrkt() {
        String mrkt = RandomStringUtils.randomAlphanumeric(7);
        FiwareMarketplace fi = fiwareMarketplaceBean.createFiwareMarketplace(mrkt, "http://localhost/" + mrkt);
        Assert.assertEquals(fi.getName(), mrkt);
        Assert.assertTrue(fi.getId() > 0);
    }

    @Test(groups = "component-tests", expectedExceptions = {NoResultException.class})
    public void testDeleteFiwareMrkt() {
        String mrkt = RandomStringUtils.randomAlphanumeric(7);
        FiwareMarketplace fi = fiwareMarketplaceBean.createFiwareMarketplace(mrkt, "http://localhost/" + mrkt);
        Assert.assertEquals(fi.getName(), mrkt);
        Assert.assertTrue(fi.getId() > 0);

        fiwareMarketplaceBean.deleteFiwareMarketplace(mrkt);

        fiwareMarketplaceBean.getFiwareMarketplace(mrkt);
    }

}
