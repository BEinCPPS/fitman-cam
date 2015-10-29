package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.*;
import java.util.List;

/**
 *
 */
@XmlRootElement(name = "serviceProvider")
public class ServiceProviderResource {

    private int id;
    private String username, password, email, company;
    private List<TrustedMarketplaceResource> trustedMarketplaces;

    @XmlTransient
    public int getId() {
        return id;
    }

    public void setId(int id) {
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
    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    @XmlElement
    public List<TrustedMarketplaceResource> getTrustedMarketplaces() {
        return trustedMarketplaces;
    }

    public void setTrustedMarketplaces(List<TrustedMarketplaceResource> trustedMarketplaces) {
        this.trustedMarketplaces = trustedMarketplaces;
    }
}
