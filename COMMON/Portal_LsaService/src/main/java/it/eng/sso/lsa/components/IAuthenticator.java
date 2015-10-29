package it.eng.sso.lsa.components;

import it.eng.sso.lsa.Principal;

/**
 * Interface to be implemented by authentication beans
 */
public interface IAuthenticator {

    Principal authenticateUserInBackend(String uid, String password) throws UserNotAllowedException, UserNotFoundException;
}
