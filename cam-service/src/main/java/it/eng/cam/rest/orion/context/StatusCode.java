package it.eng.cam.rest.orion.context;


import javax.json.JsonObject;

public class StatusCode {
	
    private String reasonPhrase;
    private String code;
    
    
	public StatusCode () {
		
	}	
        
    public StatusCode (JsonObject json) {

        this.reasonPhrase = json.getString("reasonPhrase");
        this.code = json.getString("code");

    }

    public String getReasonPhrase() {
        return this.reasonPhrase;
    }

    public void setReasonPhrase(String reasonPhrase) {
        this.reasonPhrase = reasonPhrase;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }


    
}
