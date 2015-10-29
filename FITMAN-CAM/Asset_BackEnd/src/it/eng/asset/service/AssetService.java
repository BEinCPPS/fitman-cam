/**
 * @author afantini
 *
 */

package it.eng.asset.service;

public class AssetService extends AssetServiceImpl {

	private static IAssetService service;

	private AssetService() {
		super();
	}

	public static IAssetService getAssetService() {
		if (null == service) {
			synchronized (AssetService.class) {
				if (null == service)
					service = new AssetServiceImpl();
			}
		}
		return service;
	}

}
