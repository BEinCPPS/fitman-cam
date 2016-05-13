[![Build Status](https://travis-ci.org/ascatox/BeInCpps.svg?branch=master)](https://travis-ci.org/ascatox/BeInCpps)
# BEinCPPS Project - CAM Service
## Usage
###Developer environment
This installation use **Sesame Repository in Memory** and **Apache Tomcat 7 Maven embedded** 
```bash
$ git clone https://github.com/ascatox/BeInCpps.git
$ cd BeInCpps/OntologyRepo
$ mvn install
$ cd ../CAMService
$ mvn package
$ mvn verify
```
`mvn verify` execute integration tests!

###User environment
Download and install [Apache Tomcat](https://tomcat.apache.org/download-80.cgi) (version >= **7**):
```bash
$ wget http://mirrors.muzzy.it/apache/tomcat/tomcat-8/v8.0.33/bin/apache-tomcat-8.0.33.zip
$ unzip apache-tomcat-8.0.33.zip
$ chmod +x ./apache-tomcat-8.0.33/bin/*.sh
```

[Download](https://sourceforge.net/projects/sesame/files/Sesame%204/4.1.1/openrdf-sesame-4.1.1-sdk.zip/download) and copy **sesame and openrdf-workbench** war files, inside installed Tomcat:
```bash
$ wget https://sourceforge.net/projects/sesame/files/Sesame%204/4.1.1/openrdf-sesame-4.1.1-sdk.zip/download
$ unzip openrdf-sesame-4.1.1-sdk.zip
$ cp ./openrdf-sesame-4.1.1/war/*.war ./apache-tomcat-8.0.33/webapps
$ ./apache-tomcat-8.0.33/bin/startup.sh
```
The default port in order to use CAMService with Sesame repo is 8180, feel free to change this parameter inside the file 
pom.xml into the ``<sesame.url>http://localhost:8180/openrdf-sesame/</sesame.url>`` resource.

Install CAMService:
```bash
$ git clone https://github.com/ascatox/BeInCpps.git
$ cd BeInCpps/OntologyRepo
$ mvn install
$ cd ../CAMService
$ mvn package -P prod
$ mvn verify opyional
```
To skip Unit Tests use ``-DskipTests`` maven parameter.

Copy the CAMService.war into a Tomcat installation.
```bash
$ cp ./BeInCpps/CAMService/target/target.war ./apache-tomcat-8.0.33/webapps
```

**Note**: The project use [travis-ci](https://travis-ci.org/) for continuous integration.


