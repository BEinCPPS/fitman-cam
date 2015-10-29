package msee.sp3.cm.fiware.marketplaceri.client;

import msee.sp3.cm.fiware.marketplaceri.client.exception.AuthenticationException;

/**
 * FI-WARE Marketplace RI Client with built-in support for authentication & session management.
 */
public interface IStatefulMarketplaceClient {

    /**
     * Before invoking any further methods, it is required that the REST client is authenticated with
     * @param username
     * @param password
     */
    void startSession(String baseUrl, String username, String password) throws AuthenticationException ;

    /**
     * Use a default built-in principal for obtaining an initial session.
     */
    void startSessionWithBuiltinPrincipal(String baseUrl) throws AuthenticationException;

    /**
     *
     * @return {@code true} in case the {@link IStatefulMarketplaceClient} has an authenticated session with a FI-WARE
     * Marketplace server and a Localuser has been authenticated via {@code startSession}, otherwise {@code false}.
     */
    boolean isAuthenticatedAsLocaluser();

    /**
     *
     * @return {@code true} in case the {@link IStatefulMarketplaceClient} has an authenticated session with a FI-WARE
     * Marketplace server and that session was obtained via {@code startSessionWithBuiltinPrincipal},
     * otherwise {@code false}.
     */
    boolean isAuthenticatedWithBuiltinPrincipal();

    /**
     * The base URL of the remote FI-WARE repository to which this {@code IStatefulMarketplaceClient} is linked.
     * @return
     */
    String getBaseUrl();
}
