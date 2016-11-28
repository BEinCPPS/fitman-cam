package it.antonioscatoloni.model;

import org.json.*;


public class Picture {
	
    private String large;
    private String thumbnail;
    private String medium;
    
    
	public Picture () {
		
	}	
        
    public Picture (JSONObject json) {
    
        this.large = json.optString("large");
        this.thumbnail = json.optString("thumbnail");
        this.medium = json.optString("medium");

    }
    
    public String getLarge() {
        return this.large;
    }

    public void setLarge(String large) {
        this.large = large;
    }

    public String getThumbnail() {
        return this.thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getMedium() {
        return this.medium;
    }

    public void setMedium(String medium) {
        this.medium = medium;
    }


    
}
