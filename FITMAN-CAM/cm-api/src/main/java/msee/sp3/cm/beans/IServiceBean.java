package msee.sp3.cm.beans;

import msee.sp3.cm.domain.Service;

import org.springframework.transaction.annotation.Transactional;

public interface IServiceBean {
	
	@Transactional
	boolean createService(Service service);

}
