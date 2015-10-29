package org.fiware.apps.marketplace.model;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

@XmlRootElement(name="comparedAttribute")
public class ComparisonResultAttribute {
	private Double value;
	private Double minValue;
	private Double maxValue;
	private Double score;
	private Integer index;
	private String unit;
	private String label;
	private String type;
	private String typeLabel;
	private String typeUri;
	private String uri;
	private List<ComparisonResultAttribute> valueReferences;
	
	public ComparisonResultAttribute () {
		
	}

	@XmlAttribute
	public Double getValue() {
		return value;
	}

	@XmlAttribute
	public Double getMinValue() {
		return minValue;
	}

	@XmlAttribute
	public Double getMaxValue() {
		return maxValue;
	}

	@XmlAttribute
	public Double getScore() {
		return score;
	}

	@XmlAttribute
	public String getUnit() {
		return unit;
	}
	
	@XmlAttribute
	public String getTypeLabel() {
		return typeLabel;
	}

	@XmlAttribute
	public String getLabel() {
		return label;
	}
	
	@XmlAttribute
	public String getType() {
		return this.type;
	}

	@XmlAttribute
	public Integer getIndex() {
		return this.index;
	}

	@XmlAttribute
	public String getTypeUri() {
		return typeUri;
	}

	@XmlAttribute
	public String getUri() {
		return uri;
	}

	@XmlElement(name="valueReference")
	public ComparisonResultAttribute[] getValueReferences() {
		if(this.valueReferences == null)
			return null;
		
		return this.valueReferences.toArray(new ComparisonResultAttribute[this.valueReferences.size()]);
	}

}
