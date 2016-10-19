package it.eng.cam.rest.security.authentication.credentials.json;

import java.io.Serializable;

/**
 * Created by ascatolo on 13/10/2016.
 */
public class Domain implements Serializable {
    private String id;

    public Domain(String id) {
        this.id = id;
        if (null == id || id.isEmpty())
            this.id = "default";
    }

    public Domain() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
