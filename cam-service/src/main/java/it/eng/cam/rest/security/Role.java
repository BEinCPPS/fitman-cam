package it.eng.cam.rest.security;

/**
 * Created by ascatolo on 17/10/2016.
 */
public enum Role {
    DEFAULT,
    ADMIN;

    public Role setValue(int value) {
        this.value = value;
        return this;
    }

    public int value;
}