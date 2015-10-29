package it.eng.asset.dao;

import it.eng.asset.bean.AssetExtended;
import it.eng.asset.bean.GenericService;
import it.eng.asset.bean.LocalService;
import it.eng.asset.bean.PublicService;
import it.eng.asset.bean.ServiceAssets;

import java.util.List;
import java.util.Map;

public interface AssetDAO {

	// Public
	public List<PublicService> getPublicServiceList();

	public PublicService getPublicService(Map<String, String> map);

	// Generic Service
	public List<GenericService> getListGenericPublicService(
			Map<String, String> map);

	public List<GenericService> getListGenericLocalService(
			Map<String, String> map);

	public List<LocalService> getLocalServiceDetail(Map<String, String> map);

	public List<LocalService> getLocalServiceList();

	public List<LocalService> getLocalServicePublished();

	public LocalService getLocalService(Map<String, String> map);

	public int deleteServiceAssetsByServices(Map<String, String> map);

	public List<ServiceAssets> getServiceAssetsByIdLocalIdPublic(
			Map<String, String> map);

	// Local
	public int insertLocalService(LocalService lService);

	public int updateLocalService(LocalService lService);

	public int deleteLocalService(Map<String, String> map);

	public int insertPublicService(PublicService lService);

	public int updatePublicService(PublicService lService);

	public int deletePublicService(Map<String, String> map);

	public List<ServiceAssets> getServiceAssetsList();

	public ServiceAssets getServiceAssets(Map<String, String> map);

	public List<ServiceAssets> getServiceAssetsXLocalService(
			Map<String, String> map);

	public List<ServiceAssets> getServiceAssetsXService(Map<String, String> map);

	public int insertServiceAssets(ServiceAssets sa);

	public int updateServiceAssets(ServiceAssets sa);

	public int deleteServiceAssets(Map<String, String> map);

	public int updateassetLocalService(Map<String, String> map);

	public int publishPublicService(Map<String, String> map);

	public int updateLocalService4Asset(Map<String, String> map);

	public int publishLocalService(Map<String, String> map);

	public int updateLocalServiceDetail(Map<String, String> map);

	public int updatePublicServiceDetail(Map<String, String> map);

	public List<AssetExtended> retrieveAllAssets();

	public List<AssetExtended> retrieveAllAssetServices(AssetExtended assetExtended);

	public List<AssetExtended> retrieveAssetsByServiceId(long serviceId);
	
	public int addServiceAssets(Map<String, Object> map);
	
	public int removeServiceAsset(Map<String, Object> map);
	
	public long retrieveNewAssetId();
}
