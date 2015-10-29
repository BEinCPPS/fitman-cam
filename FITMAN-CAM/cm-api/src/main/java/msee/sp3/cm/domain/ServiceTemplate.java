package msee.sp3.cm.domain;

import javax.persistence.*;

/**
 *
 */
@Table(name = "SERVICE_TEMPLATE", schema = "", catalog = "msee_sp3_cm")
@Entity
@NamedQueries(
        {
                @NamedQuery(
                        name = "msee.sp3.cm.domain.ServiceTemplate.findByName",
                        query = "SELECT st FROM ServiceTemplate st WHERE st.name = ?1"
                ),
                @NamedQuery(
                        name = "msee.sp3.cm.domain.ServiceTemplate.findAll",
                        query = "SELECT st FROM ServiceTemplate st ORDER BY st.name ASC"
                ),
                @NamedQuery(
                        name = "msee.sp3.cm.domain.ServiceTemplate.countAll",
                        query = "SELECT COUNT(st) FROM ServiceTemplate st"
                )
        }
)
public class ServiceTemplate {
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

    private String templateText;

    @Column(name = "TEMPLATE_TEXT", nullable = false)
    public String getTemplateText() {
        return templateText;
    }

    public void setTemplateText(String template) {
        this.templateText = template;
    }
    
    private String templateDescription;
    
    @Column(name = "TEMPLATE_DESCRIPTION", nullable = false)
    public String getTemplateDescription() {
        return templateDescription;
    }

    public void setTemplateDescription(String templateDescription) {
        this.templateDescription = templateDescription;
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ServiceTemplate)) return false;

        ServiceTemplate that = (ServiceTemplate) o;

        if (!name.equals(that.name)) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }
}
