package it.eng.asset.view.vaadin;

import java.io.Serializable;

import com.liferay.portal.model.User;

public class ModelSession implements Serializable {

	private static final long serialVersionUID = 1L;

	private Boolean inizialized = false;
	private String asset_name;
	private String service_name;
	private String class_name;
	private String local_service_name;
	private int active_tree = 0;
	private User loggedInUser;

	public int getActive_tree() {
		return active_tree;
	}

	public void setActive_tree(int active_tree) {
		this.active_tree = active_tree;
	}

	public String getLocal_service_name() {
		return local_service_name;
	}

	public void setLocal_service_name(String local_service_name) {
		this.local_service_name = local_service_name;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public String getService_name() {
		return service_name;
	}

	public void setService_name(String service_name) {
		this.service_name = service_name;
	}

	public String getAsset_name() {
		return asset_name;
	}

	public void setAsset_name(String asset_name) {
		this.asset_name = asset_name;
	}

	public Boolean getInizialized() {
		return inizialized;
	}

	public void setInizialized(Boolean inizialized) {
		this.inizialized = inizialized;
	}

	public User getLoggedInUser() {
		return loggedInUser;
	}

	public void setLoggedInUser(User loggedInUser) {
		this.loggedInUser = loggedInUser;
	}

	public void resetAll() {
		this.class_name = null;
		this.inizialized = false;
		this.asset_name = null;
		this.service_name = null;
		this.local_service_name = null;
	}

}
