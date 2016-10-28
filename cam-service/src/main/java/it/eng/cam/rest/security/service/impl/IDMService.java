package it.eng.cam.rest.security.service.impl;

import it.eng.cam.rest.security.authentication.CAMPrincipal;

import javax.ws.rs.core.Response;

/**
 * Created by ascatolo on 28/10/2016.
 */
public interface IDMService {

    Response validateAuthToken(String token);
    CAMPrincipal getUserPrincipalByToken(String token);
    CAMPrincipal getUserPrincipalByResponse(Response response);


}
