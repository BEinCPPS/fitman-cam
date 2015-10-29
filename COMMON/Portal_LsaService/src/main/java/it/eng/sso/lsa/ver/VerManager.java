package it.eng.sso.lsa.ver;

import it.eng.liferay.cas.integration.AttributeNames;
import it.eng.liferay.cas.integration.LiferayOrganization;
//import it.eng.liferay.cas.integration.AttributeNames;
import it.eng.sso.lsa.ver.beans.EnterpriseMember;
import it.eng.sso.lsa.ver.beans.VirtualEnterprise;
import it.eng.sso.lsa.ver.beans.VirtualEnterprises;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class VerManager {

	private static final Logger logger = LoggerFactory.getLogger(VerManager.class);

	public static String URL;

	public void setURL(String uRL) {
		URL = uRL;
	}

	public VerManager() {
		super();
	}

	public Map<String, Object> obtainVirtualEnterprises(Map<String, Object> attributes) {
		Map<String, VirtualEnterprise> mapVer = null;
		Map<String, Object> attributesAppo = null;
		HttpURLConnection conn = null;

		try {
			URL url = new URL(URL);
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/xml");

			if (conn.getResponseCode() != 200) {
				logger.error("Failed : HTTP error code : " + conn.getResponseCode());
				return attributes;
			}

			BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
			String output;
			String out = "";
			logger.info("Output from Server .... \n");
			while ((output = br.readLine()) != null) {
				logger.info(output);
				out += output;
			}
			mapVer = extractVER(out);
			attributesAppo = new HashMap<String, Object>();
			attributesAppo.putAll(attributes);
			List<LiferayOrganization> orgs = (List<LiferayOrganization>) attributesAppo
					.get(AttributeNames.ORGANIZATION);
			if (mapVer == null || orgs == null)
				return attributes;
			List<VirtualEnterprise> vers = new ArrayList<VirtualEnterprise>();
			if (mapVer.values() == null)
				return attributes;

			for (VirtualEnterprise ver : mapVer.values()) {
				if (ver.getMembers() == null)
					return attributes;
				for (EnterpriseMember memb : ver.getMembers()) { // FIXME by
																	// Name
					for (LiferayOrganization org : orgs) {
						if ((org.getName() == null || memb.getMemberName() == null))
							return attributes;
						if (memb.getMemberName().trim().equalsIgnoreCase(org.getName().toString().trim())) {
							vers.add(ver);
						}
					}
				}
			}

			if (vers.size() > 0)
				attributesAppo.put(AttributeNames.VIRTUAL_ENTERPRISE, vers);
			//conn.disconnect();
		} catch (MalformedURLException e) {

			logger.error(e.getLocalizedMessage());

		} catch (IOException e) {

			logger.error(e.getLocalizedMessage());

		} finally {
			if (conn != null)
				conn.disconnect();
		}
		return attributesAppo;
	}

	private Map<String, VirtualEnterprise> extractVER(String in) {
		JAXBContext context = null;
		Map<String, VirtualEnterprise> map = null;
		if (in == null)
			return null;
		in = in.replaceAll("&", "&amp;");
		try {
			context = JAXBContext.newInstance(VirtualEnterprises.class);
			Unmarshaller um = context.createUnmarshaller();
			VirtualEnterprises verCont = (VirtualEnterprises) um.unmarshal(new StringReader(in));
			if (verCont == null || verCont.getVirtualEnteprises() == null || verCont.getVirtualEnteprises().size() == 0)
				return null;
			map = new HashMap<String, VirtualEnterprise>();
			for (VirtualEnterprise ver : verCont.getVirtualEnteprises()) {
				map.put(ver.getName(), ver);
			}

		} catch (JAXBException e) {

			logger.error(e.getLocalizedMessage());
		}
		return map;
	}

	// //TEST ONLY
	// public static void main(String[] args) {
	// URL =
	// "http://localhost:8180/MSEE_VirtualEnterpriseRegistry_rest/rest/v1/ves";
	// obtainVirtualEnterprises(null);
	// }

} // end class
