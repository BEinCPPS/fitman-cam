package it.eng.cam.rest.sesame;

import java.io.File;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;

import it.eng.ontorepo.RepositoryDAO;
import it.eng.ontorepo.sesame2.Sesame2RepositoryDAO;

public class SesameRepoInstance {
	private static RepositoryDAO repoInstance;
	private static final Logger logger = Logger.getLogger(SesameRepoInstance.class.getName());
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
		if (null != SESAME_REPO_TYPE && !SESAME_REPO_TYPE.isEmpty()) {
			if (SesameRepoType.HTTP.name().equals(SESAME_REPO_TYPE))
				repoInstance = getRepoInstanceImpl(clazz);
			else if (SesameRepoType.MEMORY.name().equals(SESAME_REPO_TYPE))
				repoInstance = getRepoInstanceInMemoryImpl(clazz);
		} else
			repoInstance = getRepoInstanceInMemoryImpl(clazz);
		return repoInstance;
	}

	public static RepositoryDAO getRepoInstanceImpl(Class<?> clazz) {
		if (repoInstance == null) {
			synchronized (SesameRepoInstance.class) {
				if (repoInstance == null) {
					repoInstance = new Sesame2RepositoryDAO(SESAME_REPO_URL, SESAME_REPO_NAME, SESAME_REPO_NAMESPACE);
					addRdfFileToInstance(clazz, false);
				}
			}
		}
		return repoInstance;
	}
	
	// SINGLETON IN MEMORY
	// DON'T USE IN PRODUCTION
	public static RepositoryDAO getRepoInstanceInMemoryImpl(Class<?> clazz) {
		logger.warn("\nUsing in MEMORY Store Repo\nONLY For DEV Purpose!");
		if (repoInstance == null) {
			synchronized (SesameRepoInstance.class) {
				if (repoInstance == null) {
					URL url = clazz.getResource(SESAME_MEMORY_STORE_DATA_DIR);
					File dataDir = null;
					try {
						dataDir = new File(url.toURI());
					} catch (URISyntaxException e) {
						logger.error(e);
					}
					repoInstance = new Sesame2RepositoryDAO(dataDir, SESAME_REPO_NAMESPACE);
					addRdfFileToInstance(clazz, false);

				}
			}
		}
		return repoInstance;
	}


	// SINGLETON
	public static RepositoryDAO getRepoInstance(Class<?> clazz, String sesameRepoUrl, String sesameRepoName,
			String sesameRepoNameSpace) {
		if (repoInstance == null) {
			synchronized (SesameRepoInstance.class) {
				if (repoInstance == null) {
					repoInstance = new Sesame2RepositoryDAO(sesameRepoUrl, sesameRepoName, sesameRepoNameSpace);
					addRdfFileToInstance(clazz, false);
				}
			}
		}
		return repoInstance;
	}


	private static void addRdfFileToInstance(Class<?> clazz, boolean forceAdd) {
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

	public synchronized static void releaseRepoDaoConn() {
		if (repoInstance != null) {
			Sesame2RepositoryDAO sRepo = (Sesame2RepositoryDAO) repoInstance;
			sRepo.release();
			repoInstance = null;
		}
	}
}
