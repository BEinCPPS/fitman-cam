package it.eng.asset.service;

import it.eng.asset.bean.Asset;
import it.eng.asset.bean.AssetClass;
import it.eng.asset.bean.AssetRest;
import it.eng.asset.bean.GenericService;
import it.eng.asset.bean.LocalService;
import it.eng.asset.bean.LocalServiceRest;
import it.eng.asset.bean.Property;
import it.eng.asset.bean.PublicService;
import it.eng.asset.bean.PublicServiceRest;
import it.eng.asset.bean.ServiceAssets;
import it.eng.msee.ontorepo.IndividualItem;

import java.util.List;

public interface VirtualizedRepositoryManager {

	public abstract List<PublicService> getPublicList() throws Exception;
	
	public abstract PublicService getPublicService(String namePublicService)
			throws Exception;

	public abstract int insertPublicService(PublicService ps);

	public abstract int updatePublicService(PublicService ps) throws Exception;

	public abstract int deletePublicService(String NameService) throws Exception;

	public abstract List<LocalService> getLocalServiceList() throws Exception;

	public abstract LocalService getLocalService(String nameLocalService)
			throws Exception;

	public abstract int insertLocalService(LocalService ls);

	public abstract int updateLocalService(LocalService lService)
			throws Exception;

	public abstract int deleteLocalService(String name)
			throws Exception;
	
	public abstract int updateassetLocalService(String name) throws Exception;

	public abstract List<ServiceAssets> getServiceAssetsList() throws Exception;

	public abstract List<ServiceAssets> getServiceXNameAsset(String NameAsset)
			throws Exception;

	public abstract ServiceAssets getServiceAssets(Integer idServiceAsset)
			throws Exception;

	public abstract int insertServiceAssets(ServiceAssets sa);

	public abstract int updateServiceAssets(ServiceAssets sa) throws Exception;

	public abstract int deleteServiceAssets(Integer idServiceAsset)
			throws Exception;

	public abstract List<ServiceAssets> getServiceAssetsXService(
			Integer idService) throws Exception;

	public abstract List<ServiceAssets> getServiceAssetsXLocalService(
			Integer idLocalService) throws Exception;

	public abstract List<AssetClass> getAllClasses();
	
	public abstract List<String> getListModel(String class_name);

	public abstract List<Asset> getAssetSelected(String class_name) ;

	public abstract Asset getAsset(String name_asset, String name_class);

	public abstract List<Property> getProperty(String name_asset);

	public abstract List<GenericService> getServiceXAsset(String nameAsset)
			throws Exception;

	public abstract List<GenericService> getAllService() throws Exception;

	public abstract String insertAssetType(String class_name, String name, String owner);

	public abstract String insertAsset(String class_name, String model,
			String name);

	public abstract String updateAsset(String name, String owner);

	public abstract List<Property> getDataProperty(String nome_asset);

	public abstract String insertDataProperty(String asset, String name,
			String value, Class<?> class_type);

	public abstract List<Asset> getAllAsset();

	public abstract String insertObjectProperty(String asset, String name,
			String value);

	public abstract String deleteAsset(String name_asset);


	public abstract String updateDataPropertyAsset(String nameAsset, String name_property,
			String value_prop_modified);


	public abstract String updateObjectPropertyAsset(String nameAsset, String name_property,
			String value_prop_modified);


	public abstract String MoveClass(String ClassMove, String ClassParent);


	public abstract String insertClass(String class_name,
			String class_name_reference);


	public abstract String PropertyExist(String str_value);


	public abstract String deleteClass(String class_name);

	
	public abstract String getModel(IndividualItem individual) ;


	public abstract List<Asset> getAssetOnlyModel(String classSelected);


	public abstract List<Asset> getAssetSingleModel(String classSelected, String model);


	public abstract String deleteProperty(String name_asset, String name_property);


	public abstract List<Property> getOBjectProperty();

	public abstract Asset getAssetFromName(String nameAsset);

	public abstract List<Asset> getAsset2Select();

	public abstract List<String> getOwners();

	public abstract List<LocalService> getLocalServiceDetail(String nameService) throws Exception;
	
	public abstract List<LocalService> getLocalServicePublished() throws Exception;

	public abstract int publishPublicService(String nameService) throws Exception ;

	public abstract int updateLocalService4Asset(String name_asset, String name_service);

	public abstract int insertServiceAssetsXlocal(String summary_service, String name_service) throws Exception;
	
	public abstract int publishLocalService(String nameService) throws Exception ;

	public abstract int deleteAssociationLocal2Public(String nameService, String name_local_service) throws Exception;

	public abstract int updateLocalService(String name_local_service, String descriptionService, String owner);

	public abstract int updatePublicService(String name_local_service, String descriptionService, String owner);

	public abstract String createDataPropertyAsset(String nameAsset , String name_property, String value_prop_modified,  Class<?> type);
	
	public abstract AssetClass getHierarchyClass();
	
	public abstract PublicServiceRest getPublicServiceRest(String namePublicService) throws Exception ;
	
	public abstract LocalServiceRest getLocalServiceRest(String nameLocalService) throws Exception;

	public abstract AssetRest getAssetFromNameRest(String nameAsset);

	public abstract List<String> getTabOwners();
	
	public abstract String deleteOwner(String owners);	
	
	public abstract String insertOwner(String owner);
	
}