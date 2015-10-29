package it.eng.asset.test;

import static org.junit.Assert.assertNotNull;
import it.eng.asset.bean.Asset;
import it.eng.asset.bean.AssetExtended;
import it.eng.asset.service.AssetService;
import it.eng.asset.service.IAssetService;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

public class AssetServiceTest {
	IAssetService service = AssetService.getAssetService();
//	private static Logger log = Logger.getLogger(AssetServiceTest.class
//			.getName());
//	private static SqlSessionFactory sf;

//	@BeforeClass
//	public static void setUp() throws Exception {
//		log.info("starting up myBatis tests");
//		String resource = "mybatis-config.xml";
//		Reader reader = Resources.getResourceAsReader(resource);
//		sf = new SqlSessionFactoryBuilder().build(reader, "testing"); 
//	}

	@Test
	public void retrieveAllAssets() throws Exception {
		List<AssetExtended> assets = service.retrieveAllAssets();
		assertNotNull(assets);
		
		List<AssetExtended> assets2 = service.retrieveAllAssetServices(1L, "test");
		List<Asset> assets3 = service.retrieveAssetsByServiceId(1L);
		System.out.println("finish");
	}

	@Test 
	public void addServiceAssets() {
		List<String> assets = new ArrayList<String>();
//		assets.add("test");
		assets.add("blu");
		try {
//			service.addServiceAssets(4, assets);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("OK");
	}
	
	@Test 
	public void deleteServiceAsset() {
		AssetExtended ae = new AssetExtended();
		ae.setAssetId(5);
		ae.setAssetName("blu");
		try {
			service.deleteServiceAsset(4, ae);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("OK");
	}
//	@AfterClass
//	public static void tearDown() throws Exception {
//		log.info("closing down myBatis tests");
//	}
}
