package it.eng.cam.rest.security.authentication;

import it.eng.cam.rest.security.service.Constants;
import it.eng.cam.rest.security.service.impl.IDMKeystoneService;
import it.eng.cam.rest.security.user.UserLoginJSON;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Created by ascatolo on 15/11/2016.
 */
public class InitAdminContextListener implements ServletContextListener {
    private static final Logger logger = LogManager.getLogger(InitAdminContextListener.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        try {UserLoginJSON user = new UserLoginJSON();
            user.setUsername(Constants.ADMIN_USER);
            user.setPassword(Constants.ADMIN_PASSWORD);
            IDMKeystoneService idmKeystoneService = new IDMKeystoneService();
            String adminToken = idmKeystoneService.getADMINToken(user);
            if (adminToken == null || adminToken.isEmpty()) throw new RuntimeException("FATAL!!! ADMIN TOKEN IS NOT SET!!!");
            Constants.ADMIN_TOKEN = adminToken;
        } catch (RuntimeException e) {
            logger.error("FATAL!!! ADMIN TOKEN IS NOT SET!!!");
        } catch (Exception e) {
            logger.error("FATAL!!! ADMIN TOKEN IS NOT SET!!!");
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
    }
}
