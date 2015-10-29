package msee.sp3.cm.domain;

import javax.persistence.*;

/**
 *
 */
@javax.persistence.Table(name = "TRUSTED_MARKETPLACE", schema = "", catalog = "msee_sp3_cm")
@Entity
@NamedQueries({
        @NamedQuery(
                name = "msee.sp3.cm.domain.TrustedMarketplace.deleteByFiwareMarketplace",
                query = "DELETE FROM TrustedMarketplace tm WHERE tm.fiwareMarketplace = ?1"
        )
})
public class TrustedMarketplace {
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

    private FiwareMarketplace fiwareMarketplace;

    @ManyToOne
    @JoinColumn(name="TRUSTED_MARKETPLACE_ID", referencedColumnName = "ID", nullable = false)
    public FiwareMarketplace getFiwareMarketplace() {
        return fiwareMarketplace;
    }

    public void setFiwareMarketplace(FiwareMarketplace fiwareMarketplace) {
        this.fiwareMarketplace = fiwareMarketplace;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TrustedMarketplace that = (TrustedMarketplace) o;

        if (id != that.id) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return id;
    }

    private ServiceProvider serviceProvider;

    @ManyToOne
    @javax.persistence.JoinColumn(name = "SERVICE_PROVIDER_ID", referencedColumnName = "ID", nullable = false)
    public ServiceProvider getServiceProvider() {
        return serviceProvider;
    }

    public void setServiceProvider(ServiceProvider serviceProvider) {
        this.serviceProvider = serviceProvider;
    }
}
