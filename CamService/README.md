#CAM Service 2.0
###Developer environment

This procedure assumes that you have [Apache Tomcat](https://tomcat.apache.org/download-80.cgi) (version >= **7**)
and [Download](https://sourceforge.net/projects/sesame/files/Sesame%204/4.1.1/openrdf-sesame-4.1.1-sdk.zip/download) on your development environment.

Install CAMService:
```bash
$ git clone https://github.com/BEinCPPS/fitman-cam
$ cd BeInCpps/OntologyRepo
$ mvn install
$ cd ../CAMService
$ mvn package -P prod
$ mvn verify opyional
```
To skip Unit Tests use ``-DskipTests`` maven parameter.

To execute integration tests:
```bash
$ git clone https://github.com/BEinCPPS/fitman-cam
$ cd CAMService
$ mvn package
$ mvn verify (This test uses **Sesame Repository in Memory** and **Apache Tomcat 7 Maven embedded**)
```
The default port in order to use CAMService with Sesame repo is 8180, feel free to change this parameter inside the file 
pom.xml into the ``<sesame.url>http://localhost:8180/openrdf-sesame/</sesame.url>`` resource.

Copy the CAMService.war into a Tomcat installation.
```bash
$ cp ./BEinCPPS/CAMService/target/target.war ./apache-tomcat-8.0.33/webapps
```
