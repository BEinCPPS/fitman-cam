package it.eng.sso.lsa;

import org.springframework.util.Assert;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

/**
 * A user principal
 */
public class Principal {
     /**
     * Empty map used to
     */
    private static final Map<String, Object> EMPTY_MAP = Collections.unmodifiableMap(new HashMap<String, Object>());

    /**
     * Username
     */
    private String uid;

    /**
     * Map of attributes; simple attributes are String->String mappings, multi-valued attributes are String->List<String>
     * mappings.
     */
    private Map<String, Object> attributes;

    public Principal(String id) {
        this(id, null);
    }

    public Principal(String id, Map<String, Object> attributes) {
        Assert.notNull(id, "id cannot be null");
        this.uid = id;

        this.attributes = attributes == null || attributes.isEmpty()
                ? EMPTY_MAP : Collections.unmodifiableMap(attributes);
    }


    public String getUid() {
        return uid;
    }

    public Map<String, Object> getAttributes() {
        return attributes;
    }

    public String toString() {
        return this.uid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Principal principal = (Principal) o;

        if (!uid.equals(principal.uid)) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return uid.hashCode();
    }
}
