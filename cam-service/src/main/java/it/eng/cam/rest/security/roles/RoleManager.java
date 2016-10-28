//package it.eng.cam.rest.security.roles;
//
//
//import it.eng.cam.rest.security.service.IDMKeystone;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
///**
// * Created by ascatolo on 19/10/2016.
// */
//public class RoleManager {
//
//    private Map<String, String> rolesLookup;
//
//    public Map<String, String> getRolesLookup() {
//        return rolesLookup;
//    }
//
//    public RoleManager() {
//        rolesLookup = new HashMap<>();
//        //TODO Read file reoles.xml
//        if (null != roles)
//            for (String role :
//                    roles) {
//                if (role.equals("admin")) //TODO Hard Coded XML or JSON
//                    rolesLookup.put(role, Role.ADMIN);
//                else if (role.equals("community"))
//                    rolesLookup.put(role, Role.BASIC);
//                else if (role.equals("basic"))
//                    rolesLookup.put(role, Role.BASIC);
//                else if (role.equals("member"))
//                    rolesLookup.put(role, Role.BASIC);
//                else if (role.equals("owner"))
//                    rolesLookup.put(role, Role.BASIC);
//                else if (role.equals("trial"))
//                    rolesLookup.put(role, Role.BASIC);
//            }
//    }
//
//
//    private List<Role> readRolesFile(){
//
//    }
//
//
//    public static void main(String[] args) {
//        //Use for test
//        // Infos here http://www.developerfusion.com/code/2064/a-simple-way-to-read-an-xml-file-in-java/
//        RoleManager manager = new RoleManager();
//        for (String role:
//             manager.getRolesLookup().values()) {
//            System.out.println(role);
//        }
//    }
//}
