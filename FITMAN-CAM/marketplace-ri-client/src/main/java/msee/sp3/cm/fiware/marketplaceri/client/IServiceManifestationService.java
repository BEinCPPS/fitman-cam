package msee.sp3.cm.fiware.marketplaceri.client;

import org.fiware.apps.marketplace.model.ServiceManifestation;

import java.util.List;

/**
 * Service manifestation server client
 * Date: 5/5/13
 * Time: 23:17
 */
public interface IServiceManifestationService {

    public static final String SERVICE_MANIFESTATION_SERVICE = "v1/serviceManifestationIndex/";

    List<ServiceManifestation> getAllServices();

    ServiceManifestation getServiceById(String id);
}
