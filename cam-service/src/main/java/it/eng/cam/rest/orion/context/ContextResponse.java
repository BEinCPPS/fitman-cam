package it.eng.cam.rest.orion.context;

import javax.json.JsonObject;


public class ContextResponse {
	
    private ContextElement contextElement;
    private StatusCode statusCode;
    
    
	public ContextResponse() {
		
	}

    public ContextResponse(JsonObject json) {

        this.contextElement = new ContextElement(json.getJsonObject("contextElement"));
        this.statusCode = new StatusCode(json.getJsonObject("statusCode"));

    }

    public ContextElement getContextElement() {
        return this.contextElement;
    }

    public void setContextElement(ContextElement contextElement) {
        this.contextElement = contextElement;
    }

    public StatusCode getStatusCode() {
        return this.statusCode;
    }

    public void setStatusCode(StatusCode statusCode) {
        this.statusCode = statusCode;
    }


    
}
