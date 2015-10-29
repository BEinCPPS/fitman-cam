package it.eng.asset.bean;


public class LocalService {

	private Integer idLocalService;
	private String name;
	private String serviceDescription;
	private String nameAsset;
	private String owner;
	private String created;
	private String publishedDate;
	private String published;
	private Integer userId;
	

	public String getPublishedDate() {
		return publishedDate;
	}
	public void setPublishedDate(String publishedDate) {
		this.publishedDate = publishedDate;
	}
	public Integer getIdLocalService() {
		return idLocalService;
	}
	public void setIdLocalService(Integer idLocalService) {
		this.idLocalService = idLocalService;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getServiceDescription() {
		return serviceDescription;
	}
	public void setServiceDescription(String serviceDescription) {
		this.serviceDescription = serviceDescription;
	}
	public String getNameAsset() {
		if (nameAsset == null) {
			nameAsset = "";
		}
		return nameAsset;
	}
	public void setNameAsset(String nameAsset) {
		this.nameAsset = nameAsset;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getPublished() {
		return published;
	}
	public void setPublished(String published) {
		this.published = published;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}


		
		
	}
