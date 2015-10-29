package msee.sp3.cm.domain;

import javax.persistence.*;
import java.util.List;

/**
 *
 */
@javax.persistence.Table(name = "SERVICE_PROVIDER", schema = "", catalog = "msee_sp3_cm")
@Entity
@NamedQueries({
        @NamedQuery(
                name = "msee.sp3.cm.domain.ServiceProvider.findByUsername",
                query = "SELECT sp FROM ServiceProvider sp WHERE sp.username = ?1"
        ),
        @NamedQuery(
                name = "msee.sp3.cm.domain.ServiceProvider.findByUsernameAndPasswordHash",
                query = "SELECT sp FROM ServiceProvider sp WHERE sp.username = ?1 AND sp.passwordHash = ?2"
        ),
        @NamedQuery(
                name = "msee.sp3.cm.domain.ServiceProvider.findAll",
                query = "SELECT sp FROM ServiceProvider sp ORDER BY sp.username"
        ),
        @NamedQuery(
                name = "msee.sp3.cm.domain.ServiceProvider.countAll",
                query = "SELECT COUNT(sp) FROM ServiceProvider sp"
        )
    }
)
public class ServiceProvider {
    private Integer id;

    @javax.persistence.Column(name = "ID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    private String username;

    @javax.persistence.Column(name = "USERNAME", nullable = false, unique = true)
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ServiceProvider that = (ServiceProvider) o;

        if (id != that.id) return false;
        if (username != null ? !username.equals(that.username) : that.username != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (username != null ? username.hashCode() : 0);
        return result;
    }

    private List<TrustedMarketplace> trustedMarketplaces;

    @OneToMany(mappedBy = "serviceProvider", fetch = FetchType.EAGER)
    public List<TrustedMarketplace> getTrustedMarketplaces() {
        return trustedMarketplaces;
    }

    public void setTrustedMarketplaces(List<TrustedMarketplace> trustedMarketplaces) {
        this.trustedMarketplaces = trustedMarketplaces;
    }

    private String email;

    @Basic(optional = false)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    private String company;

    @Basic(optional = false)
    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    private String passwordHash;

    @Column(name = "PASSWORD_HASH", nullable = false)
    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    @Override
    public String toString() {
        return "ServiceProvider{" +
                "id=" + id +
                ", username='" + username + '\'' +
                '}';
    }
}
