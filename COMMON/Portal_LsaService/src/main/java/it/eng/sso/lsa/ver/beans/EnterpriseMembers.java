package it.eng.sso.lsa.ver.beans;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "EnterpriseMembers")
public class EnterpriseMembers {
		
	private List<EnterpriseMember> enterpriseMembers;

	@XmlElement(name = "EnterpriseMember")
	public List<EnterpriseMember> getEnterpriseMembers() {
		return enterpriseMembers;
	}

	public void setEnterpriseMembers(List<EnterpriseMember> enterpriseMembers) {
		this.enterpriseMembers = enterpriseMembers;
	}

	
	
	
	
	
	
	
	
	
	
}
