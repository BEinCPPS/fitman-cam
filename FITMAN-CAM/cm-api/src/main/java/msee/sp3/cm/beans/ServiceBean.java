package msee.sp3.cm.beans;

import javax.annotation.Resource;

import msee.sp3.cm.domain.Service;

import org.kpe.commons.jpa.IGenericDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component("serviceBean")
public class ServiceBean implements IServiceBean {
	private Logger logger = LoggerFactory.getLogger(UserBean.class);

	@Resource
	private IGenericDAO<Service, Integer> serviceDAO;

	@Transactional
	@Override
	public boolean createService(Service service) {
		try {
			Service s = serviceDAO.querySingle("findByName", service.getServiceName());
			if( s==null){
				service.setLocalUserCreatorId(service.getLocalUserLastEditorId());
				serviceDAO.create(service);
			}
			else{
				service.setServiceId(s.getServiceId());
				service.setLocalUserCreatorId(s.getLocalUserCreatorId());
				serviceDAO.update(service);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			return false;
		}

		return true;
	}

}
