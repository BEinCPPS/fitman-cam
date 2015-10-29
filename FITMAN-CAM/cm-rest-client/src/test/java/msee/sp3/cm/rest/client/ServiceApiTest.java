package msee.sp3.cm.rest.client;

import java.util.Date;

import msee.sp3.cm.api.resources.ServiceResourceExtended;

import org.apache.commons.lang.RandomStringUtils;
import org.testng.Assert;
import org.testng.annotations.Test;

@Test(groups = "service-test")
public class ServiceApiTest {

	public void createService() {
		System.out.println("Start create instance test");
		boolean retval = CmServiceApiClient.getInstance().createService(getTestService());
		Assert.assertTrue(retval);
		System.out.println("Test successfull");
	}

	private ServiceResourceExtended getTestService() {
		ServiceResourceExtended service = new ServiceResourceExtended();
		String name = RandomStringUtils.randomAlphabetic(7);
		service.setServiceName(name);
		service.setServiceUrl(name);
		service.setLocalUserCreatorId(1L);
		service.setLocalUserLastEditorId(1L);
		service.setServiceRegDate(new Date());
		service.setServiceDesc("Desc");
		service.setStoreId(1L);
		return service;
	}

}
