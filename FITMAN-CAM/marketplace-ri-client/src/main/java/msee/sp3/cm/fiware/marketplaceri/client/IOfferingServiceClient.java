package msee.sp3.cm.fiware.marketplaceri.client;

import org.fiware.apps.marketplace.model.Service;
import java.util.List;

public interface IOfferingServiceClient {

    public static final String OFFERING_SERVICE_PREFIX = "v1/offering/";

	public void saveService(String storeName, Service service);

	public void updateService(String storeName, String serviceName, Service service);

	public void deleteService(String storeName, String serviceName);

	public Service findService(String storeName, String serviceName);

	public List<Service> findServices(String storeName);


}
