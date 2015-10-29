package it.eng.asset.bean;

import java.util.Date;

public class ServiceAssets {

	private Integer idServiceAsset;
	private Integer idService;
	private Integer idLocalService;
	private Date Created;
	private Integer userId;
	

	

	public Integer getIdServiceAsset() {
		return idServiceAsset;
	}

	public void setIdServiceAsset(Integer idServiceAsset) {
		this.idServiceAsset = idServiceAsset;
	}

	public Integer getIdService() {
		return idService;
	}

	public void setIdService(Integer idService) {
		this.idService = idService;
	}

	public Integer getIdLocalService() {
		return idLocalService;
	}

	public void setIdLocalService(Integer idLocalService) {
		this.idLocalService = idLocalService;
	}

	public Date getCreated() {
		return Created;
	}

	public void setCreated(Date createDate) {
		Created = createDate;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
	
}
