package it.eng.liferay.user.importer.filter;

import it.eng.liferay.user.importer.LiferayUserImporter;
import it.eng.liferay.user.importer.LiferayUserImporterImpl;
import it.eng.sso.filters.principal.http.SSOHttpServletRequestWrapper;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class LiferayUserImporterFilter implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		SSOHttpServletRequestWrapper req = (SSOHttpServletRequestWrapper) request;
		LiferayUserImporter importer= new LiferayUserImporterImpl();
		importer.manageLiferayUser(req.getUserPrincipal());
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
