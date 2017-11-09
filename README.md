[![Build Status](https://travis-ci.org/BEinCPPS/fitman-cam.svg?branch=master)](https://travis-ci.org/BEinCPPS/fitman-cam)

# Fitman-cam project

## Description of the component

The **Asset Registry for CPPS (CAM)** Specific Enabler is a web-based, integrated platform for the management of Virtualized Asset. This Specific Enabler is targeted to the business user, who is not required to have IT expertise, nor an in-depth knowledge of ontology-related concepts and technologies.

Asset Registry for CPPS is based on several open source components, covering different functional areas; on top of these, it adds a rich layer of web-based, custom front-end functionalities which integrates low-level services into a unified, user-friendly experience.

Asset Registry for CPPS is delivered as a module that allows the user to manipulate ontologies adding classes and templates and create, manipulate and delete Assets.


This Asset Registry for CPPS release contains two modules, **Asset-Registry-for-CPPS** and **Cam-Service**.
 
### Asset-Registry-for-CPPS

Cam is a web application that exploits cam-service APIs. Cam allows user to create, manipulate and delete Assets using a web interface.

### Cam-Service

Cam-Service component exposes its own public, proprietary REST-based web API. By means of API calls, the reference ontology, the asset repository and the service registry can be queried by external applications. The usual CRUD operations will be allowed on Class, Assets, Owners and Attributes.
	
## Developer environment

This procedure assumes that you have [Apache Tomcat](https://tomcat.apache.org/download-80.cgi) (version >= **7**)
and [RDF4J 2.0M2](http://rdf4j.org/download/) installed in your environment.

Before start using application you must have RDF4J up and running, we also need to create a new repository in it. 
We will refer to this repository as ```<EXAMPLE_REPO>```.

• Open a web browser and navigate to your rdf4j:
 ```
 <host>:<port>/rdf4j-workbench/
 ```

• Click on new repository, on top left, and fill id and title.<br/>
• Click next, select persistence mode and finally click finish.<br/>

If creation is successful the user will be redirected to repository summary.


+ **A.** Your project structure is as follows: <br/>

```
<your_project_dir>
   |__ cam
   |__ cam-service
```

+ **B.** Install Cam: <br/>

1.	Open a terminal window and go to the root folder of CAM project .
2.	Type the command: mvn package.
3.	Copy the war in ```target/``` to ```<PATH_TO_TOMCAT>/webapps```.
4.	Browse to ```<YOUR_HOST>:<YOUR_PORT>/CAM ``` to start using application.

+ **C.** Install Cam-Service:<br/>
```bash
$ cd cam-service
$ mvn package -P prod
```

To skip Unit Tests use ``-DskipTests`` maven parameter.

+ **D.** Integration Test (This test uses **Sesame Repository in Memory** and **Apache Tomcat 7 Maven embedded**):

```bash
$ cd cam-service
$ mvn package
$ mvn verify 
```

The default port in order to use CAMService with Sesame repo is 8080, feel free to change this parameter inside the file pom.xml.

Change sesame repository properties with your sesame installation: 

```bash
sesame.url
sesame.repository (<EXAMPLE_REPO>)
sesame.namespace
```

Copy the CAMService.war into a Tomcat installation.

```bash
$ cp ./cam-service/target/CAMService.war ./apache-tomcat-8.0.33/webapps
```

## Authentication
In the latest version of the project, authentication is **mandatory** for every type of environment.<br/>
Cam Project uses [OAuth2](https://oauth.net/2/) by means of the *Fiware enabler* **[Identity Management - KeyRock](https://catalogue.fiware.org/enablers/identity-management-keyrock)** for authentication and authorization.<br/>
**Identity Manager - KeyRock** could be installed with different possibilities as explained in the official [Github page](https://github.com/ging/fiware-idm). <br/>

### Basic configuration
The **fastest way** to have a working idM instance in your environment, is using the *Docker image*, following this [guide](https://github.com/ging/fiware-idm/blob/master/extras/docker/README.md).
>In particular way, follow the section '*Run the container from the last release in Docker Hub*'.

#### IdM OAuth2 configuration
**1**. Follow this [link](http://localhost:8000) to access to idM and authenticate with user and password of your installation (`idm/idm`in Docker image).<br/>
in **Home** page, in **Applications** section, **Register** a new application with these data (*):

| Data        | Value                                           | 
| ------------- |:---------------------------------------------:| 
| Name		      | CAM			                | 
| URL           | http://localhost:8080/Asset-Registry-for-CPPS                     | 
| Callback URL  | http://localhost:8080/Asset-Registry-for-CPPS/oauth_callback.html |

**2**. Click next to register data.<br/>
**3**. In **Applications** section open CAM Application and in **OAuth2 Credentials** copy your **Client ID**.
>(*) Fitman-cam local installation on Tomcat standard port.

#### Fitman-cam OAuth2 configuration
**1**. In **cam** folder edit the following properties in [pom.xml](https://github.com/BEinCPPS/fitman-cam/blob/master/cam/pom.xml):

```bash
<authentication.service>oAuth</authentication.service>
<horizon.url>http://localhost:8000</horizon.url>
<client.id>your Client ID</client.id>
```
**2**. From the same folder launch the command `mvn package`

**3**. In **cam-service** folder edit the following properties in [pom.xml](https://github.com/BEinCPPS/fitman-cam/blob/master/cam-service/pom.xml):
 
```bash
<keyrock.authentication.service>OAUTH2</keyrock.authentication.service>
<horizon.url>http://localhost:8000</horizon.url>
<keystone.url>http://localhost:5000</keystone.url>
<keystone.admin.user>idm</keystone.admin.user>
<keystone.admin.password>idm</keystone.admin.password> 
```
>You can edit only the properties in `prod` profile.

**4**. From the same folder launch the command `mvn package -P prod`

**5**. Copy the `Asset-Registry-for-CPPS war` and `CAMService.war` in your Tomcat webapps installation
```bash
$ cp ./cam-service/target/CAMService.war ./apache-tomcat-8.0.33/webapps && ./cam/target/Asset-Registry-for-CPPS.war ./apache-tomcat-8.0.33/webapps
```


**Note**: This project uses [Travis-Ci](https://travis-ci.org/) for continuous integration.
