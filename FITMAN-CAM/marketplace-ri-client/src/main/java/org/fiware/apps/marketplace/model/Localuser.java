package org.fiware.apps.marketplace.model;

import javax.xml.bind.annotation.*;
import java.util.Date;

@XmlRootElement(name = "user")
public class Localuser {
	private Integer id;
	private String username;
	private String password;
	private String email;
	private Date registrationDate;
	private String company;


	@XmlTransient
	public Integer getId() {
		return id;
	}
	public void setId(Integer  id) {
		this.id = id;
	}
	
	@XmlID
	@XmlAttribute 
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	@XmlElement
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	@XmlElement
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	@XmlElement
    public Date getRegistrationDate() {
		return registrationDate;
	}	
	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}
	
	@XmlElement
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}

    @Override
    public String toString() {
        return "Localuser{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", registrationDate=" + registrationDate +
                ", company='" + company + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Localuser)) return false;

        Localuser localuser = (Localuser) o;

        if (!username.equals(localuser.username)) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return username.hashCode();
    }
}
