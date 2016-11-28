package it.antonioscatoloni.model;

import org


public class Location {
	
    private String state;
    private String street;
    private String city;
    private double zip;
    
    
	public Location () {
		
	}	
        
    public Location (JSONObj json) {
    
        this.state = json.optString("state");
        this.street = json.optString("street");
        this.city = json.optString("city");
        this.zip = json.optDouble("zip");

    }
    
    public String getState() {
        return this.state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getStreet() {
        return this.street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return this.city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public double getZip() {
        return this.zip;
    }

    public void setZip(double zip) {
        this.zip = zip;
    }


    
}
