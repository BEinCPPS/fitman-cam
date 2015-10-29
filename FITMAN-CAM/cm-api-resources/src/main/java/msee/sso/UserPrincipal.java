package msee.sso;

import java.util.List;

/**
 * Immutable class representing a user in MSEE ecosystem
 */
public class UserPrincipal {

    private final String username, name, email, mseeOrganization, ecosystem;
    private final List<String> roles;

    public UserPrincipal(String username, String name, String email, String mseeOrganization, String ecosystem, List<String> roles) {
        this.username = username;
        this.name = name;
        this.email = email;
        this.mseeOrganization = mseeOrganization;
        this.ecosystem = ecosystem;
        this.roles = roles;
    }

    public String getUsername() {
        return username;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getMseeOrganization() {
        return mseeOrganization;
    }

    public String getEcosystem() {
        return ecosystem;
    }

    public List<String> getRoles() {
        return roles;
    }
}
