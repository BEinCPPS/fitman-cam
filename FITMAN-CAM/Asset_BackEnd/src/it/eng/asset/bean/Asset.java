package it.eng.asset.bean;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;


public class Asset {
	
	  private String name;
	  private String namespace;
	  private String assetClass;
	  private String model;
	  @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyyMMdd HH:mm:ss", timezone="GMT")
	  private Date created;
	  private String owner;
	  private String globalname;
	
	public String getGlobalName() {
		return globalname;
	}
	public void setGlobalName(String globalname) {
		this.globalname = globalname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNamespace() {
		return namespace;
	}
	public void setNamespace(String namespace) {
		this.namespace = namespace;
	}
	public String getAssetClass() {
		return assetClass;
	}
	public void setAssetClass(String assetClass) {
		this.assetClass = assetClass;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}


}
