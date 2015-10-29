package it.eng.liferay;

import it.eng.liferay.user.importer.LiferayUserImporter;
import it.eng.liferay.user.importer.LiferayUserImporterImpl;
import it.eng.sso.filters.principal.bean.SSOPrincipal;

import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.liferay.portal.NoSuchUserException;
import com.liferay.portal.kernel.util.PropsKeys;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.Company;
import com.liferay.portal.model.User;
import com.liferay.portal.security.auth.CASAutoLogin;
import com.liferay.portal.service.CompanyLocalServiceUtil;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.portal.servlet.filters.sso.cas.CASFilter;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portal.util.PrefsPropsUtil;
import com.liferay.portal.util.PropsValues;

public class CASAutoLoginExt extends CASAutoLogin {
	private static final String DEFAULT_LOGIN_USER = "default_login_user";
	private Logger logger = Logger.getLogger(CASAutoLoginExt.class.getName());
	private ResourceBundle finder = ResourceBundle.getBundle("liferay-login");

	@Override
	public String[] login(HttpServletRequest request,
			HttpServletResponse response) {
		String[] credentials = null;
		try {
			long companyId = PortalUtil.getCompanyId(request);

			if (!PrefsPropsUtil.getBoolean(companyId,
					PropsKeys.CAS_AUTH_ENABLED, PropsValues.CAS_AUTH_ENABLED)) {

				return credentials;
			}

			HttpSession session = request.getSession();
			String login = (String) session.getAttribute(CASFilter.class
					.getName() + "LOGIN");
			SSOPrincipal principal = (SSOPrincipal) session
					.getAttribute("principal");
			if (Validator.isNull(login)) {
				return credentials;
			}
			LiferayUserImporter importer = new LiferayUserImporterImpl();
			importer.manageLiferayUser(principal);
	
			User user = null;
			try {
				//user = UserLocalServiceUtil.getUserByEmailAddress(companyId, login);
				 user = UserLocalServiceUtil.getUserByScreenName(companyId, login);
				 
				 //TODO MESSAGE

			} catch (NoSuchUserException nsue) {
				String webId = "liferay.com"; // PropsUtil.get(PropsKeys.COMPANY_DEFAULT_WEB_ID)
				Company company = CompanyLocalServiceUtil
						.getCompanyByWebId(webId);

					try {
						user = UserLocalServiceUtil.getUserByEmailAddress(
								company.getCompanyId(),
								finder.getString(DEFAULT_LOGIN_USER));
					} catch (NoSuchUserException e) {
						user = UserLocalServiceUtil.getDefaultUser(company
								.getCompanyId());
					}
				}
		
			// String webId = "liferay.com"; //
			// PropsUtil.get(PropsKeys.COMPANY_DEFAULT_WEB_ID)
			// Company company =
			// CompanyLocalServiceUtil.getCompanyByWebId(webId);
			// user =
			// UserLocalServiceUtil.getDefaultUser(company.getCompanyId());

			credentials = new String[3];
			credentials[0] = String.valueOf(user.getUserId());
			credentials[1] = user.getPassword();
			credentials[2] = Boolean.TRUE.toString();
			return credentials;

		} catch (Throwable e) {
			logger.error("Can't auto-login, reverting to default behavior", e);
		}

		return super.login(request, response);
	}

}