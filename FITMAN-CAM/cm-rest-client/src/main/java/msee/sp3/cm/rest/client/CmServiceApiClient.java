package msee.sp3.cm.rest.client;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import msee.sp3.cm.api.resources.ServiceResourceExtended;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CmServiceApiClient extends CmRestClient {
	private static CmServiceApiClient cmRestClient;
	private static String SERVICE_ENDPOINT = null;
	private Logger logger = LoggerFactory.getLogger(CmServiceApiClient.class);

	static {
		SERVICE_ENDPOINT = finder.getString("SERVICE_ENDPOINT");
	}

	
	
	private CmServiceApiClient() {
		super();
	}

	public boolean createService(ServiceResourceExtended service) {
		Response wc;
		try {
			wc = getWebClient(SERVICE_ENDPOINT + "/service",
					MediaType.APPLICATION_XML).post(service);
			return wc.getStatus() == Status.CREATED.getStatusCode();
		} catch (Exception e) {
			logger.error(e.getMessage());
			return false;
		}
	}

	public static CmServiceApiClient getInstance() {
		if (cmRestClient == null) {
			synchronized (CmServiceApiClient.class) {
				if (cmRestClient == null) {
					cmRestClient = new CmServiceApiClient();
				}
			}
		}
		return cmRestClient;
	}
}
