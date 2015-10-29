package msee.sp3.cm.fiware.marketplaceri.client;

import msee.sp3.cm.fiware.marketplaceri.client.exception.UserAlreadyExistsException;
import org.fiware.apps.marketplace.model.Localuser;

import java.util.List;

/**
 * REST Client API for {@link org.fiware.apps.marketplace.rest.UserRegistrationService}.
 */
public interface IUserRegistrationServiceClient {

    public static final String USER_REGISTRATION_SERVICE_PREFIX = "v1/registration/userManagement/";

    /**
     * Update local user
     * @param username
     * @param localuser
     */
    void updateLocaluser(String username, Localuser localuser);

    /**
     * Delete local user
     * @param username
     */
    void deleteLocaluser(String username);

    /**
     * Obtain a Localuser by username
     * @param username
     * @return
     */
    Localuser findLocaluser(String username);

    /**
     * Obtain a list of all Localusers registered in the addressed FI-WARE instance.
     * @return
     */
    public List<Localuser> findLocalusers();

    void saveLocalUser(Localuser user) throws UserAlreadyExistsException;
}
