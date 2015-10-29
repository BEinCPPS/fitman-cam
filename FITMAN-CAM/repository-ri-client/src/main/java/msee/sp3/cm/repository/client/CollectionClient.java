package msee.sp3.cm.repository.client;

import org.fiware.apps.repository.model.ResourceCollection;
import org.jboss.resteasy.client.ClientRequest;
import org.jboss.resteasy.client.ClientResponse;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import java.io.*;

public class CollectionClient {

	private String repositoryURL;

	public CollectionClient(String repositoryURL) {		
		this.repositoryURL = repositoryURL;
	}

	public boolean put(String path, ResourceCollection col){
		ClientRequest request = new ClientRequest(repositoryURL+path);
		request.accept("application/xml");

		JAXBContext ctx;
		try {
			ctx = JAXBContext.newInstance(ResourceCollection.class);

			StringWriter writer = new StringWriter();
			ctx.createMarshaller().marshal(col, writer);			

			String input = writer.toString();
			request.body("application/xml", input);
			ClientResponse<String> response;
			response = request.put(String.class);
			ClientUtil.visualize(request, response, "Insert Collection");


			BufferedReader br = new BufferedReader(new InputStreamReader(new ByteArrayInputStream(response.getEntity().getBytes())));
			String xml = "";
			String output;			
			while ((output = br.readLine()) != null) {				
				xml += output;
			}
			System.out.println(xml);

			if(response.getStatus() == 201){
				return true;
			}	
		}
		catch (JAXBException e) {
			e.printStackTrace();
			return false;
		}
		catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return false;

	}

	public Boolean updateCollection(String id, ResourceCollection collection){
		try {

			
			ClientRequest request = new ClientRequest(repositoryURL+id);
			request.accept("application/xml");

			JAXBContext ctx = JAXBContext.newInstance(ResourceCollection.class);
			StringWriter writer = new StringWriter();
			ctx.createMarshaller().marshal(collection, writer);
			String input = writer.toString();		
			request.body("application/xml", input);
			ClientResponse<String> response = request.post(String.class);
			ClientUtil.visualize(request, response, "Update Collection");
			if(response.getStatus() == 200){
				return true;
			}			
			
			

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	

	
	public ResourceCollection find(String id){
	
		ResourceCollection r= null;
		String xml = "";
	
		try {

			ClientRequest request = new ClientRequest(repositoryURL+id);
			request.accept("application/xml");
			ClientResponse<String> response = request.get(String.class);

			BufferedReader br = new BufferedReader(new InputStreamReader(new ByteArrayInputStream(response.getEntity().getBytes())));

			String output;			
			while ((output = br.readLine()) != null) {				
				xml += output;
			}
			
			JAXBContext ctx;			
			ctx = JAXBContext.newInstance(ResourceCollection.class);

			r = (ResourceCollection) ctx.createUnmarshaller().unmarshal(new StringReader(xml));	
			ClientUtil.visualize(request, response, "Get Collection");
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}


		return r;	


	}

	public Boolean delete(String id){
		try {
			ClientRequest request = new ClientRequest(repositoryURL+id);
			request.accept("application/xml");
			ClientResponse<String> response = request.delete(String.class);		

			if(response.getStatus() == 204){
				return true;
			}
			ClientUtil.visualize(request, response, "Delete Collection");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}







}
