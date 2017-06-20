package it.eng.cam.rest.orion.context;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.json.JsonArray;
import javax.json.JsonObject;
import java.util.ArrayList;

public class ContextElement {
	
    private String id;
    private String type;
    private ArrayList<Attribute> attributes;
    private String isPattern;
    @JsonIgnore
    private String originalAssetName;
    @JsonIgnore
    private String orionConfigId;
    @JsonIgnore
    private String domainName;


    public ContextElement(String id, String type, ArrayList<Attribute> attributes, String isPattern) {
        this.attributes = new ArrayList<>();
        this.id = id;
        this.type = type;
        this.attributes = attributes;
        this.isPattern = isPattern;
    }

    public ContextElement () {
        this.attributes = new ArrayList<>();
	}	
        
    public ContextElement (JsonObject json) {
    
        this.id = json.getString("id");
        this.type = json.getString("type");

        this.attributes = new ArrayList<>();
        JsonArray arrayAttributes = json.getJsonArray("attributes");
        if (null != arrayAttributes) {
            int attributesLength = arrayAttributes.size();
            for (int i = 0; i < attributesLength; i++) {
                JsonObject item = arrayAttributes.getJsonObject(i);
                if (null != item) {
                    this.attributes.add(new Attribute(item));
                }
            }
        }
        else {
            JsonObject item = json.getJsonObject("attributes");
            if (null != item) {
                this.attributes.add(new Attribute(item));
            }
        }

        this.isPattern = json.getString("isPattern");

    }
    
    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public ArrayList<Attribute> getAttributes() {
        return this.attributes;
    }

    public void setAttributes(ArrayList<Attribute> attributes) {
        this.attributes = attributes;
    }

    public String getOrionConfigId() {
        return orionConfigId;
    }

    public void setOrionConfigId(String orionConfigId) {
        this.orionConfigId = orionConfigId;
    }

    public String getIsPattern() {
        return this.isPattern;
    }

    public void setIsPattern(String isPattern) {
        this.isPattern = isPattern;
    }

    public String getOriginalAssetName() {
        return originalAssetName;
    }

    public void setOriginalAssetName(String originalAssetName) {
        this.originalAssetName = originalAssetName;
    }

    public String getDomainName() {
        return domainName;
    }

    public void setDomainName(String domainName) {
        this.domainName = domainName;
    }
}
