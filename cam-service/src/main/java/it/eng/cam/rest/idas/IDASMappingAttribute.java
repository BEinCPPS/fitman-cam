package it.eng.cam.rest.idas;


public class IDASMappingAttribute {

    private String ocb_id;
    private String type;
    private String opcua_id;

    public IDASMappingAttribute(String ocb_id, String type, String opcua_id) {
        this.ocb_id = ocb_id;
        this.type = type;
        this.opcua_id = opcua_id;
    }

    public IDASMappingAttribute() {
    }

    public String getOcb_id() {
        return ocb_id;
    }

    public void setOcb_id(String ocb_id) {
        this.ocb_id = ocb_id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getOpcua_id() {
        return opcua_id;
    }

    public void setOpcua_id(String opcua_id) {
        this.opcua_id = opcua_id;
    }
}
