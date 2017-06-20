package it.eng.cam.rest.sesame;

import java.io.File;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

import it.eng.cam.rest.Constants;
import it.eng.ontorepo.BeInCpps;
import org.apache.log4j.Logger;

import it.eng.ontorepo.RepositoryDAO;
import it.eng.ontorepo.sesame2.Sesame2RepositoryDAO;

public class SesameRepoManager {
    private static final Logger logger = Logger.getLogger(SesameRepoManager.class.getName());
    public static ResourceBundle finder = null;

    private static String SESAME_REPO_URL = null;
    private static String SESAME_REPO_NAME = null;
    private static String SESAME_REPO_NAMESPACE = null;
    private static String SESAME_MEMORY_STORE_DATA_DIR = null;
    private static String SESAME_RDF_FILE = null;
    private static String SESAME_REPO_TYPE = null;

    static {
        try {
            finder = ResourceBundle.getBundle("cam-service");
            SESAME_REPO_URL = finder.getString("sesame.url");
            SESAME_REPO_NAME = finder.getString("sesame.repository");
            SESAME_REPO_NAMESPACE = finder.getString("sesame.namespace");
            SESAME_MEMORY_STORE_DATA_DIR = finder.getString("sesame.memory.store.data.dir");
            SESAME_RDF_FILE = finder.getString("sesame.rdf.file");
            SESAME_REPO_TYPE = finder.getString("sesame.repo.type");
        } catch (MissingResourceException e) {
            logger.warn(e);
        }
    }

    // SINGLETON
    public static RepositoryDAO getRepoInstance(Class<?> clazz) {
        try {
            if (null != SESAME_REPO_TYPE && !SESAME_REPO_TYPE.isEmpty()) {
                if (SesameRepoType.HTTP.name().equals(SESAME_REPO_TYPE))
                    return getRepoInstanceImpl(clazz);
                else if (SesameRepoType.MEMORY.name().equals(SESAME_REPO_TYPE))
                    return getRepoInstanceInMemoryImpl(clazz);
            } else
                return getRepoInstanceInMemoryImpl(clazz);
        } catch (Exception e) {
            logger.error(e);
        }
        return null;
    }

    public static RepositoryDAO getRepoInstance(String connectionType, Class<?> clazz) {
        try {
            if (null != connectionType) {
                if (connectionType.toLowerCase().contains("http"))
                    return getRepoInstanceImpl(null);
                else if (connectionType.toLowerCase().contains("memory"))
                    return getRepoInstanceInMemoryImpl(clazz);
            } else
                return getRepoInstance(null);
        } catch (Exception e) {
            logger.error(e);
        }
        return null;
    }

    public static RepositoryDAO getRepoInstanceImpl(Class<?> clazz) {
        RepositoryDAO repoInstance = new Sesame2RepositoryDAO(SESAME_REPO_URL, SESAME_REPO_NAME, getNamespace());
        if (null != clazz)
            addRdfFileToInstance(repoInstance, clazz, false);
        return repoInstance;
    }


    // DON'T USE IN PRODUCTION
    public static RepositoryDAO getRepoInstanceInMemoryImpl(Class<?> clazz) {
        logger.warn("\nUsing in MEMORY Store Repo\nONLY For DEV Purpose!");
        RepositoryDAO repoInstance = null;
        URL url = null;
        if (clazz != null)
            url = clazz.getResource(SESAME_MEMORY_STORE_DATA_DIR);
        else
            url = Constants.class.getResource(SESAME_MEMORY_STORE_DATA_DIR);
        File dataDir = null;
        try {
            dataDir = new File(url.toURI());
        } catch (URISyntaxException e) {
            logger.error(e);
        }
        repoInstance = new Sesame2RepositoryDAO(dataDir, getNamespace());
        if (null != clazz)
            addRdfFileToInstance(repoInstance, clazz, false);
        return repoInstance;
    }


    private static void addRdfFileToInstance(RepositoryDAO repoInstance, Class<?> clazz, boolean forceAdd) {
        if (null == repoInstance)
            logger.error("Impossible to get a Repository connection use getRepoInstance()");
        try {
            URL url = clazz.getResource(SESAME_RDF_FILE);
            File file = new File(url.toURI());
            repoInstance.addRdfFileToRepo(file, null, forceAdd);
        } catch (RuntimeException e) {
            logger.error(e);
        } catch (URISyntaxException e) {
            logger.error(e);
        }
    }

    public static void releaseRepoDaoConn(RepositoryDAO repoInstance) {
        if (repoInstance != null) {
            Sesame2RepositoryDAO sRepo = (Sesame2RepositoryDAO) repoInstance;
            sRepo.release();
            repoInstance = null;
        }
    }


    public static RepositoryDAO restartRepoDaoConn(RepositoryDAO repoInstance) {
        return doRestartRepoDaoConn(repoInstance, null);
    }

    public static RepositoryDAO restartRepoDaoConn(RepositoryDAO repoInstance, Class<?> clazz) {
        return doRestartRepoDaoConn(repoInstance, clazz);
    }

    private static RepositoryDAO doRestartRepoDaoConn(RepositoryDAO repoInstance, Class<?> clazz) {
        if (repoInstance != null) {
            String connection = null;
            Sesame2RepositoryDAO sRepo = (Sesame2RepositoryDAO) repoInstance;
            if (null != sRepo && null != sRepo.getRepo() && null != sRepo.getRepo().getConnection())
                connection = sRepo.getRepo().getConnection().toString();
            sRepo.release();
            return getRepoInstance(connection, clazz);
        }
        return null;
    }

    public static String getNamespace() {
        return BeInCpps.NS + "/ontology/" + SESAME_REPO_NAMESPACE + "#";
    }
}
