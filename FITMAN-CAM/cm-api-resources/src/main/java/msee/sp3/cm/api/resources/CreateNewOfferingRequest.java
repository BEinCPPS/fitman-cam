package msee.sp3.cm.api.resources;

import java.util.Map;

/**
 *
 */
public class CreateNewOfferingRequest {


    /**
     * Marketplace and store to which the service offering will be added, with the
     * given creator username.
     */
    String marketplaceName;
    String storeName;
    String creatorUsername;
    /**
     * The instantiated template will be uploaded to the specified USDL repository
     */
    String usdlRepositoryName;
    /**
     * Service template to be instantiated and values of variables.
     */
    String serviceTemplateName;
    Map<String, String> variableValues;

    /**
     * This name will be used as identifier of the new service and the uploaded USDL.
     */
    private String serviceName;
    private String serviceDescription;

    public String getMarketplaceName() {
        return marketplaceName;
    }

    public void setMarketplaceName(String marketplaceName) {
        this.marketplaceName = marketplaceName;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getCreatorUsername() {
        return creatorUsername;
    }

    public void setCreatorUsername(String creatorUsername) {
        this.creatorUsername = creatorUsername;
    }

    public String getUsdlRepositoryName() {
        return usdlRepositoryName;
    }

    public void setUsdlRepositoryName(String usdlRepositoryName) {
        this.usdlRepositoryName = usdlRepositoryName;
    }

    public String getServiceTemplateName() {
        return serviceTemplateName;
    }

    public void setServiceTemplateName(String serviceTemplateName) {
        this.serviceTemplateName = serviceTemplateName;
    }

    public Map<String, String> getVariableValues() {
        return variableValues;
    }

    public void setVariableValues(Map<String, String> variableValues) {
        this.variableValues = variableValues;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getServiceDescription() {
        return serviceDescription;
    }

    public void setServiceDescription(String serviceDescription) {
        this.serviceDescription = serviceDescription;
    }
}
