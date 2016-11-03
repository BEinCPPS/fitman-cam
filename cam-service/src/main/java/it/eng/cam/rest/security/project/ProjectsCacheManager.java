package it.eng.cam.rest.security.project;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by ascatolo on 02/11/2016.
 */
public class ProjectsCacheManager {
    private Map<String, Project> cache;
    private static ProjectsCacheManager instance = null;

    private ProjectsCacheManager() {
        cache = new HashMap<>();
    }

    public static ProjectsCacheManager getInstance() {
        if (null == instance) {
            synchronized (ProjectsCacheManager.class) {
                if (null == instance) {
                    instance = new ProjectsCacheManager();
                }
            }
        }
        return instance;
    }


    public Map<String, Project> getCache() {
        return cache;
    }

}

  
