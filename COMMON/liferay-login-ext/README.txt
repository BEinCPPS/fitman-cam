THIS JAR IS NEEDED TO AUTHENTICATION BY ENG SSO IN LIFERAY 6.1.1
portal-ext.properties 
---TOMCAT_HOME/webapps/ROOT/WEB-INF/classes
auto.login.hooks=it.eng.liferay.CASAutoLoginExt

--NEEDED ONLY TO EXTRACT SAML ATTRIBUTES FROM SSO	

web.xml
<!-- 
Edit the LifeRay web.xml file. It can be found in TOMCAT_HOME/webapps/ROOT/WEB-INF. Replace the line

<filter-class>com.liferay.portal.servlet.filters.sso.cas.CASFilter</filter-class>

with

<filter-class>it.eng.liferay.CASFilterExt</filter-class>
-->