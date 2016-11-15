package it.eng.cam.rest.security.authentication.credentials.admin;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.*;

/**
 * Created by ascatolo on 15/11/2016.
 */
public class InitAdminContextListener implements ServletContextListener {
    private static final Logger logger = LogManager.getLogger(InitAdminContextListener.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        Timer timer = new Timer();
        timer.schedule(new LoginAdminTask(), 0); //immediately
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
    }
}
