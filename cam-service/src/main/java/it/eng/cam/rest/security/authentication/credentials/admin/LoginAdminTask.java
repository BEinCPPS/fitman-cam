package it.eng.cam.rest.security.authentication.credentials.admin;

import it.eng.cam.rest.security.service.Constants;
import it.eng.cam.rest.security.service.impl.IDMKeystoneService;
import it.eng.cam.rest.security.user.UserLoginJSON;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import javax.json.JsonObject;
import javax.ws.rs.core.Response;
import java.text.SimpleDateFormat;
import java.util.*;

public class LoginAdminTask extends TimerTask {
    private static final Logger logger = LogManager.getLogger(LoginAdminTask.class.getName());
    private static final String FATAL_ADMIN_TOKEN_IS_NOT_SET = "FATAL!!! ADMIN TOKEN IS NOT SET!!!";

    public void run() {
        try {
            UserLoginJSON user = new UserLoginJSON();
            user.setUsername(Constants.ADMIN_USER);
            user.setPassword(Constants.ADMIN_PASSWORD);
            IDMKeystoneService idmKeystoneService = new IDMKeystoneService();
            Response response = idmKeystoneService.getADMINToken(user);
            final List<Object> objects = response.getHeaders().get(Constants.X_SUBJECT_TOKEN);
            String adminToken = objects.get(0).toString();
            if (adminToken == null || adminToken.isEmpty())
                throw new IllegalStateException(FATAL_ADMIN_TOKEN_IS_NOT_SET);
            Constants.ADMIN_TOKEN = adminToken;
            Date date = extractExpiresDate(response);
            Timer timer = new Timer();
            timer.schedule(new LoginAdminTask(), subtract1Minute(date));
        } catch (IllegalStateException e) {
            logger.error(FATAL_ADMIN_TOKEN_IS_NOT_SET);
        } catch (Exception e) {
            logger.error(e);
            Timer timer = new Timer();
            timer.schedule(new LoginAdminTask(), addTenMinutes(new Date())); //after 10 minutes
        }
    }

    private Date subtract1Minute(Date data) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(data);
        calendar.add(Calendar.MINUTE, -1);
        return calendar.getTime();
    }

    private Date addTenMinutes(Date data) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(data);
        calendar.add(Calendar.MINUTE, 10);
        return calendar.getTime();
    }

    private Date extractExpiresDate(Response response) throws java.text.ParseException {
        final JsonObject dataJson = response.readEntity(JsonObject.class);
        final JsonObject tokenJson = dataJson.getJsonObject("token");
        String expiresAt = tokenJson.getString("expires_at");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.getDefault());
        return dateFormat.parse(expiresAt);
    }

}