package it.eng.cam.rest.orion.context;

import javax.json.JsonArray;
import javax.json.JsonObject;
import java.util.ArrayList;
import java.util.List;

public class ContextContainerJSON {

    private List<ContextResponse> contextResponses;

    public ContextContainerJSON() {

    }

    public ContextContainerJSON(JsonObject json) {
        this.contextResponses = new ArrayList<>();
        JsonArray arrayContextResponses = json.getJsonArray("contextResponses");
        if (null != arrayContextResponses) {
            int contextResponsesLength = arrayContextResponses.size();
            for (int i = 0; i < contextResponsesLength; i++) {
                JsonObject item = arrayContextResponses.getJsonObject(i);
                if (null != item) {
                    this.contextResponses.add(new ContextResponse(item));
                }
            }
        } else {
            JsonObject item = json.getJsonObject("contextResponses");
            if (null != item) {
                this.contextResponses.add(new ContextResponse(item));
            }
        }
    }

    public List<ContextResponse> getContextResponses() {
        return this.contextResponses;
    }

    public void setContextResponses(ArrayList<ContextResponse> contextResponses) {
        this.contextResponses = contextResponses;
    }


}
