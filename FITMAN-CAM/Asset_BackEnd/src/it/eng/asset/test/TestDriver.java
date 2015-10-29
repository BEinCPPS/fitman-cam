package it.eng.asset.test;

import it.eng.asset.service.ManagerRepositoryAssetService;
import it.eng.asset.service.VirtualizedRepositoryManager;

public class TestDriver {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
	    VirtualizedRepositoryManager managerRepositoryService = new ManagerRepositoryAssetService();
	    managerRepositoryService.getAllClasses();

	}

}
