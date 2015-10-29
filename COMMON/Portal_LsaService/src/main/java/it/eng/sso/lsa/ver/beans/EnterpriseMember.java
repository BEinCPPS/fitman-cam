package it.eng.sso.lsa.ver.beans;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "EnterpriseMember")
public class EnterpriseMember {

	private String memberName;
	private List<VirtualEnterprise> virtualEnterprises;

	public EnterpriseMember() {
		super();
		// TODO Auto-generated constructor stub
	}

	public EnterpriseMember(String memberName) {
		super();
		this.memberName = memberName;
	}

	@XmlElement(name = "MemberName")
	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName == null || memberName.length() <= 50 ? memberName : memberName.substring(0, 50);
	}
	
	
	@XmlElementWrapper(name = "VirtualEnterprises")
	@XmlElement(name = "VirtualEnterprise")
	public List<VirtualEnterprise> getVirtualEnterprises() {
		return virtualEnterprises;
	}

	public void setVirtualEnterprises(List<VirtualEnterprise> virtualEnterprises) {
		this.virtualEnterprises = virtualEnterprises;
	}
	
	
	

}
