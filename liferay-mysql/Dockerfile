FROM liferay-test:latest

MAINTAINER AXA MedLA

ADD portal-ext.properties /opt/liferay/tomcat-7.0.62/webapps/ROOT/WEB-INF/classes/

#RUN cd /tmp \
#&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/portal-ext.properties
#&& mv /tmp/portal-ext.properties /opt/liferay/tomcat-7.0.62/webapps/ROOT/WEB-INF/classes/portal-ext.properties \
#&& rm /tmp/portal-ext.properties


RUN cd /tmp \
&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/mysql-connector-java-5.1.23.jar
&& mv /tmp/mysql-connector-java-5.1.23.jar /opt/liferay/tomcat-7.0.62/lib/ext/mysql-connector-java-5.1.23.jar \
&& rm /tmp/mysql-connector-java-5.1.23.jar

