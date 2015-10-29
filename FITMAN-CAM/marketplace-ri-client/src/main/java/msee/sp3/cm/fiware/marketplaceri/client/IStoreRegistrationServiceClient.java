package msee.sp3.cm.fiware.marketplaceri.client;

import org.fiware.apps.marketplace.model.Store;

import java.util.List;

/**
 * Store registration service
 */
public interface IStoreRegistrationServiceClient {

    public static final String STORE_REGISTRATION_SERVICE_PREFIX = "v1/registration/";

    public void saveStore(Store store);

    /**
     * Only allows editing of store name & URL attributes; none else (e.g. description etc).
     * @param storeName
     * @param store
     */
    public void updateStore(String storeName, Store store);

    public void deleteStore(String storeName);

    public Store findStore(String storeName);

    public List<Store> findStores();
}
