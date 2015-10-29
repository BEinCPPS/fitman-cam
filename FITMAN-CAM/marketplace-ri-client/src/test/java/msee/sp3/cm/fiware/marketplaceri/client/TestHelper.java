package msee.sp3.cm.fiware.marketplaceri.client;

import msee.sp3.cm.fiware.marketplaceri.client.exception.AuthenticationException;
import msee.sp3.cm.fiware.marketplaceri.client.exception.UserAlreadyExistsException;
import org.apache.commons.lang.RandomStringUtils;
import org.fiware.apps.marketplace.model.Localuser;

import java.util.Date;

/**
 * Utility methods for test cases
 */
public abstract class TestHelper {

    /**
     * Creates a new {@link StatefulMarketplaceClient}, initiates a session with the builtin principal, creates a new
     * local user, obtains a session with the local user and returns the initialized {@link StatefulMarketplaceClient}.
     * @return
     */
    public static StatefulMarketplaceClient initMarketplaceClientWithLocaluser(Localuser u) throws AuthenticationException, UserAlreadyExistsException {
        StatefulMarketplaceClient client = new StatefulMarketplaceClient();

        client.startSessionWithBuiltinPrincipal(StatefulMarketplaceClient.DEFAULT_BASE_URL);

        client.saveLocalUser(u);

        client.startSession(StatefulMarketplaceClient.DEFAULT_BASE_URL, u.getUsername(), u.getPassword());

        return client;
    }

    /**
     * Generate a {@link Localuser} with random username & email and "1234" as password.
     * @return
     */
    public  static Localuser generateUser() {
        Localuser u = new Localuser();
        String username = "msee" + RandomStringUtils.randomAlphanumeric(7);
        u.setRegistrationDate(new Date());
        u.setUsername(username);
        u.setPassword("1234");
        u.setEmail(username + "@test.msee.eu");
        u.setCompany("MSEE");
        return u;
    }
}
