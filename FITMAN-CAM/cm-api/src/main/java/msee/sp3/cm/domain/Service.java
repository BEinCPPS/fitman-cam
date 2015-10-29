package msee.sp3.cm.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@javax.persistence.Table(name = "SERVICE", schema = "", catalog = "msee_sp3_cm")
@Entity
@NamedQueries({
    @NamedQuery(
            name = "msee.sp3.cm.domain.Service.deleteByServiceName",
            query = "DELETE FROM Service serv WHERE serv.serviceName = ?1"
    ),
    @NamedQuery(
            name = "msee.sp3.cm.domain.Service.findByName",
            query = "SELECT serv FROM Service serv WHERE serv.serviceName = ?1"
    )
})

public class Service {

	private Long serviceId;

	@javax.persistence.Column(name = "SERVICE_ID")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long getServiceId() {
		return serviceId;
	}

	public void setServiceId(Long serviceId) {
		this.serviceId = serviceId;
	}

	private String serviceDesc;

	@Column(name = "SERVICE_DESC")
	public String getServiceDesc() {
		return serviceDesc;
	}

	public void setServiceDesc(String serviceDesc) {
		this.serviceDesc = serviceDesc;
	}

	private String serviceName;

	@Column(name = "SERVICE_NAME", nullable = false, unique = true)
	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	
	private Date serviceRegDate;

	@Temporal(TemporalType.DATE)
	@Column(name = "SERVICE_REG_DATE")
	public Date getServiceRegDate() {
		return serviceRegDate;
	}

	public void setServiceRegDate(Date serviceRegDate) {
		this.serviceRegDate = serviceRegDate;
	}
	
	private String serviceUrl;

	@Column(name = "SERVICE_URL", nullable = false, unique = true)
	public String getServiceUrl() {
		return serviceUrl;
	}

	public void setServiceUrl(String serviceUrl) {
		this.serviceUrl = serviceUrl;
	}
	
	private Long localUserCreatorId;

	@Column(name = "LOCALUSER_CREATOR_ID")
	public Long getLocalUserCreatorId() {
		return localUserCreatorId;
	}

	public void setLocalUserCreatorId(Long localUserCreatorId) {
		this.localUserCreatorId = localUserCreatorId;
	}
	
	private Long localUserLastEditorId;
	
	@Column(name = "LOCALUSER_LAST_EDITOR_ID")
	public Long getLocalUserLastEditorId() {
		return localUserLastEditorId;
	}

	public void setLocalUserLastEditorId(Long localUserLastEditorId) {
		this.localUserLastEditorId = localUserLastEditorId;
	}
	
	private Long storeId;

	@Column(name = "STORE_ID")
	public Long getStoreId() {
		return storeId;
	}

	public void setStoreId(Long storeId) {
		this.storeId = storeId;
	}

}
