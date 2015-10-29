
### Prerequisites:

*	Liferay-portal-6.1.1-ce-ga2 bounded with Tomcat. (download link: http://garr.dl.sourceforge.net/project/lportal/Liferay Portal/6.1.1 GA2/liferay-portal-tomcat-6.1.1-ce-ga2-20120731132656558.zip)

*   install the provided Vaadin distribution on Liferay (a guide is available at:      https://vaadin.com/wiki/-/wiki/Main/Integrating+Vaadin+7+with+Liferay)

*	Tomcat version > = 6 (optional, you can use the Liferay Tomcat)

*	MySql version 5.5 installed.
       
        In order to have the portal working, import the sql script provided under /FITMAN-CAM/databases/fitman.sql

        In order to have the asset portlet working, import the sql script provided under /FITMAN-CAM/databases/asset.sql
        
        In order to have cm-api working, import the sql script provided in /FITMAN-CAM/databases/fitman_cm.sql

*   open-rdf sesame v 2.7.13 (download it at https://sourceforge.net/projects/sesame/files/Sesame%202/2.7.13/)
    (an example mini knowledge base with instructions to load it is provided inside            /FITMAN-CAM/TAO folder)

### Installation Steps:

#####	If Liferay is being installed for the first time please  launch it and perform the base configuration.
To configure liferay with a custom database add the following properties to the file <LIFERAY_HOME>/portal-setup-wizard.properties:

	jdbc.default.driverClassName
	jdbc.default.username
	jdbc.default.password
	jdbc.default.url (The schema has to be the one where fitman.sql has been imported)

*	download and install apache-maven-3.2.3 from http://maven.apache.org/download.cgi

*	download and install  apache-ant-1.9.4     from  http://ant.apache.org/bindownload.cgi

##### Copy the content of UTILS/ANT_LIBS under your ${ant.home}/lib folder

*	define two environment variables for the path of Maven and Ant.

*	copy the content of the folder Utils\ANT_LIBS in the Ant folder lib

##### For all the objects to be installed in the following, you must first correctly modify the values of LIFERAY_PORTAL_HOME and TOMCAT_HOME in the build.properties file.

###	COMMON/Fitman_Theme-theme

*	edit the file COMMON\Fitman_Theme-theme\build.properties 
	to properly define the following properies:
	LIFERAY_PORTAL_HOME: Path to liferay tomcat
	LIFERAY_PLUGIN_SDK: Path to liferay plugin sdk location
	LIFERAY_DEPLOY_FOLDER: Path to Liferay deploy folder
*	open a terminal window and go to the root folder of this project
*	type the command: ant deploy

### COMMON/SSO

#### COMMON/Portal_DB_Connector:
                  
*	Type the command : mvn install

#### COMMON/Portal_LsaService:

*	Edit the pom.xml file as follows: 

		<ver.url>http://localhost:8080/test/rest/v1/ves</ver.url>
		<liferay.db.driver>com.mysql.jdbc.Driver</liferay.db.driver>
		<liferay.db.connection>jdbc:mysql://localhost:3306/iep</liferay.db.connection>
		<liferay.db.username>iep</liferay.db.username>
		<liferay.db.password>iep</liferay.db.password>

*	open a terminal window and go to the root folder of this project
*	type the command: mvn package -Plocal  for local developing and testing. 

#### COMON/SingleSignOn

*	•	Edit the following properties in file pom.xml (you can modify the configuration including the LSAs, present in your environment):

		<host1.key>iep</host1.key>
		<host2.key>iep2</host2.key>
		<host3.key>iep3</host3.key>
		<host4.key>iep4</host4.key>

		<lsa1.uri>http://localhost:8080/portal-lsaservice/api/authenticate</lsa1.uri>
		<lsa2.uri>http://localhost:8081/portal-lsaservice/api/authenticate</lsa2.uri>
		<lsa3.uri>http://localhost:8080/portal-lsaservice/api/authenticate</lsa3.uri>
		<lsa4.uri>http://localhost:8081/portal-lsaservice/api/authenticate</lsa4.uri>
			
*	open a terminal window and go to the root folder of this project
*	type the command: mvn package -Plocal  for local developing and testing. 

*	edit build.properties (optional) 
	in particular target.web.dir is the directory of a local Tomcat installation.
	and project.src is the project folder.

*	in the terminal window type the command: ant deploy

#### COMMON/LiferayUserImporter (Required to use SSO with Liferay)
*	open a terminal window and go to the root folder of this project
*	type command mvn install.

#### COMMON/Liferay-login-ext (Required to use SSO with Liferay)
*	open a terminal window and go to the root folder of this project
*	type command mvn package  to generate jar file.
*	copy the generated jar file in the liferay lib folder. 

### COMMON/CM

#### cm-api-resources
*	open a terminal window and go to the root folder of this project
*	type the command: mvn install

#### cm-rest-client
*   open pom.xml and change the property <baseUrl>http://localhost:8380/cm-api/api/v1</baseUrl> with the deployed cm-api url
*	open a terminal window and go to the root folder of this project
*	type the command: mvn install

#### marketplace-ri-client
*	open a terminal window and go to the root folder of this project
*	type the command: mvn install

#### repository-ri-client
*	open a terminal window and go to the root folder of this project
*	type the command: mvn install

#### cm-api
*   after installing the above packages,
*   edit the file /cm-api/src/main/resources/META-INF/persistence.xml to set database connection properties
*	open a terminal window and go to the root folder of this project
*   type the command: mvn package

###	Asset

#### Asset_BackEnd
*   edit file /Asset_BackEnd/src/it/eng/asset/resources/jdbc.properties and set database and sesame repository properties
*	open a terminal window and go to the root folder of this project
*	type the command: ant  to compile the project and  create the jar archive. (optional as the portlets Asset_Viewer_Rep and                                      
    Asset_Viewer_Service_Rep executes the command itself)

#### VAM_RestClient
*   edit the file vam_rest.properties setting the property url with cm-api host/port
*	open a terminal window and go to the root folder of this project
*   type the command: ant  to compile the project and  create the jar archive. (optional as the portlets Asset_Viewer_Rep and 
*   Asset_Viewer_Service_Rep executes the command itself)

#### VAM_Rest
*   edit the file vam_rest.properties setting the property url with cm-api host/port
*	open a terminal window and go to the root folder of this project
*   type the command: ant  to compile the project and  create the jar archive. (optional as the portlets Asset_Viewer_Rep and 
*   Asset_Viewer_Service_Rep executes the command itself)

#### Asset_Rest

*   edit the file \Asset\Asset_Rest\build.properties to properly define the following properties:
	TOMCAT_HOME: Path to tomcat installation
*	open a terminal window and go to the root folder of this project
*	type the command: ant deploy 


#### Asset_Viewer_Rep

*   edit the file Asset_Viewer_Rep/src/jdbc.properties and set database connection and sesame repository properties
*	edit the file \Asset\Asset_Viewer_Rep\build.properties to properly define the following properties:
	LIFERAY_PORTAL_HOME: Path to liferay tomcat
	MAVEN_HOME: Path to local maven installation 
*	open a terminal window and go to the root folder of this project
*	type the command: ant deploy 

#### Asset_Viewer_Service_Rep

*   edit the file Asset_Viewer_Rep/src/jdbc.properties and set database connection and sesame repository properties

*	edit the file \Asset\Asset_Viewer_Service_Rep\build.properties to properly define the following properties:
	LIFERAY_PORTAL_HOME: Path to liferay tomcat
	MAVEN_HOME: Path to local maven installation 
*	open a terminal window and go to the root folder of this project
*	type the command: ant deploy 


#### Once the installation is complete, please follow the instructions in portal_configuration.txt to set up the portal