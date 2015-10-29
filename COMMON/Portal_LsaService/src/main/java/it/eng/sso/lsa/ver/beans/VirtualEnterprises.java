package it.eng.sso.lsa.ver.beans;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "VirtualEnteprises")
public class VirtualEnterprises {
		
	private List<VirtualEnterprise> virtualEnteprises;

	@XmlElement(name = "VirtualEnterprise")
	public List<VirtualEnterprise> getVirtualEnteprises() {
		return virtualEnteprises;
	}

	public void setVirtualEnteprises(List<VirtualEnterprise> virtualEnteprises) {
		this.virtualEnteprises = virtualEnteprises;
	}

	
	
	
	
	
	
	
	
	
	
}
