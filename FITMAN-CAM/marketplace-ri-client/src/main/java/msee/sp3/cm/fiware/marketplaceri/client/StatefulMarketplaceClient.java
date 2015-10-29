package msee.sp3.cm.fiware.marketplaceri.client;

import msee.sp3.cm.fiware.marketplaceri.client.exception.AuthenticationException;
import msee.sp3.cm.fiware.marketplaceri.client.exception.UserAlreadyExistsException;
import org.apache.commons.lang.NotImplementedException;
import org.apache.commons.lang.StringUtils;
import org.apache.cxf.jaxrs.client.WebClient;
import org.fiware.apps.marketplace.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ws.rs.core.Cookie;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.ws.rs.NotFoundException;

/**
 * REST API client for FI-WARE Marketplace RI with authentication & session state management.
 */
public class StatefulMarketplaceClient implements IStatefulMarketplaceClient, IUserRegistrationServiceClient,
        IStoreRegistrationServiceClient, IOfferingServiceClient, IServiceManifestationService, ISearchService,
        ICompareService {

    private final Logger logger = LoggerFactory.getLogger(StatefulMarketplaceClient.class);

    public static final String DEFAULT_BASE_URL = "http://192.168.33.11:8080/FiwareMarketplace";

    /**
     * Base URL of FIWARE Marketplace RI installation, e.g. "http://localhost:8080/FiwareMarketplace"
     */
    private String baseUrl;

    /**
     * REST API base URL, e.g. "http://192.168.33.11:8080/FiwareMarketplace/v1"
     */
    private String restApiBaseUrl;
    private boolean authenticatedWithBuiltinPrincipal, authenticatedWithLocaluser;
    private String sessionId;

    public StatefulMarketplaceClient() {
        authenticatedWithBuiltinPrincipal = false;
        authenticatedWithLocaluser = false;
        sessionId = "";
    }

    /*
     * Compare service impl
     */

    @Override
    public ComparisonResult compareSingle(String sourceServiceId) {
        logger.debug("compare single for source service ID: {}", sourceServiceId);
        WebClient client = obtainClient();
        ComparisonResult cr = client.path(COMPARE_SERVICE_PREFIX).path(sourceServiceId).
                cookie(new Cookie("JSESSIONID", sessionId)).get(ComparisonResult.class);
        return cr;
    }
    /*
     * Search service implementations
     */

    @Override
    public List<SearchResultEntry> search(String searchstring) {
        logger.debug("searching for {}", searchstring);
        WebClient client = obtainClient();
        Collection<? extends SearchResultEntry> searchResultEntries = client.path(SEARCH_SERVICE_PREFIX).path(FULLTEXT_SEARCH).
                path(searchstring).cookie(new Cookie("JSESSIONID", sessionId)).getCollection(SearchResultEntry.class);
        if (searchResultEntries != null) {
            return new ArrayList<SearchResultEntry>(searchResultEntries);
        }
        else {
            return null;
        }
    }

    @Override
    public SearchResultOffering findOfferingsByCriteria(SearchByCriteria searchByCriteria) {
        logger.debug("search by criteria for {}", searchByCriteria);
        SearchResultOffering toReturn = new SearchResultOffering();

        WebClient client = obtainClient();
        SearchResultOffering searchResults = client.path(SEARCH_SERVICE_PREFIX).path(CRITERIA_SEARCH).
                cookie(new Cookie("JSESSIONID", sessionId)).post(searchByCriteria, SearchResultOffering.class);
        return searchResults;
    }

    /*
     * Service manifestation service implementations
     */

    @Override
    public List<ServiceManifestation> getAllServices() {
        logger.debug("get all services");
        WebClient client = obtainClient();
        Collection<? extends ServiceManifestation> serviceManifestations = client.path(SERVICE_MANIFESTATION_SERVICE).path("all").cookie(new Cookie("JSESSIONID", sessionId)).getCollection(ServiceManifestation.class);
        if (serviceManifestations != null) {
            return new ArrayList<ServiceManifestation>(serviceManifestations);
        }
        else {
            return null;
        }
    }

    @Override
    public ServiceManifestation getServiceById(String id) {
        logger.debug("get service with id {}", id);
        WebClient client = obtainClient();
        ServiceManifestation serviceManifestation = client.path(SERVICE_MANIFESTATION_SERVICE).path("id/").path(id).cookie(new Cookie("JSESSIONID", sessionId)).get(ServiceManifestation.class);
        return serviceManifestation;
    }

    /*
     * Offering service implementations
     */

    @Override
    public void saveService(String storeName, Service service) {
        logger.debug("saveService {} {}", storeName, service);
        WebClient client = obtainClient();
        client.path(OFFERING_SERVICE_PREFIX).path("store/").path(storeName).path("/offering").cookie(new Cookie("JSESSIONID", sessionId)).type("application/xml").put(service);

    }

    @Override
    public void updateService(String storeName, String serviceName, Service service) {
        logger.debug("saveService {} {}", storeName, service);
        WebClient client = obtainClient();
        client.path(OFFERING_SERVICE_PREFIX).path("store/").path(storeName).path("/offering/")
                            .path(serviceName).cookie(new Cookie("JSESSIONID", sessionId)).type("application/xml").post(service);

    }

    @Override
    public void deleteService(String storeName, String serviceName) {
        logger.debug("deleteService {} {}", storeName, serviceName);
        WebClient client = obtainClient();
        client.path(OFFERING_SERVICE_PREFIX).path("store/").path(storeName).path("/offering/")
                .path(serviceName).cookie(new Cookie("JSESSIONID", sessionId)).delete();

    }

    @Override
    public Service findService(String storeName, String serviceName) {
        logger.debug("findService {} {}", storeName, serviceName);
        WebClient client = obtainClient();
        Service s = client.path(OFFERING_SERVICE_PREFIX).path("store/").path(storeName).path("/offering/")
                .path(serviceName).cookie(new Cookie("JSESSIONID", sessionId)).get(Service.class);
        return s;
    }

    @Override
    public List<Service> findServices(String storeName) {
        logger.debug("findServices {} {}", storeName);
        WebClient client = obtainClient();
        Collection<? extends Service> services = client.path(OFFERING_SERVICE_PREFIX).path("store/").path(storeName)
                .path("/offerings/").cookie(new Cookie("JSESSIONID", sessionId)).getCollection(Service.class);
        if (services != null) {
            List<Service> svcs = new ArrayList<Service>(services);
            return svcs;
        }
        else {
            return null;
        }
    }

    /*
     * Store registration service implementations
     */

    @Override
    public void saveStore(Store store) {
        logger.debug("saveStore for {}", store);
        WebClient client = obtainClient();
        client.path(STORE_REGISTRATION_SERVICE_PREFIX.concat("store")).cookie(new Cookie("JSESSIONID", sessionId)).type("application/xml").put(store);
    }

    @Override
    public void updateStore(String storeName, Store store) {
        logger.debug("updateStore for {}, updated store is {}", storeName, store);
        WebClient client = obtainClient();
        client.path(STORE_REGISTRATION_SERVICE_PREFIX.concat("store/").concat(storeName)).cookie(new Cookie("JSESSIONID", sessionId)).type("application/xml").post(store);
    }

    @Override
    public void deleteStore(String storeName) {
        logger.debug("updateStore for {}", storeName);
        WebClient client = obtainClient();
        client.path(STORE_REGISTRATION_SERVICE_PREFIX.concat("store/").concat(storeName)).cookie(new Cookie("JSESSIONID", sessionId)).delete();
    }

    @Override
    public Store findStore(String storeName) {
        logger.debug("findStore for {}", storeName);
        WebClient client = obtainClient();
        Store store = client.path(STORE_REGISTRATION_SERVICE_PREFIX.concat("store/").concat(storeName)).cookie(new Cookie("JSESSIONID", sessionId)).get(Store.class);
        return store;
    }

    @Override
    public List<Store> findStores() {
        logger.debug("findStores");
        WebClient client = obtainClient();
        Collection<? extends Store> stores = client.path(STORE_REGISTRATION_SERVICE_PREFIX.concat("stores/")).cookie(new Cookie("JSESSIONID", sessionId)).getCollection(Store.class);
        if (stores != null) {
            List<Store> toReturn = new ArrayList<Store>(stores);
            return toReturn;
        }
        else {
            return null;
        }
    }

    /*
     * User registration service implementations
     */
    @Override
    public void startSession(String baseUrl, String username, String password) throws AuthenticationException {
        this.baseUrl = baseUrl;
        WebClient client = obtainClient();
        Response resp = client.path("j_spring_security_check").type("application/x-www-form-urlencoded")
                                .post("j_username=" + username + "&j_password=" + password + "&submit=submit");
        String setCookie = resp.getHeaderString("Set-Cookie");
        if (StringUtils.isNotBlank(setCookie) && (setCookie.contains("JSESSIONID=")) &&
                (resp.getLocation() != null) && (!resp.getLocation().toASCIIString().contains("login_error"))) {
            sessionId = setCookie.substring(setCookie.indexOf("JSESSIONID=") + 11, setCookie.indexOf(";") );
            authenticatedWithBuiltinPrincipal = false;
            authenticatedWithLocaluser = true;
        }
        else {
            throw new AuthenticationException(String.format("Could not authenticate %s to FI-WARE Marketplace " +
                    " at %s - server responded with status %d", username, baseUrl, resp.getStatus()));
        }
    }

    @Override
    public void startSessionWithBuiltinPrincipal(String baseUrl) throws AuthenticationException {
        this.baseUrl = baseUrl;
        WebClient client = obtainClient();
        Response resp = client.path("j_spring_security_check").type("application/x-www-form-urlencoded").post("j_username=demo1234&j_password=demo1234&submit=submit");
        String setCookie = resp.getHeaderString("Set-Cookie");
        if (StringUtils.isNotBlank(setCookie) && (setCookie.contains("JSESSIONID=")) &&
                (resp.getLocation() != null) && (!resp.getLocation().toASCIIString().contains("login_error"))) {
            sessionId = setCookie.substring(setCookie.indexOf("JSESSIONID=") + 11, setCookie.indexOf(";") );
            authenticatedWithBuiltinPrincipal = true;
            authenticatedWithLocaluser = false;
        }
        else {
            throw new AuthenticationException(String.format("Could not authenticate builtin account to FI-WARE Marketplace " +
                    " at %s - server responded with status %d", baseUrl, resp.getStatus()));
        }
    }

    @Override
    public boolean isAuthenticatedAsLocaluser() {
        return authenticatedWithLocaluser;
    }

    @Override
    public boolean isAuthenticatedWithBuiltinPrincipal() {
        return authenticatedWithBuiltinPrincipal;
    }

    @Override
    public String getBaseUrl() {
        return baseUrl;
    }

    @Override
    public void updateLocaluser(String username, Localuser localuser) {
        throw new NotImplementedException("updateLocaluser not yet implemented");
    }

    @Override
    public void deleteLocaluser(String username) {
        logger.debug("deleteLocaluser {}", username);
        WebClient client = obtainClient();
        Response resp = client.path(USER_REGISTRATION_SERVICE_PREFIX.concat("user/").concat(username)).cookie(new Cookie("JSESSIONID", sessionId)).delete();
        logger.debug("deleteLocaluser status {}", resp.getStatus());
    }

    @Override
    public Localuser findLocaluser(String username) {
        logger.debug("findLocaluser {}", username);
        WebClient client = obtainClient();
        Localuser user = null;
        try{
            user = client.path(USER_REGISTRATION_SERVICE_PREFIX.concat("user/").concat(username)).cookie(new Cookie("JSESSIONID", sessionId)).get(Localuser.class);
        }catch(NotFoundException ex){
            //Do nothing
            logger.debug("user {} not found", username);
        }
        return user;
    }

    @Override
    public List<Localuser> findLocalusers() {
        logger.debug("findLocalUsers");
        WebClient client = obtainClient();
        Collection<? extends Localuser> users = client.path(USER_REGISTRATION_SERVICE_PREFIX.concat("users")).cookie(new Cookie("JSESSIONID", sessionId)).getCollection(Localuser.class);
        if (users != null) {
            return new ArrayList<Localuser>(users);
        }
        else {
            return null;
        }
    }

    @Override
    public void saveLocalUser(Localuser user) throws UserAlreadyExistsException {
        logger.debug("saveLocalUser with username {}", user.getUsername());
        WebClient client = obtainClient();
        Response resp = client.path(USER_REGISTRATION_SERVICE_PREFIX.concat("user")).cookie(new Cookie("JSESSIONID", sessionId)).type("application/xml").put(user);
        if (resp.getStatus() == Response.Status.FOUND.getStatusCode()) {
            // user already exists
            logger.warn("User with username {} or email {} already exists", user.getUsername(), user.getEmail());
            throw new UserAlreadyExistsException(String.format("User with username %s or email %s already exists",
                    user.getUsername(), user.getEmail()));
        }
        else if (resp.getStatus() == Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()) {
            logger.error("Server returned error 500");
            throw new RuntimeException("Internal server error");
        }

    }

    private WebClient obtainClient() {
        WebClient client = WebClient.create(baseUrl);
        return client;
    }
}
