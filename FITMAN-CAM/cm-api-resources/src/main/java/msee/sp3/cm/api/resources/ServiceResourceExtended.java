package msee.sp3.cm.api.resources;

import java.util.Date;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlSchemaType;

@XmlRootElement(name = "service")
public class ServiceResourceExtended {

	private Long serviceId;
	
	@XmlElement
	public Long getServiceId() {
		return serviceId;
	}

	public void setServiceId(Long serviceId) {
		this.serviceId = serviceId;
	}

	private String serviceDesc;

	@XmlElement
	public String getServiceDesc() {
		return serviceDesc;
	}

	public void setServiceDesc(String serviceDesc) {
		this.serviceDesc = serviceDesc;
	}

	private String serviceName;

	@XmlElement
	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	private Date serviceRegDate;

	@XmlElement
	@XmlSchemaType(name = "date")
	public Date getServiceRegDate() {
		return serviceRegDate;
	}

	public void setServiceRegDate(Date serviceRegDate) {
		this.serviceRegDate = serviceRegDate;
	}

	private String serviceUrl;

	@XmlElement
	public String getServiceUrl() {
		return serviceUrl;
	}

	public void setServiceUrl(String serviceUrl) {
		this.serviceUrl = serviceUrl;
	}

	private Long localUserCreatorId;

	
	@XmlElement
	public Long getLocalUserCreatorId() {
		return localUserCreatorId;
	}

	public void setLocalUserCreatorId(Long localUserCreatorId) {
		this.localUserCreatorId = localUserCreatorId;
	}

	private Long localUserLastEditorId;

	
	@XmlElement
	public Long getLocalUserLastEditorId() {
		return localUserLastEditorId;
	}

	public void setLocalUserLastEditorId(Long localUserLastEditorId) {
		this.localUserLastEditorId = localUserLastEditorId;
	}

	private Long storeId;

	
	@XmlElement
	public Long getStoreId() {
		return storeId;
	}

	public void setStoreId(Long storeId) {
		this.storeId = storeId;
	}

}
