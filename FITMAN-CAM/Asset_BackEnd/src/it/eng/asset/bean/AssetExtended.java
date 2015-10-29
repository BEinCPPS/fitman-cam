package it.eng.asset.bean;

import java.util.List;

public class AssetExtended{

	private long assetId;
	private String AssetName;
	private List<PublicService> services;
	public long getAssetId() {
		return assetId;
	}
	public void setAssetId(long assetId) {
		this.assetId = assetId;
	}
	public String getAssetName() {
		return AssetName;
	}
	public void setAssetName(String assetName) {
		AssetName = assetName;
	}
	public List<PublicService> getServices() {
		return services;
	}
	public void setServices(List<PublicService> services) {
		this.services = services;
	}
	
	

		
	
}
