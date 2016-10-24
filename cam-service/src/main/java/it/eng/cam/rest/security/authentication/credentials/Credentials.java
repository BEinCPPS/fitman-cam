package it.eng.cam.rest.security.authentication.credentials;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ascatolo on 13/10/2016.
 */
public class Credentials implements Serializable{

    Auth auth;

    public Auth getAuth() {
        return auth;
    }

    public void setAuth(Auth auth) {
        this.auth = auth;
    }

    /**
     * Created by ascatolo on 13/10/2016.
     */
    public static class Auth implements Serializable {
        private Identity identity;

        public Identity getIdentity() {
            return identity;
        }

        public void setIdentity(Identity identity) {
            this.identity = identity;
        }
    }

    /**
     * Created by ascatolo on 13/10/2016.
     */
    public static class Identity implements Serializable {
        private List<String> methods;
        private Password password;

        public Identity() {
            this.methods = new ArrayList<String>();
            methods.add("password");
        }


        public List<String> getMethods() {
            return methods;
        }

        public void setMethods(List<String> methods) {
            this.methods = methods;
        }

        public Password getPassword() {
            return password;
        }

        public void setPassword(Password password) {
            this.password = password;
        }
    }

    /**
     * Created by ascatolo on 13/10/2016.
     */
    public static class Domain implements Serializable {
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

    /**
     * Created by ascatolo on 13/10/2016.
     */


    public static class Password implements Serializable {
        private User user;


        public User getUser() {
            return user;
        }

        public void setUser(User user) {
            this.user = user;
        }


    }

    /**
     * Created by ascatolo on 13/10/2016.
     */

    public static class User implements Serializable {
        private String name;
        private String password;

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public User(String name, Domain domain, String password) {
            this.name = name;
            this.domain = domain;
            this.password = password;
        }

        public User() {
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public Domain getDomain() {
            return domain;
        }

        public void setDomain(Domain domain) {
            this.domain = domain;
        }

        private Domain domain;

    }
}
