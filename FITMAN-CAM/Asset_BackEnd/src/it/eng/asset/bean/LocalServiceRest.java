package it.eng.asset.bean;

import java.util.List;

public class LocalServiceRest extends LocalService {

	
	private List<Asset> assets;

	public List<Asset> getAssets() {
		return assets;
	}

	public void setAssets(List<Asset> assets) {
		this.assets = assets;
	}
	
	
}
