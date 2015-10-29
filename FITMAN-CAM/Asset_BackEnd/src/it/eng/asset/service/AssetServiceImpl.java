/**
 * @author afantini
 *
 */
package it.eng.asset.service;

import it.eng.asset.bean.Asset;
import it.eng.asset.bean.AssetExtended;
import it.eng.asset.dao.AssetDAO;
import it.eng.asset.utils.MybatisUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

/**
 * @author kobra
 *
 */
public class AssetServiceImpl implements IAssetService {

	private static final String ERROR_AT_LEAST_ONE_PARAMETER = "Provide at least one parameter";
	private static final String ERRORE_ASSET_SERVICES = "Could not retrieve Asset services";
	private static final String ERROR_ASSETS = "Could not retrieve assets";
	private static final String ERROR_ADD_ASSETS = "Could not add assets";
	private static final String ERROR_REMOVE_ASSETS = "Could not remove asset";

	protected AssetServiceImpl() {
		super();
	}

	@Override
	public List<AssetExtended> retrieveAllAssets() throws Exception {
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory()
				.openSession();
		List<AssetExtended> retval = null;
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		try {
			retval = dao.retrieveAllAssets();
			return retval;
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw new Exception("Could not retrieve Assets");
		} finally {
			if (sqlSession != null)
				sqlSession.close();
		}
	}

	@Override
	public List<AssetExtended> retrieveAllAssetServices(Long assetId,
			String assetName) throws Exception {
		if (null == assetId && null == assetName) {
			throw new Exception(ERROR_AT_LEAST_ONE_PARAMETER);
		}
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory()
				.openSession();
		List<AssetExtended> retval = null;
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		try {
			AssetExtended ae = new AssetExtended();
			ae.setAssetId(assetId);
			ae.setAssetName(assetName);
			retval = dao.retrieveAllAssetServices(ae);
			return retval;
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw new Exception(ERRORE_ASSET_SERVICES);
		} finally {
			if (sqlSession != null)
				sqlSession.close();
		}
	}

	@Override
	public List<Asset> retrieveAssetsByServiceId(long serviceId)
			throws Exception {
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory()
				.openSession();
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		try {

			List<AssetExtended> assets = dao
					.retrieveAssetsByServiceId(serviceId);
			List<Asset> retval = new ArrayList<Asset>();
			if (assets == null) {
				return null;
			}
			VirtualizedRepositoryManager service = new ManagerRepositoryAssetService();
			for (AssetExtended asset : assets) {
				retval.add(service.getAssetFromName(asset.getAssetName()));
			}

			return retval;
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw new Exception(ERROR_ASSETS);
		} finally {
			if (sqlSession != null)
				sqlSession.close();
		}
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public boolean addServiceAssets(long serviceId, List<String> assets)
			throws Exception {
		if (serviceId == 0 || assets.size() == 0)
			throw new Exception(ERROR_ADD_ASSETS);
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory()
				.openSession();
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		try {
			int addedValues = 0;
			for (String asset : assets) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("serviceId", serviceId);
				map.put("assetId", retrieveAssetId(dao, asset));
				map.put("assetName", asset);
				addedValues += dao.addServiceAssets(map);
			}
			sqlSession.commit();
			return addedValues == assets.size();
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw new Exception(ERROR_ADD_ASSETS);
		} finally {
			if (sqlSession != null)
				sqlSession.close();
		}

	}

	private long retrieveAssetId(AssetDAO dao, String asset) {
		long assetId = 0;
		AssetExtended ae = new AssetExtended();
		ae.setAssetName(asset);
		List<AssetExtended> aeList = dao.retrieveAllAssetServices(ae);
		if (aeList == null || aeList.size() == 0) {
			assetId = dao.retrieveNewAssetId();
		} else {
			assetId = aeList.get(0).getAssetId();
		}

		return assetId;
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public boolean deleteServiceAsset(long serviceId,
			AssetExtended assetExtended) throws Exception {
		if (serviceId == 0
				|| assetExtended == null
				|| (assetExtended.getAssetId() == 0 && assetExtended
						.getAssetName() == null))
			throw new Exception(ERROR_REMOVE_ASSETS);
		SqlSession sqlSession = MybatisUtil.getSqlSessionFactory()
				.openSession();
		AssetDAO dao = sqlSession.getMapper(AssetDAO.class);
		try {
			int removedItems = 0;
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("serviceId", serviceId);
			if (assetExtended.getAssetId() != 0)
				map.put("assetId", assetExtended.getAssetId());
			else {
				List<AssetExtended> ae = dao.retrieveAllAssetServices(assetExtended);
				map.put("assetId", ae.get(0).getAssetId());
			}
			removedItems += dao.removeServiceAsset(map);
			sqlSession.commit();
			return removedItems == 1;
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw new Exception(ERROR_REMOVE_ASSETS);
		} finally {
			if (sqlSession != null)
				sqlSession.close();
		}
	}
}