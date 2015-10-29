package msee.sp3.cm.repository.client;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.FileEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.fiware.apps.repository.model.Resource;
import org.fiware.apps.repository.model.ResourceCollection;
import org.jboss.resteasy.client.ClientRequest;
import org.jboss.resteasy.client.ClientResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.activation.MimetypesFileTypeMap;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import java.io.*;
import java.nio.charset.Charset;

public class ResourceClient {

    public static final Charset UTF_8 = Charset.forName("UTF-8");

    private Logger logger = LoggerFactory.getLogger(ResourceClient.class);

	private String repositoryURL;

	public ResourceClient(String repositoryURL) {		
		this.repositoryURL = repositoryURL;
	}


	public boolean put(String path, Resource res){
		ClientRequest request = new ClientRequest(repositoryURL+path);
		request.accept("application/xml");

		JAXBContext ctx;
		try {
			ctx = JAXBContext.newInstance(ResourceCollection.class);

			StringWriter writer = new StringWriter();
			ctx.createMarshaller().marshal(res, writer);			

			String input = writer.toString();
			request.body("application/xml", input);
			ClientResponse<String> response;
			response = request.put(String.class);
			ClientUtil.visualize(request, response, "Create Resource");
			if(response.getStatus() == 200){
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

	public Boolean insertResourceContent(String resourceId, String filename){
		try {
			HttpClient httpclient = new DefaultHttpClient();
			HttpPost httppost = new HttpPost(repositoryURL+resourceId);

			MultipartEntity reqEntity = new MultipartEntity();

			File f = new File(filename);		
			FileBody bin = new FileBody(f);

			StringBody mimeType = new StringBody(new MimetypesFileTypeMap().getContentType(f));
			StringBody comment = new StringBody(f.getName());			

			reqEntity.addPart("filename", comment);
			reqEntity.addPart("mimeType", mimeType);
			reqEntity.addPart("filedata", bin);		


			httppost.setEntity(reqEntity);
			HttpResponse response;

			response = httpclient.execute(httppost);
			HttpEntity resEntity = response.getEntity();



			return true;
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

    public Boolean insertResourceString(String resourceId, String body, String mimeType){
        try {
            HttpClient httpclient = new DefaultHttpClient();
            HttpPut httppost = new HttpPut(repositoryURL+resourceId);

            StringEntity entity = new StringEntity(body, "UTF-8");
            httppost.setEntity(entity);
            httppost.setHeader("Content-Type", mimeType);

            HttpResponse response;

            response = httpclient.execute(httppost);
            HttpEntity resEntity = response.getEntity();
            logger.debug("Response for RDF content upload is " + response.getStatusLine());
            return true;
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();

        } catch (ClientProtocolException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }


	public Boolean insertResourceContentRDF(String resourceId, String filename, String rdfType){
		try {
			HttpClient httpclient = new DefaultHttpClient();
			HttpPut httppost = new HttpPut(repositoryURL+resourceId);	
			
			File file = new File(filename);
			FileEntity entity = new FileEntity(file, "text/plain; charset=\"UTF-8\"");			
			httppost.setEntity(entity);		
			httppost.setHeader("Content-Type", rdfType);
			
			HttpResponse response;

			response = httpclient.execute(httppost);
			HttpEntity resEntity = response.getEntity();
            logger.debug("Response for RDF content upload is " + response.getStatusLine());
			return true;
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public Resource getResource(String resourceId){
		Resource r= null;
		String xml = "";
		try {
			ClientRequest request = new ClientRequest(repositoryURL+resourceId);
			request.accept("application/xml");
			ClientResponse<String> response = request.get(String.class);
			ClientUtil.visualize(request, response, "Get Resource");
			BufferedReader br = new BufferedReader(new InputStreamReader(new ByteArrayInputStream(response.getEntity().getBytes())));

			String output;			
			while ((output = br.readLine()) != null) {				
				xml += output;
			}

			JAXBContext ctx;			
			ctx = JAXBContext.newInstance(Resource.class);

			r = (Resource) ctx.createUnmarshaller().unmarshal(new StringReader(xml));	

		} catch (Exception e) {
			return null;
		}
		return r;	

	}


	public Boolean updateResource(String id,  Resource r){
		try {

			ClientRequest request = new ClientRequest(repositoryURL+id);
			request.accept("application/xml");

			JAXBContext ctx = JAXBContext.newInstance(Resource.class);
			StringWriter writer = new StringWriter();
			ctx.createMarshaller().marshal(r, writer);
			String input = writer.toString();		
			request.body("application/xml", input);
			ClientResponse<String> response = request.post(String.class);
			ClientUtil.visualize(request, response, "Update Resource Meta Data");
			if(response.getStatus() == 200){
				return true;
			}			

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}


	public Boolean deleteResource(String id){
		try {
			ClientRequest request = new ClientRequest(repositoryURL+id);
			request.accept("application/xml");
			ClientResponse<String> response = request.delete(String.class);		
			ClientUtil.visualize(request, response, "Delete Resource");

			if(response.getStatus() == 204){
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}




}
