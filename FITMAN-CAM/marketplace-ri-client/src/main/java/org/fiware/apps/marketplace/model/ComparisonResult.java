package org.fiware.apps.marketplace.model;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@XmlRootElement(name = "comparisonResults")
public class ComparisonResult {
	
	private ServiceContainer source;
	private List<ServiceContainer> targets;
	
	public static class ServiceContainer {
		private Integer id;
		private String name;
		private String offeringUri;
		private String offeringTitle;
		private String storeUrl;
		private String pricePlanUri;
		private String pricePlanTitle;
		private Double totalScore;
		private List<ComparisonResultAttribute> attributes;
		
		public ServiceContainer() {
			
		}
		
		public ServiceContainer(ServiceManifestation service) {
			this.id = service.getId();
			this.name = service.getName();
			this.attributes = new ArrayList<ComparisonResultAttribute>();
			this.offeringUri = service.getOfferingUri();
			this.offeringTitle = service.getOfferingTitle();
			this.storeUrl = service.getStoreUrl();
			this.pricePlanUri = service.getPricePlanUri();
			this.pricePlanTitle = service.getPricePlanTitle();
		}
				
		@XmlAttribute
		public Integer getId() {
			return id;
		}

		@XmlAttribute
		public String getName() {
			return name;
		}

		@XmlAttribute
		public Double getTotalScore() {
			return totalScore;
		}

		@XmlElement(name="attribute")
		public List<ComparisonResultAttribute> getAttributes() {
			return attributes;
		}
		
		@XmlAttribute
		public String getOfferingUri() {
			return offeringUri;
		}

		@XmlAttribute
		public String getPricePlanUri() {
			return pricePlanUri;
		}

		@XmlAttribute
		public String getOfferingTitle() {
			return offeringTitle;
		}

		@XmlAttribute
		public String getPricePlanTitle() {
			return pricePlanTitle;
		}

		@XmlAttribute
		public String getStoreUrl() {
			return storeUrl;
		}
		
		public void setTotalScore(Double totalScore) {
			this.totalScore = totalScore;
		}
	}
	
	public ComparisonResult() {
		targets = new ArrayList<ServiceContainer>();
	}

	
	@XmlElement(name="source")
	public ServiceContainer getSource() {
		return source;
	}

	@XmlElementWrapper(name="targets")
	@XmlElement(name="target")
	public List<ServiceContainer> getTargets() {
		Collections.sort(targets, new Comparator<ServiceContainer>() {
            public int compare(ServiceContainer c1, ServiceContainer c2) {
                if (c1.getTotalScore() > c2.getTotalScore())
                    return -1;
                if (c1.getTotalScore() < c2.getTotalScore())
                    return 1;
                return 0;
            }
        });
		return targets;
	}
}
