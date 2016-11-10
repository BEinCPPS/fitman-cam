package it.eng.cam.rest.security.authorization;

import it.eng.cam.rest.security.authentication.CAMPrincipal;
import it.eng.cam.rest.security.authentication.CAMSecurityContext;
import it.eng.cam.rest.security.project.Project;

import javax.ws.rs.core.SecurityContext;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ascatolo on 09/11/2016.
 */
public class DomainOwnershipFilter {


    public static List<Project> filterAll(List<Project> projects, SecurityContext securityContext) {
        if (projects == null || projects.isEmpty() || securityContext == null) return projects;
        List<Project> projectsToGive = new ArrayList<>();
        for (Project project :
                projects) {
            if (filter(project, securityContext) != null)
                projectsToGive.add(project);
        }
        return projectsToGive;
    }

    public static Project filter(Project project, SecurityContext securityContext) {
        if (project == null || securityContext == null) return null;
        CAMPrincipal principal = (CAMPrincipal) securityContext.getUserPrincipal();
        if (principal.isAdmin()) return project;
        for (CAMPrincipal.Organization organization :
                principal.getOrganizations()) {
            if (organization.getName().equals(project.getName()))
                return project;
        }
        return null;
    }

}
