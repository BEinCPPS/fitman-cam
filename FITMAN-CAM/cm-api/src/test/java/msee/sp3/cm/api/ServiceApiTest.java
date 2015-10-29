package msee.sp3.cm.api;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Date;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import msee.sp3.cm.api.resources.ServiceResourceExtended;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.cxf.jaxrs.client.WebClient;
import org.testng.Assert;
import org.testng.annotations.Test;

@Test(groups = "service-test")
public class ServiceApiTest {
	public static final String BASE_URL = "http://localhost:8081/cm-api/api/v1";

	public void createService() {
		ServiceResourceExtended service = getTestService();
		Response wc = WebClient.create(BASE_URL).path("serviceapi/service")
				.type("application/xml").post(service);
		Assert.assertEquals(wc.getStatus(), Status.CREATED.getStatusCode());
	}

	public void marshallUser() {
		JAXBContext jaxbContext;
		try {
			jaxbContext = JAXBContext
					.newInstance(ServiceResourceExtended.class);

			Marshaller marshaller = jaxbContext.createMarshaller();
			marshaller.setProperty(Marshaller.JAXB_FRAGMENT, true);
			OutputStreamWriter writer = new OutputStreamWriter(System.out);
			// Marshal the objects out individually
			marshaller.marshal(getTestService(), writer);
			// Manually close the root element
			writer.close();
		} catch (JAXBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
