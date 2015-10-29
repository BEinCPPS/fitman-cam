package it.eng.asset.bean;

import java.util.List;

public class PublicServiceRest extends PublicService {
	
	private List<LocalService> localservice ;

	public List<LocalService> getLocalservice() {
		return localservice;
	}

	public void setLocalservice(List<LocalService> localservice) {
		this.localservice = localservice;
	}

	
	
	
}
