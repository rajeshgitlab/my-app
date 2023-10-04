FROM tomcat:8
# Take the war and copy to webapps of tomcat
RUN mv webapps webappsbkp
RUN mv webapps.dist webapps
COPY target/application.war /usr/local/tomcat/webapps/
