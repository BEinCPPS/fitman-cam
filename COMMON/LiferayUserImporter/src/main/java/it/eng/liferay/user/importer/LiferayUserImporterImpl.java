package it.eng.liferay.user.importer;

import it.eng.sso.filters.principal.bean.SSOPrincipal;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;

import com.liferay.portal.NoSuchUserException;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.model.Company;
import com.liferay.portal.model.Role;
import com.liferay.portal.model.User;
import com.liferay.portal.service.CompanyLocalServiceUtil;
import com.liferay.portal.service.RoleLocalServiceUtil;
import com.liferay.portal.service.ServiceContext;
import com.liferay.portal.service.UserLocalServiceUtil;

public class LiferayUserImporterImpl implements LiferayUserImporter {

	@Override
	public boolean manageLiferayUser(SSOPrincipal principal) {

		if (principal == null)
			return false;

		Company company = null;
		String emailAddress = null;
		try {
			company = CompanyLocalServiceUtil.getCompanyByWebId("liferay.com");
			if (company == null) {
				return false;
			}

			String jobTitle, password1, password2, screenName, openId, middleName, firstName, lastName;
			long facebookId;
			boolean autoPassword, autoScreenName, male, sendEmail;
			Locale locale;
			int prefixId, suffixId, birthdayMonth, birthdayDay, birthdayYear;
			long[] groupIds = null;
			long[] organizationIds = null;
			long[] userGroupIds = null;
			long[] roleIds = null;
			ArrayList<Role> roles = new ArrayList<Role>();

			// verify if user exists

			emailAddress = principal.getEmail() == null ? "" : principal
					.getEmail();
			User user = null;
			screenName = principal.getName() == null ? "" : principal.getName();
			List<Role> rolas = obtainRolesFromPrincipal(principal, company);
			if (rolas != null) {
				int i = 0;
				roleIds = new long[rolas.size()];
				for (Role role : rolas) {
					if (role.getName().startsWith(
							PropertyReader.getPlatformRolePrefix())) {
						roles.add(role);
						roleIds[i] = role.getRoleId();
						i++;
					}
				}
			}

			// user =
			// UserLocalServiceUtil.getUserByEmailAddress(company.getCompanyId(),
			// emailAddress);
			try {
				user = UserLocalServiceUtil.getUserByScreenName(
						company.getCompanyId(), screenName);
			} catch (NoSuchUserException e) {
				// e.printStackTrace();
			}

			if (user == null) {
				// insert user
				try {
					user = UserLocalServiceUtil.getUserByEmailAddress(
							company.getCompanyId(), emailAddress);
					if (user != null)
						throw new PortalException("Invalid mail "
								+ emailAddress + "  for user " + screenName);
				} catch (NoSuchUserException e) {
					// e.printStackTrace();
				}
				jobTitle = StringPool.BLANK;
				autoPassword = true;
				// password1 = null;
				password1 = PropertyReader.getDefaultPassword();
				password2 = password1;
				autoScreenName = false;
				facebookId = 0;
				openId = StringPool.BLANK;
				locale = Locale.US;
				middleName = StringPool.BLANK;
				firstName = screenName; // take from principal???
				lastName = StringPool.BLANK; // take from principal???
				prefixId = 0;
				suffixId = 0;
				male = true;
				birthdayMonth = Calendar.JANUARY;
				birthdayDay = 1;
				birthdayYear = 1970;
				sendEmail = false;

				ServiceContext serviceContext = new ServiceContext();
				user = UserLocalServiceUtil.addUser(0, company.getCompanyId(),
						autoPassword, password1, password2, autoScreenName,
						screenName, emailAddress, facebookId, openId, locale,
						firstName, middleName, lastName, prefixId, suffixId,
						male, birthdayMonth, birthdayDay, birthdayYear,
						jobTitle, groupIds, organizationIds, roleIds,
						userGroupIds, sendEmail, serviceContext);

				if (user != null) {
					user.setComments("AUTOMATIC USER Don't modify!!!");
					user.setPasswordReset(false);
					user.setAgreedToTermsOfUse(true);
					user.setReminderQueryAnswer("Which is my father name?");
					user.setReminderQueryQuestion("r");
					UserLocalServiceUtil.updateUser(user);
				}

				// user = UserLocalServiceUtil.addUser(userToCreate);

				return true;
			} else {
				// update user
				if (!user.getComments().toUpperCase()
						.contains("AUTOMATIC USER")) // CASE
														// NOT
														// AUTOMATIC
					return true;
				else { // CASE AUTOMATIC
					user.setEmailAddress(emailAddress);
					List<Role> rolesAppo = new ArrayList<Role>();
					if (roles != null) {
						rolesAppo.addAll(user.getRoles());
						for (Role role : rolesAppo) {
							if (role.getName().startsWith(
									PropertyReader.getPlatformRolePrefix())) {
								UserLocalServiceUtil.deleteRoleUser(
										role.getRoleId(), user.getUserId());
							}
						}
						RoleLocalServiceUtil.addUserRoles(user.getUserId(),
								roleIds);

					}

					return UserLocalServiceUtil.updateUser(user) == null ? false
							: true;
				}
			}
		} catch (PortalException e) {
			e.printStackTrace();
			return false;
		} catch (SystemException e) {
			e.printStackTrace();
			return false;
		}

	}

	private ArrayList<Role> obtainRolesFromPrincipal(SSOPrincipal principal,
			Company company) throws PortalException, SystemException {
		long[] roleIds;
		ArrayList<Long> roleIdList = new ArrayList<Long>();
		ArrayList<Role> roles = new ArrayList<Role>();

		if (principal.getRoles() != null) {
			String roleName = "";
			long roleId = 0;
			Role role = null;
			for (int i = 0; i < principal.getRoles().size(); i++) {
				roleName = principal.getRoles().get(i) == null ? "" : principal
						.getRoles().get(i);
				if (roleName.startsWith(PropertyReader.getPlatformRolePrefix())) {
					roleId = RoleLocalServiceUtil.getRole(
							company.getCompanyId(), roleName).getRoleId();
					role = RoleLocalServiceUtil.getRole(company.getCompanyId(),
							roleName);
					if (roleId != -0) { // per non trovato cosa
										// torna?
						roleIdList.add(roleId);
						roles.add(role);
					}

				}
			}
			roleIds = new long[roleIdList.size()];
			for (int j = 0; j < roleIdList.size(); j++) {
				roleIds[j] = roleIdList.get(j);
			}
		}
		return roles;
	}

	private static class PropertyReader {

		private final static String PLATFORM_ROLE_PREFIX = "PLATFORM_ROLE_PREFIX";
		// private final static String PLATFORM_ROLE_ADMIN=
		// "PLATFORM_ROLE_ADMIN";
		private final static String DEFAULT_PASSWORD = "DEFAULT_PASSWORD";

		private static ResourceBundle finder = ResourceBundle
				.getBundle("liferayUserImporter");

		public static String getPlatformRolePrefix() {
			return finder.getString(PropertyReader.PLATFORM_ROLE_PREFIX);
		}

		public static String getDefaultPassword() {
			return finder.getString(PropertyReader.DEFAULT_PASSWORD);
		}

	}

}
