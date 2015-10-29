package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.ArrayList;
import java.util.List;

@XmlRootElement(name = "searchresult")
public class SearchResultEntryResource {
	
	private List<SearchResultEntryMatchResource> matches = new ArrayList<SearchResultEntryMatchResource>();

	private ServiceResource service;
	private StoreResource store;
	private FiwareMarketplaceResource marketplaceResource;

	public SearchResultEntryResource(){
	}
	
	@XmlElement
	public ServiceResource getService() {
		return service;
	}

	public void setService(ServiceResource service) {
		this.service = service;
	}

	@XmlElementWrapper
	@XmlElement(name = "match") 
	public List<SearchResultEntryMatchResource> getMatches() {
		return matches;
	}

	public void setMatches(List<SearchResultEntryMatchResource> matches) {
		this.matches = matches;
	}
	
	@XmlElement
	public StoreResource getStore() {
		return store;
	}

	public void setStore(StoreResource store) {
		this.store = store;
	}


    @XmlElement
    public FiwareMarketplaceResource getMarketplaceResource() {
        return marketplaceResource;
    }

    public void setMarketplaceResource(FiwareMarketplaceResource marketplaceResource) {
        this.marketplaceResource = marketplaceResource;
    }
}
