#CAM Service 2.0
###Developer environment

This procedure assumes that you have [Apache Tomcat](https://tomcat.apache.org/download-80.cgi) (version >= **7**)
and [Sesame 4.1.1](https://sourceforge.net/projects/sesame/files/Sesame%204/4.1.1/openrdf-sesame-4.1.1-sdk.zip/download) installed in your environment.

A. Your project structure is as follows: <br/>
```
<your_project_dir>
   |__ CAM
   |__ CamService
```

B. Install CAMService:
```bash
$ cd CAMService
$ mvn package -P prod
$ mvn verify opyional
```
To skip Unit Tests use ``-DskipTests`` maven parameter.

C. Integration Tests:
```bash
$ cd CAMService
$ mvn package
$ mvn verify (This test uses **Sesame Repository in Memory** and **Apache Tomcat 7 Maven embedded**)
```
The default port in order to use CAMService with Sesame repo is 8080, feel free to change this parameter inside the file 
pom.xml into the ``<sesame.url>http://localhost:8180/openrdf-sesame/</sesame.url>`` resource.

Copy the CAMService.war into a Tomcat installation.
```bash
$ cp ./BEinCPPS/CAMService/target/target.war ./apache-tomcat-8.0.33/webapps
```
