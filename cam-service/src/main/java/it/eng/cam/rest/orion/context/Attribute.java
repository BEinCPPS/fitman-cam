package it.eng.cam.rest.orion.context;


import javax.json.JsonObject;


public class Attribute {

    private String name;
    private String type;
    private String value;

    
	public Attribute() {
		
	}

    public Attribute(String name, String type, String value) {
        this.name = name;
        this.type = type;
        this.value = value;
    }

    public Attribute(JsonObject json) {

        this.name = json.getString("name");
        this.type = json.getString("type");
        this.value = json.getString("value");

    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getValue() {
        return this.value;
    }

    public void setValue(String value) {
        this.value = value;
    }


    
}
