/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package msee.sp3.cm.domain;

import javax.persistence.*;

/**
 *
 * author Singular
 */
@Table(name = "USDL_REPOSITORY", schema = "", catalog = "msee_sp3_cm")
@Entity
@NamedQueries(
        {
                @NamedQuery(
                        name = "msee.sp3.cm.domain.UsdlRepository.findByName",
                        query = "SELECT ur FROM UsdlRepository ur WHERE ur.name = ?1"
                ),
                @NamedQuery(
                        name = "msee.sp3.cm.domain.UsdlRepository.findAll",
                        query = "SELECT ur FROM UsdlRepository ur ORDER BY ur.name ASC"
                ),
                @NamedQuery(
                        name = "msee.sp3.cm.domain.UsdlRepository.countAll",
                        query = "SELECT COUNT(ur) FROM UsdlRepository ur"
                )
        }
)
public class UsdlRepository {
    private int id;

    @Column(name = "ID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String name;

    @Column(name = "NAME")
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
    
    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof UsdlRepository)) {
            return false;
        }

        UsdlRepository that = (UsdlRepository) o;

        if (!name.equals(that.name)) {
            return false;
        }

        return true;
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }
}
