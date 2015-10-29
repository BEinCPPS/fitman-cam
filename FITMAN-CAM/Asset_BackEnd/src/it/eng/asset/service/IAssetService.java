/**
 * @author afantini
 *
 */
package it.eng.asset.service;

import it.eng.asset.bean.Asset;
import it.eng.asset.bean.AssetExtended;

import java.util.List;

public interface IAssetService {
	public List<AssetExtended> retrieveAllAssets() throws Exception;
	
	public List<AssetExtended> retrieveAllAssetServices(Long assetId, String assetName) throws Exception;
	
	public List<Asset> retrieveAssetsByServiceId(long serviceId) throws Exception;

	/**
	 * @param  service id
	 * @param  assets, please provide a list of asset names
	 */
	public boolean addServiceAssets(long serviceId, List<String> assets)throws Exception;
	/**
	 * @param  service id
	 * @param  assetExtended, please provide at least one between assetId and assetName
	 */
	public boolean deleteServiceAsset(long serviceId, AssetExtended assetExtended)throws Exception;

}
