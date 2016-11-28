package it.antonioscatoloni.model;

import org.json.*;


public class User {
	
    private String sha256;
    private String cell;
    private String phone;
    private double dob;
    private double registered;
    private Picture picture;
    private String sha1;
    private Location location;
    private String password;
    private String salt;
    private String username;
    private String pPS;
    private String md5;
    private String email;
    private Name name;
    private String gender;
    
    
	public User() {
		
	}	
        
    public User(JSONObject json) {
    
        this.sha256 = json.optString("sha256");
        this.cell = json.optString("cell");
        this.phone = json.optString("phone");
        this.dob = json.optDouble("dob");
        this.registered = json.optDouble("registered");
        this.picture = new Picture(json.optJSONObject("picture"));
        this.sha1 = json.optString("sha1");
        this.location = new Location(json.optJSONObject("location"));
        this.password = json.optString("password");
        this.salt = json.optString("salt");
        this.username = json.optString("username");
        this.pPS = json.optString("PPS");
        this.md5 = json.optString("md5");
        this.email = json.optString("email");
        this.name = new Name(json.optJSONObject("name"));
        this.gender = json.optString("gender");

    }
    
    public String getSha256() {
        return this.sha256;
    }

    public void setSha256(String sha256) {
        this.sha256 = sha256;
    }

    public String getCell() {
        return this.cell;
    }

    public void setCell(String cell) {
        this.cell = cell;
    }

    public String getPhone() {
        return this.phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public double getDob() {
        return this.dob;
    }

    public void setDob(double dob) {
        this.dob = dob;
    }

    public double getRegistered() {
        return this.registered;
    }

    public void setRegistered(double registered) {
        this.registered = registered;
    }

    public Picture getPicture() {
        return this.picture;
    }

    public void setPicture(Picture picture) {
        this.picture = picture;
    }

    public String getSha1() {
        return this.sha1;
    }

    public void setSha1(String sha1) {
        this.sha1 = sha1;
    }

    public Location getLocation() {
        return this.location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return this.salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPPS() {
        return this.pPS;
    }

    public void setPPS(String pPS) {
        this.pPS = pPS;
    }

    public String getMd5() {
        return this.md5;
    }

    public void setMd5(String md5) {
        this.md5 = md5;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Name getName() {
        return this.name;
    }

    public void setName(Name name) {
        this.name = name;
    }

    public String getGender() {
        return this.gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }


    
}
