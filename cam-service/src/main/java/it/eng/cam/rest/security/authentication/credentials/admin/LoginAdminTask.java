package it.eng.cam.rest.security.authentication.credentials.admin;

import it.eng.cam.rest.Constants;
import it.eng.cam.rest.security.service.impl.IDMKeystoneService;
import it.eng.cam.rest.security.user.UserLoginJSON;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import javax.json.JsonObject;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.core.Response;
import java.text.SimpleDateFormat;
import java.util.*;

public class LoginAdminTask extends TimerTask {
    private static final Logger logger = LogManager.getLogger(LoginAdminTask.class.getName());
    private static final String FATAL_ADMIN_TOKEN_IS_NOT_SET = "FATAL!!! ADMIN TOKEN IS NOT SET!!!";

    public void run() {
        doRun(Constants.ADMIN_USER, Constants.ADMIN_PASSWORD);
    }

    private static void doRun(String username, String password) {
        try {
            System.setProperty(ClientBuilder.JAXRS_DEFAULT_CLIENT_BUILDER_PROPERTY, "org.glassfish.jersey.client.JerseyClientBuilder");
            UserLoginJSON user = new UserLoginJSON();
            if(StringUtils.isBlank(username) || StringUtils.isBlank(password))
                throw new IllegalArgumentException("Configure user and password of ADMIN into properties file.");
            user.setUsername(username);
            user.setPassword(password);
            IDMKeystoneService idmKeystoneService = new IDMKeystoneService();
            Response response = idmKeystoneService.getADMINToken(user);
            final List<Object> objects = response.getHeaders().get(Constants.X_SUBJECT_TOKEN);
            String adminToken = objects.get(0).toString();
            if (adminToken == null || adminToken.isEmpty())
                throw new IllegalStateException(FATAL_ADMIN_TOKEN_IS_NOT_SET);
            Constants.ADMIN_TOKEN = adminToken;
            Date date = extractExpiresDate(response);
            Timer timer = new Timer();
            timer.schedule(new LoginAdminTask(), subtractSeconds(date, 15));
        } catch (RuntimeException e) {
            logger.error(e.getMessage());
        } catch (Exception e) {
            logger.error(e);
            Timer timer = new Timer();
            timer.schedule(new LoginAdminTask(), addMinutes(new Date(), 2)); //after 10 minutes
        }
    }

    private static Date subtractSeconds(Date data, int seconds) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(data);
        int negSeconds = seconds * -1;
        calendar.add(Calendar.SECOND, negSeconds);
        return calendar.getTime();
    }

    private static Date addMinutes(Date data, int minutes) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(data);
        calendar.add(Calendar.MINUTE, minutes);
        return calendar.getTime();
    }

    private static Date extractExpiresDate(Response response) throws java.text.ParseException {
        final JsonObject dataJson = response.readEntity(JsonObject.class);
        final JsonObject tokenJson = dataJson.getJsonObject("token");
        String expiresAt = tokenJson.getString("expires_at");
        //System.out.println("DATE EXPIRES AT: " + expiresAt); //TODO Remove
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.getDefault());
        return dateFormat.parse(expiresAt);
    }

}