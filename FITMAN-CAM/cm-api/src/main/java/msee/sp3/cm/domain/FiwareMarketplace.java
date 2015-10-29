package msee.sp3.cm.domain;

import javax.persistence.*;

/**
 *
 */
@javax.persistence.Table(name = "FIWARE_MARKETPLACE", schema = "", catalog = "msee_sp3_cm")
@Entity
@NamedQueries(
        {
                @NamedQuery(
                        name = "msee.sp3.cm.domain.FiwareMarketplace.findByName",
                        query = "SELECT f FROM FiwareMarketplace f WHERE f.name = ?1"
                ),
                @NamedQuery(
                        name = "msee.sp3.cm.domain.FiwareMarketplace.findAll",
                        query = "SELECT f FROM FiwareMarketplace f ORDER BY f.name ASC"
                ),
                @NamedQuery(
                        name = "msee.sp3.cm.domain.FiwareMarketplace.countAll",
                        query = "SELECT COUNT(f) FROM FiwareMarketplace f"
                )
        }
)
public class FiwareMarketplace {
    private int id;

    @javax.persistence.Column(name = "ID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String name;

    @javax.persistence.Column(name = "NAME")
    @Basic
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    private String url;

    @javax.persistence.Column(name = "URL")
    @Basic
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    private String ecosystem;

    @javax.persistence.Column(name = "ECOSYSTEM")
    @Basic
    public String getEcosystem() {
        return ecosystem;
    }

    public void setEcosystem(String ecosystem) {
        this.ecosystem = ecosystem;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof FiwareMarketplace)) return false;

        FiwareMarketplace that = (FiwareMarketplace) o;

        if (!name.equals(that.name)) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }
}
