package it.eng.cam.rest.idas;

import java.util.ArrayList;

public class IDASMappingContext {

    private String id;
    private String type;
    private ArrayList<IDASMappingAttribute> mappings;

    public IDASMappingContext(String id, String type, ArrayList<IDASMappingAttribute> mappings) {
        this.id = id;
        this.type = type;
        this.mappings = mappings;
    }

    public String getId() {
        return id;
    }

    public IDASMappingContext() {
        this.mappings = new ArrayList<>();
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public ArrayList<IDASMappingAttribute> getMappings() {
        return mappings;
    }

    public void setMappings(ArrayList<IDASMappingAttribute> mappings) {
        this.mappings = mappings;
    }
}
