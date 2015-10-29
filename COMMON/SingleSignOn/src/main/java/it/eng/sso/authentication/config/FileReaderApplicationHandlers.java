package it.eng.sso.authentication.config;



import java.io.BufferedReader;
import java.io.FileReader;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.jasig.cas.authentication.handler.AuthenticationHandler;
import org.jasig.cas.authentication.handler.support.HttpBasedServiceCredentialsAuthenticationHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
public class FileReaderApplicationHandlers {

	public final static String TOKEN_CHAR = ",";
	public final static String AUTHORITY_CHAR = "@";

	
	private final Logger log = LoggerFactory
			.getLogger(FileReaderApplicationHandlers.class);

	public static HashMap<String, AuthenticationHandler> readFile() {
		HashMap<String, AuthenticationHandler> authenticationHandlers = new HashMap<String, AuthenticationHandler>();
		FileReader fileReader = null;
		BufferedReader bufferedReader = null;
		String content = "";
		try {
			fileReader = new FileReader(
					"file:/WEB-INF/applicationHandlersFileConfig.cfg");
			bufferedReader = new BufferedReader(fileReader);
			while (bufferedReader.readLine() != null) {
				content = bufferedReader.readLine();
				String[] str = content.split(TOKEN_CHAR);
				Class<?> t = Class.forName(str[2]);
				AuthenticationHandler handler = (AuthenticationHandler) t
						.newInstance();
				if (handler instanceof LSAServiceCredentialsAuthenticationHandler) {
					authenticationHandlers
							.put(str[0],
									new LSACredentialsAuthenticationHandler(
											(LSAServiceCredentialsAuthenticationHandler) handler,
											str[1]));
				} else if (handler instanceof HttpBasedServiceCredentialsAuthenticationHandler) {
					authenticationHandlers
							.put(str[0],
									new HttpBasedServiceCredentialsAuthenticationHandler(
											(HttpBasedServiceCredentialsAuthenticationHandler) handler));

				}
				// else if TODO {}
			}
			bufferedReader.close();
		} catch (Exception ignored) {

		}
		return authenticationHandlers;
	}

}*/
