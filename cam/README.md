#CAM 
###Description of the component
The **Collaborative Asset Management (CAM)** Specific Enabler is a web-based, integrated platform for the management of Virtualized Asset. This Specific Enabler is targeted to the business user, who is not required to have IT expertise, nor an in-depth knowledge of ontology-related concepts and technologies.

CAM is based on several open source components, covering different functional areas; on top of these, it adds a rich layer of web-based, custom front-end functionalities which integrates low-level services into a unified, user-friendly experience.

CAM is delivered as a module that allows the user to manipulate ontologies adding classes and templates and create, manipulate and delete Assets.


###Developer environment

This procedure assumes that you have [Apache Tomcat](https://tomcat.apache.org/download-80.cgi) (version >= **7**)
and [Sesame 4.1.1](https://sourceforge.net/projects/sesame/files/Sesame%204/4.1.1/openrdf-sesame-4.1.1-sdk.zip/download) installed in your environment.

A. Your project structure is as follows: <br/>
```
<your_project_dir>
   |__ CAM
   |__ CAMService
```
B. Install CAMS: <br/>

Download the source code:
```
 git clone  https://github.com/BEinCPPS/fitman-cam.git
```

1.	Open a terminal window and go to the root folder of CAM project .
2.	Type the command: mvn package.
3.	Copy the war in ```target/``` to ```<PATH_TO_TOMCAT>/webapps```.
4.	Browse to ```<YOUR_HOST>:<YOUR_PORT>/CAM ``` to start using application.

