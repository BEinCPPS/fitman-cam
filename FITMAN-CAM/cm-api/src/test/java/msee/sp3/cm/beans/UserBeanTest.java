package msee.sp3.cm.beans;

import msee.sp3.cm.domain.ServiceProvider;
import org.apache.commons.lang.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.testng.AbstractTestNGSpringContextTests;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;
import org.testng.Assert;
import org.testng.annotations.Test;

import javax.annotation.Resource;
import java.util.List;

/**
 *
 */
@ContextConfiguration(locations = {"/spring/non-servlet-context.xml"})
@TransactionConfiguration(transactionManager = "transactionManager")
public class UserBeanTest extends AbstractTestNGSpringContextTests {

    private Logger logger = LoggerFactory.getLogger(UserBeanTest.class);

    public static final String DEFAULT_PASSWORD = "1234";

    @Resource
    private ApplicationContext applicationContext;

    @Resource(name = "userBean")
    private IUserBean userBean;

    @Test(groups = "component-tests")
    public void testCreateServiceProvider() {
        String name = RandomStringUtils.randomAlphabetic(7);
        logger.info("Going to create user with name {}, userBean is {}", name, userBean);
        ServiceProvider serviceProvider = userBean.createServiceProvider(name, DEFAULT_PASSWORD, name + "@msee.eu", "MSEE");
        Assert.assertNotNull(serviceProvider);
        Assert.assertEquals(serviceProvider.getUsername(), name);
        Assert.assertEquals(serviceProvider.getCompany(), "MSEE");
        Assert.assertEquals(serviceProvider.getEmail(), name + "@msee.eu");
    }

    @Test(groups = "component-tests")
    @Rollback(true)
    @Transactional
    public void testAuthenticate() {
        String name = RandomStringUtils.randomAlphabetic(7);
        logger.info("Going to create user with name {}, userBean is {}", name, userBean);
        ServiceProvider serviceProvider = userBean.createServiceProvider(name, DEFAULT_PASSWORD, name + "@msee.eu", "MSEE");
        Assert.assertNotNull(serviceProvider);
        Assert.assertEquals(serviceProvider.getUsername(), name);
        Assert.assertEquals(serviceProvider.getCompany(), "MSEE");
        Assert.assertEquals(serviceProvider.getEmail(), name + "@msee.eu");

        ServiceProvider authenticated = userBean.authenticate(name, DEFAULT_PASSWORD);
        Assert.assertEquals(authenticated, serviceProvider);
    }

    @Test(groups = "component-tests")
    @Transactional
    @Rollback(true)
    public void testListServiceProviders() {
        int count = userBean.countServiceProviders();
        Assert.assertTrue(count > 0);
        List<ServiceProvider> sp = userBean.getServiceProviders(0, count);
        Assert.assertEquals(sp.size(), count);
        // assert proper paging
        if (count > 2) {
            sp = userBean.getServiceProviders(0, 2);
            Assert.assertEquals(sp.size(), 2);
        }
    }

}
