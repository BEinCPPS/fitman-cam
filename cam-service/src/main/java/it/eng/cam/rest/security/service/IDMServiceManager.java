package it.eng.cam.rest.security.service;

import it.eng.cam.rest.Constants;
import it.eng.cam.rest.security.service.impl.IDMKeystoneService;
import it.eng.cam.rest.security.service.impl.IDMOauth2Service;
import it.eng.cam.rest.security.service.impl.IDMService;

/**
 * Created by ascatolo on 28/10/2016.
 */
public class IDMServiceManager {

    public static IDMService getAuthService() {
        if (Constants.AUTHENTICATION_SERVICE.equalsIgnoreCase(AuthenticationService.OAUTH2.name()))
            return new IDMOauth2Service();
        else if (Constants.AUTHENTICATION_SERVICE.equalsIgnoreCase(AuthenticationService.KEYSTONE.name()))
            return new IDMKeystoneService();
        else
            return null;
    }

}
