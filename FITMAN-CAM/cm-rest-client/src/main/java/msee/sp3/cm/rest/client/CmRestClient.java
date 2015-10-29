package msee.sp3.cm.rest.client;

import java.util.ResourceBundle;

import org.apache.cxf.jaxrs.client.WebClient;

public class CmRestClient {

	protected static ResourceBundle finder = null;
	private static String BASE_URL = null;

	static {
		finder = ResourceBundle.getBundle("cm-rest-client");
		BASE_URL = finder.getString("BASE_URL");

	}

	protected CmRestClient() {
		super();
	}

	protected WebClient getWebClient(String endpoint, String mediaType) {
		WebClient retval = WebClient.create(BASE_URL)
				.path(endpoint).type(mediaType);
		return retval;

	}

}
