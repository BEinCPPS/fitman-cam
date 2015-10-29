package it.eng.sso.lsa.ver.beans;

import java.io.Serializable;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;
import javax.xml.bind.annotation.XmlValue;

@XmlRootElement(name = "VirtualEnterprise")
@XmlType(propOrder = { "name", "virtualEnterpriseShortDescription", "virtualEnterpriseLongDescription", "members" })
public class VirtualEnterprise implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	private String virtualEnterpriseShortDescription;
	private String virtualEnterpriseLongDescription;

	private List<EnterpriseMember> members;

	public VirtualEnterprise() {
		super();
		// TODO Auto-generated constructor stub
	}

	public VirtualEnterprise(String name, String virtualEnterpriseShortDescription,
			String virtualEnterpriseLongDescription, List<EnterpriseMember> members) {
		super();
		this.name = name;
		this.virtualEnterpriseShortDescription = virtualEnterpriseShortDescription;
		this.virtualEnterpriseLongDescription = virtualEnterpriseLongDescription;
		this.members = members;
	}

	@XmlElement(name = "ShortDescription")
	public String getVirtualEnterpriseShortDescription() {
		return virtualEnterpriseShortDescription;
	}

	public void setVirtualEnterpriseShortDescription(String virtualEnterpriseShortDescription) {
		this.virtualEnterpriseShortDescription= virtualEnterpriseShortDescription == null || virtualEnterpriseShortDescription.length() <= 255 ? virtualEnterpriseShortDescription
				: virtualEnterpriseShortDescription.substring(0, 255);
	}

	@XmlElement(name = "LongDescription")
	public String getVirtualEnterpriseLongDescription() {
		return virtualEnterpriseLongDescription;
	}

	public void setVirtualEnterpriseLongDescription(String virtualEnterpriseLongDescription) {
		this.virtualEnterpriseLongDescription= virtualEnterpriseLongDescription == null || virtualEnterpriseLongDescription.length() <= 1000 ? virtualEnterpriseLongDescription
				: virtualEnterpriseLongDescription.substring(0, 1000);
	}
	
	@XmlElement(name = "Name")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null || name.length() <= 50 ? name : name.substring(0, 50);
	}
	
	@XmlElementWrapper(name = "Members")
	@XmlElement(name = "EnterpriseMember")
	public List<EnterpriseMember> getMembers() {
		return members;
	}

	public void setMembers(List<EnterpriseMember> members) {
		this.members = members;
	}

}
