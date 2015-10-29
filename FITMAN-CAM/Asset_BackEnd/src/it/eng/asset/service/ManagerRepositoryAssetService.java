package it.eng.asset.service;

import it.eng.asset.bean.Asset;
import it.eng.asset.bean.AssetClass;
import it.eng.asset.bean.AssetRest;
import it.eng.asset.bean.GenericService;
import it.eng.asset.bean.LocalService;
import it.eng.asset.bean.LocalServiceRest;
import it.eng.asset.bean.Property;
import it.eng.asset.bean.PublicService;
import it.eng.asset.bean.PublicServiceRest;
import it.eng.asset.bean.ServiceAssets;
import it.eng.asset.dao.AssetDAO;
import it.eng.asset.resources.Constants;
import it.eng.asset.utils.MybatisUtil;
import it.eng.msee.ontorepo.ClassItem;
import it.eng.msee.ontorepo.IndividualItem;
import it.eng.msee.ontorepo.PropertyDeclarationItem;
import it.eng.msee.ontorepo.PropertyValueItem;
import it.eng.msee.ontorepo.Util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public class ManagerRepositoryAssetService implements VirtualizedRepositoryManager {
	
	public List<AssetClass> lAssetClass = new ArrayList<AssetClass>();
	
    private static it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO dao = null;
	String url = Constants.getSesameUrl();
	String sesame_repository = Constants.getSesameRepository();
	String namespace = Constants.getSesameNamespace();
    
    public ManagerRepositoryAssetService() {
    	
    
    }
	
	
	
	@Override
	public List<PublicService> getPublicList() throws Exception {
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		try {
			return dao.getPublicServiceList();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} 		finally {
			if (sqlSession != null)
			sqlSession.close();
		}

	}

	@Override
	public List<LocalService> getLocalServiceDetail(String nameService) throws Exception
	{
		SqlSession sqlSession = null;
		try {
			sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			Map<String, String> map = new HashMap<String, String>();
			map.put("NameService", nameService);
			return dao.getLocalServiceDetail(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} 			finally {
			if (sqlSession != null)
			sqlSession.close();
		}


	}

	@Override
	public List<LocalService> getLocalServicePublished() throws Exception
	{
		SqlSession sqlSession = null;
		try {
			sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			return dao.getLocalServicePublished();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} 		finally {
			if (sqlSession != null)
			sqlSession.close();
		}

	}
	
	

	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getPublicService(java.lang.String)
	 */
	@Override
	public PublicService getPublicService(String namePublicService) throws Exception {

		SqlSession sqlSession = null;
		try {
			sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			Map<String, String> map = new HashMap<String, String>();
			map.put("name", namePublicService);
			return dao.getPublicService(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} 		finally {
			if (sqlSession != null)
			sqlSession.close();
		}
	}
	
	
	@Override
	public PublicServiceRest getPublicServiceRest(String namePublicService) throws Exception {

		SqlSession sqlSession = null;
		try {
			
			PublicServiceRest psr = new PublicServiceRest();
			sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			Map<String, String> map = new HashMap<String, String>();
			map.put("name", namePublicService);
			PublicService ps = dao.getPublicService(map);
			
			psr.setName(ps.getName());
			psr.setOwner(ps.getOwner());
			psr.setIdService(ps.getIdService());
			psr.setCreated(ps.getCreated());
			psr.setPublished(ps.getPublished());
			psr.setPublishedDate(ps.getPublishedDate());
			psr.setServiceDescription(ps.getServiceDescription());
			psr.setUserId(ps.getUserId());
			
			List<LocalService> list_service = getLocalServiceDetail(ps.getName());
			psr.setLocalservice(list_service);
			
			return psr;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} 		finally {
			if (sqlSession != null)
			sqlSession.close();
		}
	}	
	
	
	

	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#insertPublicService(it.eng.msee.asset.bean.PublicService)
	 */
	@Override
	public int insertPublicService(PublicService ps) {
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		int retval = 0;
		if (ps != null) {
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			try {
				retval = dao.insertPublicService(ps);
				if (retval != 1)
					throw new RuntimeException("Could not insert Public Service");
				sqlSession.commit();
			} catch (Exception e) {
				sqlSession.rollback();
				e.printStackTrace();
				throw new RuntimeException("Could not insert Public Service");
			} 		finally {
				if (sqlSession != null)
					sqlSession.close();
				}
		}
		return retval;
	}

	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#updatePublicService(it.eng.msee.asset.bean.PublicService)
	 */
	@Override
	public int updatePublicService(PublicService ps) throws Exception {
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		int retval = 0;
		if (ps != null) {
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			try {
				retval = dao.updatePublicService(ps);
				if (retval != 1)
					throw new RuntimeException("Could not update PublicService");
				sqlSession.commit();
			} catch (Exception e) {
				sqlSession.rollback();
				e.printStackTrace();
				throw new Exception("Could not update PublicService");
			} 		finally {
				if (sqlSession != null)
					sqlSession.close();
				}
		}
		return retval;
	}


	@Override
	public int publishPublicService(String nameService) throws Exception {
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		int retval = 0;
		if (!nameService.equals("")) {
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			try {
				Map<String, String> map = new HashMap<String, String>();
				map.put("Name", nameService);
				retval = dao.publishPublicService(map);
//				if (retval != 1)
//					throw new RuntimeException("Could not update PublicService");
				sqlSession.commit();
			} catch (Exception e) {
				sqlSession.rollback();
				e.printStackTrace();
				throw new Exception("Could not update PublicService");
			} 		finally {
				if (sqlSession != null)
					sqlSession.close();
				}
		}
		return retval;
	}


	@Override
	public int publishLocalService(String nameService) throws Exception {
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		int retval = 0;
		if (!nameService.equals("")) {
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			try {
				Map<String, String> map = new HashMap<String, String>();
				map.put("Name", nameService);
				retval = dao.publishLocalService(map);
//				if (retval != 1)
//					throw new RuntimeException("Could not update PublicService");
				sqlSession.commit();
			} catch (Exception e) {
				sqlSession.rollback();
				e.printStackTrace();
				throw new Exception("Could not update LocalService");
			} 		finally {
				if (sqlSession != null)
					sqlSession.close();
				}
		}
		return retval;
	}


	
	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#deletePublicService(java.lang.Integer)
	 */
	@Override
	public int deletePublicService(String NameService) throws Exception {
		if (NameService == null)
			throw new RuntimeException("name Service ");
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		int retval = 0;
		Map<String, String> map = new HashMap<String, String>();
		map.put("Name", NameService);
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		try {
			retval = dao.deletePublicService(map);
			//if (retval != 1)
				//throw new RuntimeException("Could not delete Public Service");
			sqlSession.commit();
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw new Exception("Could not delete Public Service");
		} 		finally {
			if (sqlSession != null)
			sqlSession.close();
		}

		return retval;
	}
	
	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getLocalServiceList()
	 */
	@Override
	public List<LocalService> getLocalServiceList() throws Exception {
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		try {
			return dao.getLocalServiceList();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		finally {
			if (sqlSession != null)
			sqlSession.close();
		}
	}

	
	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getLocalService(java.lang.String)
	 */
	@Override
	public LocalService getLocalService(String nameLocalService) throws Exception {

		SqlSession sqlSession = null;
		try {
			sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			Map<String, String> map = new HashMap<String, String>();
			map.put("Name", nameLocalService);
			return dao.getLocalService(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} 		finally {
			if (sqlSession != null)
			sqlSession.close();
		}
	}
	

	@Override
	public LocalServiceRest getLocalServiceRest(String nameLocalService) throws Exception {

		SqlSession sqlSession = null;
		try {
			LocalServiceRest lsr = new LocalServiceRest(); 
			sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			Map<String, String> map = new HashMap<String, String>();
			map.put("Name", nameLocalService);
			LocalService ls =  dao.getLocalService(map);
			
			lsr.setCreated(ls.getCreated());
			lsr.setIdLocalService(ls.getIdLocalService());
			lsr.setName(ls.getName());
			lsr.setNameAsset(ls.getNameAsset());
			lsr.setOwner(ls.getOwner());
			lsr.setPublished(ls.getPublished());
			lsr.setPublishedDate(ls.getPublishedDate());
			lsr.setServiceDescription(ls.getServiceDescription());
			lsr.setUserId(ls.getUserId());
			
			List<Asset> las = new ArrayList<Asset>();
			Asset as = getAssetFromName(lsr.getNameAsset());
			las.add(as);
			lsr.setAssets(las); 
			
			return lsr;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} 		finally {
			if (sqlSession != null)
			sqlSession.close();
		}
	}
	
	
	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#insertLocalService(it.eng.msee.asset.bean.LocalService)
	 */
	@Override
	public int insertLocalService(LocalService ls) {
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		int retval = 0;
		if (ls != null) {
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			try {
				retval = dao.insertLocalService(ls);
				if (retval != 1)
					throw new RuntimeException("Could not insert Local Service");
				sqlSession.commit();
			} catch (Exception e) {
				sqlSession.rollback();
				e.printStackTrace();
				throw new RuntimeException("Could not insert Local Service");
			}		finally {
				if (sqlSession != null)
					sqlSession.close();
				}
		}
		return retval;
	}

	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#updatePublicService(it.eng.msee.asset.bean.LocalService)
	 */
	@Override
	public int updateLocalService(LocalService lService) throws Exception {
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		int retval = 0;
		if (lService != null) {
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			try {
				retval = dao.updateLocalService(lService);
				if (retval != 1)
					throw new RuntimeException("Could not update LocalService");
				sqlSession.commit();
			} catch (Exception e) {
				sqlSession.rollback();
				e.printStackTrace();
				throw new Exception("Could not update LocalService");
			}		finally {
				if (sqlSession != null)
					sqlSession.close();
				}
		}
		return retval;
	}


	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#deleteLocalService(java.lang.Integer)
	 */
	@Override
	public int deleteLocalService(String name) throws Exception {
		if (name == null)
			throw new RuntimeException("invalid name Service ");
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		int retval = 0;
		Map<String, String> map = new HashMap<String, String>();
		map.put("Name", name);
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		try {
			retval = dao.deleteLocalService(map);
			if (retval != 1)
				throw new RuntimeException("Could not delete Local Service");
			sqlSession.commit();
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw new Exception("Could not delete Local Service");
		} 		finally {
			if (sqlSession != null)
			sqlSession.close();
		}

		return retval;
	}
	
	
	@Override
	public int updateassetLocalService(String name) throws Exception {
		if (name == null)
			throw new RuntimeException("invalid name Service ");
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		int retval = 0;
		Map<String, String> map = new HashMap<String, String>();
		map.put("Name", name);
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		try {
			retval = dao.updateassetLocalService(map);
//			if (retval != 1)
//				throw new RuntimeException("Could not delete Local Service");
			sqlSession.commit();
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw new Exception("Could not delete Local Service");
		} 		finally {
			if (sqlSession != null)
			sqlSession.close();
		}

		return retval;
	}
	@Override
	public int updateLocalService4Asset(String name, String name_service) {
		if (name == null)
			throw new RuntimeException("invalid name Service ");
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		int retval = 0;
		Map<String, String> map = new HashMap<String, String>();
		map.put("NameAsset", name);
		map.put("Name", name_service);
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		try {
			retval = dao.updateLocalService4Asset(map);
			if (retval != 1)
				throw new RuntimeException("Could not delete Local Service");
			sqlSession.commit();
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}		finally {
			if (sqlSession != null)
			sqlSession.close();
		}

		return retval;
	}
	
	@Override
	public int insertServiceAssetsXlocal(String summary_service, String name_service) throws Exception {
	if (summary_service == null)
			throw new RuntimeException("invalid list Service ");
	
		int retval = 0;
		
		PublicService ps = getPublicService(name_service);
		int idService = ps.getIdService();
		String strIdService = ps.getIdService().toString();
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();

		LocalService ls = getLocalService(summary_service);
		ServiceAssets sa = new ServiceAssets();
		sa.setIdService(idService);
		sa.setIdLocalService(ls.getIdLocalService());			

			try {
				AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
				Map<String, String> map = new HashMap<String, String>();
				
				String idLocalService = ls.getIdLocalService().toString();
				map.put("IdService", strIdService);
				map.put("IdLocalService", idLocalService);

				List<ServiceAssets> lst_serv_ass = dao.getServiceAssetsByIdLocalIdPublic(map);
				int i = 0;
				for (ServiceAssets serviceAssets : lst_serv_ass) {
					
					i++;
				}
				if (i==0) {
					retval = dao.insertServiceAssets(sa);
					if (retval != 1)
						throw new RuntimeException("Could not insert Local Service");
					sqlSession.commit();
					
				}
				
				} catch (Exception e) {
					sqlSession.rollback();
					e.printStackTrace();
				}		finally {
					if (sqlSession != null)
						sqlSession.close();
					}
			
		
		return retval;
	}

	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getServiceAssetsList()
	 */
	@Override
	public List<ServiceAssets> getServiceAssetsList() throws Exception {
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		try {
			return dao.getServiceAssetsList();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		finally {
			if (sqlSession != null)
			sqlSession.close();
		}
	}
	
	@Override
	public int deleteAssociationLocal2Public(String nameService, String name_local_service) throws Exception {

		int retval = 1;		
		
		if (name_local_service == null || nameService == null)
			throw new RuntimeException("Input is invalid Service ");
	
		
		PublicService ps = getPublicService(nameService);
		String idService = ps.getIdService().toString();
		Map<String, String> map = new HashMap<String, String>();
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();

		try {	
		
		LocalService ls = getLocalService(name_local_service);
		String idLocalService = ls.getIdLocalService().toString();
		map.put("IdService", idService);
		map.put("IdLocalService", idLocalService);

		
						
				AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
				retval = dao.deleteServiceAssetsByServices(map);
				if (retval != 1)
				{
					throw new RuntimeException("Could not delete Local Service");
				}
					sqlSession.commit();
				} catch (Exception e) {
					sqlSession.rollback();
					e.printStackTrace();
				}		finally {
					if (sqlSession != null)
						sqlSession.close();
					}
			
		
		return retval;


	}


		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getServiceXNameAsset(java.lang.String)
		 */
		@Override
		public List<ServiceAssets> getServiceXNameAsset(String NameAsset) throws Exception {

			SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			Map<String, String> map = new HashMap<String, String>();
			map.put("NameAsset", NameAsset);
			try {
				//return dao.getServiceXNameAsset(map);
				return null;
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}		finally {
				if (sqlSession != null)
					sqlSession.close();
				}
		}
	

	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getServiceAssets(java.lang.Integer)
	 */
	@Override
	public ServiceAssets getServiceAssets(Integer idServiceAsset) throws Exception {

		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		Map<String, String> map = new HashMap<String, String>();
		map.put("idServiceAsset", idServiceAsset.toString());
		try {
			return dao.getServiceAssets(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		finally {
			if (sqlSession != null)
			sqlSession.close();
		}
	}

	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#insertServiceAssets(it.eng.msee.asset.bean.ServiceAssets)
	 */
	@Override
	public int insertServiceAssets(ServiceAssets sa) {
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		int retval = 0;
		if (sa != null) {
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			try {
				retval = dao.insertServiceAssets(sa);
				if (retval != 1)
					throw new RuntimeException("Could not insert Service Assets");
				sqlSession.commit();
			} catch (Exception e) {
				sqlSession.rollback();
				e.printStackTrace();
				throw new RuntimeException("Could not insert Service Assets");
			}		finally {
				if (sqlSession != null)
					sqlSession.close();
				}
		}
		return retval;
	}

	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#updateServiceAssets(it.eng.msee.asset.bean.ServiceAssets)
	 */
	@Override
	public int updateServiceAssets(ServiceAssets sa) throws Exception {
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		int retval = 0;
		if (sa != null) {
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			try {
				retval = dao.updateServiceAssets(sa);
				if (retval != 1)
					throw new RuntimeException("Could not update Service Assets");
				sqlSession.commit();
			} catch (Exception e) {
				sqlSession.rollback();
				e.printStackTrace();
				throw new Exception("Could not update Service Assets");
			}		finally {
				if (sqlSession != null)
					sqlSession.close();
				}
		}
		return retval;
	}


	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#deleteServiceAssets(java.lang.Integer)
	 */
	@Override
	public int deleteServiceAssets(Integer idServiceAsset) throws Exception {
		if (idServiceAsset == null)
			throw new RuntimeException("invalid Service Asset ID");
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		int retval = 0;
		Map<String, String> map = new HashMap<String, String>();
		map.put("idServiceAsset", idServiceAsset.toString());
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		try {
			dao.deleteServiceAssets(map);
			retval = dao.deleteServiceAssets(map);
			if (retval != 1)
				throw new RuntimeException("Could not delete Service Assets");
			sqlSession.commit();
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw new Exception("Could not delete Service Assets");
		}		finally {
			if (sqlSession != null)
			sqlSession.close();
		}

		return retval;
	}

	
	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getServiceAssetsXService(java.lang.Integer)
	 */
	@Override
	public List<ServiceAssets> getServiceAssetsXService(Integer idService) throws Exception {
		if (idService == null)
			throw new RuntimeException("invalid Service  ID");
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		Map<String, String> map = new HashMap<String, String>();
		map.put("idService", idService.toString());
		try {
			return dao.getServiceAssetsXService(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		finally {
			if (sqlSession != null)
			sqlSession.close();
		}
	}
	
	/* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getServiceAssetsXLocalService(java.lang.Integer)
	 */
	@Override
	public List<ServiceAssets> getServiceAssetsXLocalService(Integer idLocalService) throws Exception {
		if (idLocalService == null)
			throw new RuntimeException("invalid Local Service  ID");
			SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			Map<String, String> map = new HashMap<String, String>();
			map.put("idLocalService", idLocalService.toString());
		
		try {
			return dao.getServiceAssetsXLocalService(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		finally {
			if (sqlSession != null)
			sqlSession.close();
		}
	}
	
	 /* (non-Javadoc)
	 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getAllClasses()
	 * 	Get TreeClass to use in the interface
	 * 
	 */
	@Override
	public List<AssetClass> getAllClasses()  {
		
			AssetClass root_interface = new AssetClass();
    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			ClassItem root =   dao.getClassHierarchy();
			root_interface = TrasformerOntology.trasformClass(root, null);
			if (!root.getClassName().startsWith(Constants.ONTOLOGY_SYSTEM)) {
				lAssetClass.add(root_interface);
			}
			getChildren(root);
			return lAssetClass;
			
			
		}

	private void getChildren(ClassItem root)
	{
		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
		AssetClass current = new AssetClass();
		List<ClassItem> list_children =  root.getSubClasses();
		for (ClassItem classItem : list_children) {
			
			current = TrasformerOntology.trasformClass(classItem, root);
			if (!classItem.getClassName().startsWith(Constants.ONTOLOGY_SYSTEM)) {
				lAssetClass.add(current);
			}
			
			getChildren(classItem);
			
		}

	}
	
	public AssetClass getHierarchyClass() {

		AssetClass root_interface = new AssetClass();
		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
		ClassItem root =   dao.getClassHierarchy();
		root_interface = TrasformerOntology.trasformClass(root, null);
//		if (!root.getClassName().startsWith(Constants.ONTOLOGY_SYSTEM)) {
//			lAssetClass.add(root_interface);
//		}
		root_interface.setChildren(getChildrenAssetClass(root));
		return root_interface;
		
	}


	private List<AssetClass> getChildrenAssetClass(ClassItem root)
	{

		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
		List<AssetClass> list_asset_class = new ArrayList<AssetClass>();
		
		AssetClass current = new AssetClass();
		List<ClassItem> list_children =  root.getSubClasses();
		for (ClassItem classItem : list_children) {
			current = TrasformerOntology.trasformClass(classItem, root);
			if (!classItem.getClassName().startsWith(Constants.ONTOLOGY_SYSTEM)) {
				list_asset_class.add(current);
			}
			List<AssetClass> list_asset = getChildrenAssetClass(classItem);
			current.setChildren(list_asset);	
		}
		
		return list_asset_class;
	}

	
	
		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getListModel(java.lang.String, java.lang.String)
		 */
		@Override
		public List<String> getListModel(String class_name)  {

			List<String> lAsset = new ArrayList<String>();
			
    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
    		List<IndividualItem> list_individual = dao.getIndividuals(class_name);
    		for (IndividualItem individualItem : list_individual) {
				String model = getIndividualSinglePropertyValue(individualItem, Constants.IS_INSTANCE_ON);
				if (!model.equals("")){
				lAsset.add(model);
				}
			}
			dao.release();
			 return lAsset;
		}
		
		
		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getAssetSelected(java.lang.String, java.lang.String)
		 */
		@Override
		public List<Asset> getAssetSelected(String className) {
    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			List<Asset> lAsset = new ArrayList<Asset>();
			List<IndividualItem> list_individual = dao.getIndividuals(className);
			for (IndividualItem individualItem : list_individual) {
				String owner = getIndividualSinglePropertyValue(individualItem, Constants.OWNERD_BY);
				String created = getIndividualSinglePropertyValue(individualItem, Constants.CREATED_ON);
				String model = getIndividualSinglePropertyValue(individualItem, Constants.IS_INSTANCE_ON);
				Asset as = null;
				Date d_created = null;
				if (!created.equals(""))
				{
					d_created = convertString2Date(created);
				}
				as = TrasformerOntology.trasformAsset(individualItem, owner, d_created, model);
				lAsset.add(as);
			}
			dao.release();
			 return lAsset;
		}

		@Override
		public List<Asset> getAssetOnlyModel(String classSelected) {
    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			List<Asset> lAsset = new ArrayList<Asset>();
			List<IndividualItem> list_individual = dao.getIndividuals(classSelected);
			for (IndividualItem individualItem : list_individual) {
				
				String model = getIndividualSinglePropertyValue(individualItem, Constants.IS_INSTANCE_ON);
				if (model.equals("")) {
					String owner = getIndividualSinglePropertyValue(individualItem, Constants.OWNERD_BY);
					String created = getIndividualSinglePropertyValue(individualItem, Constants.CREATED_ON);
					Asset as = null;
					Date d_created = null;
					if (!created.equals(""))
					{
						d_created = convertString2Date(created);
					}
					as = TrasformerOntology.trasformAsset(individualItem, owner, d_created, model);
					lAsset.add(as);
				}
			}
			dao.release();
			 return lAsset;
		}


		@Override
		public List<Asset> getAssetSingleModel(String classSelected, String model) {
    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			List<Asset> lAsset = new ArrayList<Asset>();
			List<IndividualItem> list_individual = dao.getIndividuals(classSelected);
			for (IndividualItem individualItem : list_individual) {
				
				String out_model = getIndividualSinglePropertyValue(individualItem, Constants.IS_INSTANCE_ON);
				if (out_model.equals(model)) {
					String owner = getIndividualSinglePropertyValue(individualItem, Constants.OWNERD_BY);
					String created = getIndividualSinglePropertyValue(individualItem, Constants.CREATED_ON);
					Asset as = null;
					Date d_created = null;
					if (!created.equals(""))
					{
						d_created = convertString2Date(created);
					}
					as = TrasformerOntology.trasformAsset(individualItem, owner, d_created, model);
					lAsset.add(as);
				}
			}
			dao.release();
			 return lAsset;
			
		}

		private Date convertString2Date(String input)  {
			 
				try {
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
					Date date = formatter.parse(input.substring(0, 23));
					return date;
				} catch (ParseException e) {
					e.printStackTrace();
					return null;
				}
		 	
			
		}
		
		
		public String getIndividualSinglePropertyValue(IndividualItem individualItem, String property_name) {
    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			String value_return = "";
			List<PropertyValueItem> list_property = new ArrayList<PropertyValueItem>();
			try
			{
			list_property = dao.getIndividualAttributes(individualItem.getIndividualName());
			for (PropertyValueItem property_value_item : list_property) {
				

				if (property_value_item.getPropertyName().replace(Constants.ONTOLOGY_SYSTEM, "").equals(property_name)) {
					value_return =  property_value_item.getPropertyValue().replace(Constants.ONTOLOGY_SYSTEM, "");
				}
			
			}
			}
			catch (RuntimeException e) {
				e.printStackTrace();
			}
			dao.release();
			return value_return;
		}

		@Override
		public List<Asset> getAsset2Select() {
    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			List<Asset> lAsset = new ArrayList<Asset>();
			List<IndividualItem> list_individual = dao.getIndividuals(); //TODO

			for (IndividualItem individualItem : list_individual) {
				String owner = getIndividualSinglePropertyValue(individualItem, Constants.OWNERD_BY);
				String created = getIndividualSinglePropertyValue(individualItem, Constants.CREATED_ON);
				String model = getIndividualSinglePropertyValue(individualItem, Constants.IS_INSTANCE_ON);
				Asset as = null;
				Date d_created = null;
				if (!created.equals(""))
				{
					d_created = convertString2Date(created);
				}
				as = TrasformerOntology.trasformAsset(individualItem, owner, d_created, model);
				lAsset.add(as);
			}
			dao.release();
			return lAsset;

		}

		@Override
		public Asset getAssetFromName(String nameAsset) {
    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			IndividualItem individualItem = dao.getIndividual(nameAsset);
			String owner = getIndividualSinglePropertyValue(individualItem, Constants.OWNERD_BY);
			String created = getIndividualSinglePropertyValue(individualItem, Constants.CREATED_ON);
			String model = getIndividualSinglePropertyValue(individualItem, Constants.IS_INSTANCE_ON);
			Asset as = null;
			Date d_created = null;
			if (!created.equals(""))
			{
				d_created = convertString2Date(created);
			}
			as = TrasformerOntology.trasformAsset(individualItem, owner, d_created, model);
			dao.release();
	    	return as;

		}
		
		@Override
		public AssetRest getAssetFromNameRest(String nameAsset) {
    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			AssetRest asset_rest = new AssetRest();
    		IndividualItem individualItem = dao.getIndividual(nameAsset);
			String owner = getIndividualSinglePropertyValue(individualItem, Constants.OWNERD_BY);
			String created = getIndividualSinglePropertyValue(individualItem, Constants.CREATED_ON);
			String model = getIndividualSinglePropertyValue(individualItem, Constants.IS_INSTANCE_ON);
			Asset as = null;
			Date d_created = null;
			if (!created.equals(""))
			{
				d_created = convertString2Date(created);
			}
			as = TrasformerOntology.trasformAsset(individualItem, owner, d_created, model);
			
			asset_rest.setAssetClass(as.getAssetClass());
			asset_rest.setCreated(as.getCreated());
			asset_rest.setGlobalName(as.getGlobalName());
			asset_rest.setModel(as.getModel());
			asset_rest.setName(as.getName());
			asset_rest.setNamespace(as.getNamespace());
			asset_rest.setOwner(as.getOwner());
			
			List<Property> lProperty = new ArrayList<Property>();
			lProperty = getPropertyRest(asset_rest.getName());
			asset_rest.setProperties(lProperty);
			dao.release();
			
	    	return asset_rest;

		}
		
		
		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getAsset(java.lang.String)
		 */
		@Override
		public Asset getAsset(String name_asset, String name_class) {
    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			String full_name_asset = Util.getGlobalName(Constants.getSesameNamespace(), name_asset);
			String full_name_class = Util.getGlobalName(Constants.getSesameNamespace(), name_class);
			IndividualItem individualItem = new IndividualItem(Constants.getSesameNamespace(), full_name_asset, full_name_class);
			String owner = getIndividualSinglePropertyValue(individualItem, Constants.OWNERD_BY);
			String created = getIndividualSinglePropertyValue(individualItem, Constants.CREATED_ON);
			String model = getIndividualSinglePropertyValue(individualItem, Constants.IS_INSTANCE_ON);
			Asset as = null;
			Date d_created = null;
			if (!created.equals(""))
			{
				d_created = convertString2Date(created);
			}
			as = TrasformerOntology.trasformAsset(individualItem, owner, d_created, model);
			dao.release();
	    	return as;
		}
		
		@Override
		public String getModel(IndividualItem individual) {
			
			return "";
			
		}
		
				/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getProperty(java.lang.String)
		 */
		@Override
		public List<Property> getProperty(String name_asset) {
    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			List<Property> lProp = new ArrayList<Property>(); 
			List<PropertyValueItem> pro_value_item = dao.getIndividualAttributes(name_asset);
			for (PropertyValueItem propertyValueItem : pro_value_item) {
				if (!propertyValueItem.getPropertyName().startsWith(Constants.ONTOLOGY_SYSTEM)) {
					Property property =  TrasformerOntology.trasformProperty(propertyValueItem);
					lProp.add(property);
				}
				
			}
			dao.release();
			return lProp;
		}

		public List<Property> getPropertyRest(String name_asset) {
    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			List<Property> lProp = new ArrayList<Property>(); 
			List<PropertyValueItem> pro_value_item = dao.getIndividualAttributes(name_asset);
			for (PropertyValueItem propertyValueItem : pro_value_item) {
				if (!propertyValueItem.getPropertyName().startsWith(Constants.ONTOLOGY_SYSTEM)) {
					Property property =  TrasformerOntology.trasformPropertyRest(propertyValueItem);
					lProp.add(property);
				}
			}
			dao.release();
			return lProp;
		}
		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getServiceXAsset(java.lang.String)
		 */
		@Override
		public List<GenericService> getServiceXAsset(String nameAsset) throws Exception {
	
			List<GenericService> list_generic = new ArrayList<GenericService>();
			List<GenericService> list_local_generic = new ArrayList<GenericService>();
			
			SqlSession sqlSession = null;
			try {
				sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
				AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
				Map<String, String> map = new HashMap<String, String>();
				map.put("NameAsset", nameAsset);
				
				list_local_generic = dao.getListGenericLocalService(map);
				list_generic = dao.getListGenericPublicService(map);
		
				for (GenericService genericService : list_local_generic) {
					list_generic.add(genericService);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
				}
			finally {
				if (sqlSession != null)
				sqlSession.close();
			}
			return list_generic;
			
		}
		
	
		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getAllService()
		 */
		@Override
		public List<GenericService> getAllService() throws Exception {

			List<GenericService> list_generic = new ArrayList<GenericService>();
			
			List<LocalService> local_list = new ArrayList<LocalService>(); 
			local_list = getLocalServiceList() ;
			for (LocalService local : local_list) {
				GenericService gs = new GenericService();
				gs = TrasformerOntology.trasform(local);
				list_generic.add(gs);
			}
			
			List<PublicService> public_list = new ArrayList<PublicService>();
			public_list = getPublicList();
			for (PublicService public_obj : public_list) {
				GenericService gs = new GenericService();
				gs = TrasformerOntology.trasform(public_obj);
				list_generic.add(gs);
			}
			
			return list_generic;
		}

		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#insertAssetType(java.lang.String, java.lang.String)
		 */
		@Override
		public String insertAssetType(String class_name, String name, String owner) {
			
			String message_error = "OK";
			
			try {
	    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
				dao.createAssetModel(name, class_name, owner);
				dao.release();
			} catch (Exception e)
			{
				message_error = e.getMessage();
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}
			return message_error;
		}

		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#insertAsset(java.lang.String, java.lang.String, java.lang.String)
		 */
		@Override
		public String  insertAsset(String owner, String model, String name) {
			String message_error = "OK";
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			try {
				dao.createAsset(name, model, owner);
				dao.release();
			}  catch (Exception e)
			{
				message_error = e.getMessage();
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}
			return message_error;
		}

		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#updateAsset(java.lang.String, java.lang.String)
		 */
		@Override
		public String updateAsset(String name, String owner) {
			String message_error = "OK";
			try {
	    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
				dao.setAttribute(Constants.OWNERD_BY, name, owner);
				dao.release();
			} catch (Exception e)
			{
				message_error = e.getMessage();
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}
			return message_error;
		}

		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getDataProperty(java.lang.String)
		 */
		@Override
		public List<Property> getDataProperty(String nome_asset) {
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
				List<PropertyDeclarationItem> list_property_declaration =  dao.getDataProperties();
				List<Property> lProp = new ArrayList<Property>();
				List<Property> hasInsert = getProperty(nome_asset);
				for (PropertyDeclarationItem propertyDeclarationItem : list_property_declaration) {
					

					Property property =  TrasformerOntology.trasformPropertyDeclaration(propertyDeclarationItem);
					int i = 0;
					for (Property propertyExt : hasInsert) {
						if (propertyExt.getName().equals(property.getName()))
						{
							i = 1;
						}
					}
					if (i!=1) {
						if (!property.getNamespace().startsWith(Constants.ONTOLOGY_SYSTEM)) {
							lProp.add(property);
						}
					}
				}
				dao.release();
				return lProp;
		}

		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#insertDataProperty(java.lang.String, java.lang.String, java.lang.String)
		 */
		@Override
		public String insertDataProperty(String asset, String name,
				String value, Class<?> class_type) {
			String message_error = "OK";
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			try 
			{
					
				
				dao.setAttribute(name, asset, value, class_type);
				dao.release();
			} catch (Exception e)
			{
				message_error = e.getMessage();
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}
			return message_error;			
		}

		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#getAllAsset()
		 */
		@Override
		public List<Asset> getAllAsset() {
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			List<Asset> lAsset = new ArrayList<Asset>();
			List<IndividualItem> list_individual_item = dao.getIndividuals();
			
			for (IndividualItem individualItem : list_individual_item) {
				
				String owner = getIndividualSinglePropertyValue(individualItem, Constants.OWNERD_BY);
				String created = getIndividualSinglePropertyValue(individualItem, Constants.CREATED_ON);
				String model = getIndividualSinglePropertyValue(individualItem, Constants.IS_INSTANCE_ON);
				Asset as = null;
				Date d_created = null;
				if (!created.equals(""))
				{
					d_created = convertString2Date(created);
				}
				as = TrasformerOntology.trasformAsset(individualItem, owner, d_created, model);
				lAsset.add(as);
			}
			dao.release();
			return lAsset;
		}

		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#insertObjectProperty(java.lang.String, java.lang.String, java.lang.String)
		 */
		@Override
		public String insertObjectProperty(String asset, String name,
				String value) {
			String message_error = "OK";
			try {
				dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
				dao.setRelationship(name, asset, value);
				dao.release();

			} catch (Exception e)
			{
				message_error = e.getMessage();
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}
			return message_error;
		}

		/* (non-Javadoc)
		 * @see it.eng.msee.asset.service.VirtualizedRepositoryManager#deleteAsset(java.lang.String)
		 */
		@Override
		public String deleteAsset(String name_asset) {
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			String message_error = "OK";
			try {
				dao.deleteIndividual(name_asset);
				dao.release();
			}  catch (Exception e)
			{
				message_error = e.getMessage();
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}
			return message_error;
			
			
			
		}
		@Override
		public String updateDataPropertyAsset(String nameAsset , String name_property, String value_prop_modified){
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			String message_error = "OK";
			try {

					dao.setAttribute(name_property, nameAsset, value_prop_modified);
					dao.release();
			}
			catch (Exception e)
			{
				message_error = e.getMessage();
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}
			return message_error;
			
		}

		@Override
		public String createDataPropertyAsset(String nameAsset , String name_property, String value_prop_modified,  Class<?> type){
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			String message_error = "OK";
			try {
					dao.setAttribute(name_property, nameAsset, value_prop_modified, type);
					dao.release();
			}
			catch (Exception e)
			{
				message_error = e.getMessage();
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}
			return message_error;
			
		}
		
		

		@Override
		public String updateObjectPropertyAsset(String nameAsset, String name_property,
				String value_prop_modified) {
			String message_error = "OK";
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			try {
				dao.setAttribute(name_property, nameAsset, value_prop_modified, null);
				dao.release();
			}
			catch (Exception e)
			{
				message_error = e.getMessage();
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}
			return message_error;

			
		}

		@Override
		public String MoveClass(String ClassMove, String ClassParent){
			String message_error = "OK";
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			try {
				dao.moveClass(ClassMove, ClassParent);
				dao.release();
			}
			catch (Exception e)
			{
				message_error = e.getMessage();
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}
			return message_error;

		}

		@Override
		public String insertClass(String class_name,
				String class_name_reference ) {
			String message_error = "OK";
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			try {
				String class_name_reference_local = class_name_reference;
				if (class_name_reference.equals("root")) {
					class_name_reference_local = "http://www.w3.org/2002/07/owl#Thing";
				}
				dao.createClass(class_name, class_name_reference_local);
				dao.release();
				return message_error;
			}
			catch (Exception e)
			{
				message_error = e.getMessage();
				return message_error;
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}

		}

		@Override
		public String PropertyExist(String str_value) {
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			String rit = "";
			List<PropertyDeclarationItem> list_property_declaration =  dao.getDataProperties();

			for (PropertyDeclarationItem propertyDeclarationItem : list_property_declaration) {
				
				if (propertyDeclarationItem.getPropertyName().equals(str_value)) {
					
						rit = propertyDeclarationItem.getPropertyRange();
						break;
				}
			}
			dao.release();
			if (rit == null) {
				rit = "";
			}
			return rit;

		}
		
		@Override
		public String deleteClass(String class_name){
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			String message_error = "OK";
			try {
				dao.deleteClass(class_name);
				dao.release();
			}
			catch (Exception e)
			{
				message_error = e.getMessage();
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}
			return message_error;
			
			
		};

		@Override
		public String deleteProperty(String name_asset, String name_property) {
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			String message_error = "OK";
			try {
					dao.removeProperty(name_property, name_asset);
					dao.release();
			}
			catch (Exception e)
			{
				message_error = e.getMessage();
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}
			return message_error;
		}

		@Override
		public List<Property> getOBjectProperty() {

			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			List<PropertyDeclarationItem> list_property_declaration =  dao.getObjectProperties();
			List<Property> lProp = new ArrayList<Property>();
			
			for (PropertyDeclarationItem propertyDeclarationItem : list_property_declaration) {
				
				Property property =  TrasformerOntology.trasformPropertyDeclaration(propertyDeclarationItem);
				lProp.add(property);
			}
			dao.release();
			return lProp;

		}


		@Override
		public List<String> getOwners() {
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			List<String> list = dao.getOwners();
			
			Collections.sort(list);
			
					dao.release();
					return   list;


		}
		@Override
		public int updateLocalService(String name_local_service, String descriptionService, String owner) {

			if (name_local_service == null)
				throw new RuntimeException("invalid name Service ");
			SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
			int retval = 0;
			Map<String, String> map = new HashMap<String, String>();
			map.put("owner", owner);
			map.put("serviceDescription", descriptionService);
			map.put("Name", name_local_service);
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			try {
				retval = dao.updateLocalServiceDetail(map);
				if (retval != 1)
					throw new RuntimeException("Could not delete Local Service");
				sqlSession.commit();
			} catch (Exception e) {
				sqlSession.rollback();
				e.printStackTrace();
			}		finally {
				if (sqlSession != null)
				sqlSession.close();
			}

			return retval;

			
		}

		@Override
		public int updatePublicService(String name_local_service, String descriptionService, String owner) {

			if (name_local_service == null)
				throw new RuntimeException("invalid name Service ");
			SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession();
			int retval = 0;
			Map<String, String> map = new HashMap<String, String>();
			map.put("owner", owner);
			map.put("serviceDescription", descriptionService);
			map.put("Name", name_local_service);
			AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
			try {
				retval = dao.updatePublicServiceDetail(map);
				if (retval != 1)
					throw new RuntimeException("Could not delete Public Service");
				sqlSession.commit();
			} catch (Exception e) {
				sqlSession.rollback();
				e.printStackTrace();
			}		finally {
				if (sqlSession != null)
				sqlSession.close();
			}

			return retval;

			
		}
		

		@Override
		public List<String> getTabOwners() {
			dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, namespace);
			List<String> list = dao.getOwners();
					dao.release();
					Collections.sort(list);
					return   list;


		}
		
		@Override
		public String deleteOwner(String owners) {
			String message_error = "OK";
			try {
	    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, Constants.ONTOLOGY_SYSTEM);
				dao.deleteOwner(owners);
				dao.release();
			}  catch (Exception e)
			{
				message_error = e.getMessage();
				//throw new IllegalArgumentException ("Error: Insert Class.");
			}
			return message_error;
			

		}
		
		@Override
		public String insertOwner(String owner) {
			
			String message_error = "OK";
			
			try {

	    		dao = new it.eng.msee.ontorepo.sesame2.Sesame2RepositoryDAO(url, sesame_repository, Constants.ONTOLOGY_SYSTEM);
				dao.createOwner(owner);
				dao.release();
			} catch (Exception e)
			{
				message_error = e.getMessage();
				
			}
			return message_error;
		}
		
				

}
