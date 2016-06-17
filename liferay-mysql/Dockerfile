FROM liferay-test:latest

MAINTAINER AXA MedLA
USER 0

RUN cd /tmp \
&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/mysql-connector-java-5.1.23.jar \
&& mv /tmp/mysql-connector-java-5.1.23.jar /opt/liferay/tomcat-7.0.62/lib/ext/mysql-connector-java-5.1.23.jar

#ADD portal-ext.properties /opt/liferay/tomcat-7.0.62/webapps/ROOT/WEB-INF/classes/
ADD portal-ext.properties.tmpl /etc/confd/templates/
ADD portal-ext.properties.toml /etc/confd/conf.d/
#RUN /opt/confd -onetime -backend env \
#&& cat /opt/liferay/tomcat-7.0.62/webapps/ROOT/WEB-INF/classes/portal-ext.properties

ADD ejecuta.sh /opt/liferay/
RUN chown 1000:1000 /opt/liferay/ejecuta.sh \
&& chmod +x /opt/liferay/ejecuta.sh

#RUN cd /tmp \
#&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/portal-ext.properties
#&& mv /tmp/portal-ext.properties /opt/liferay/tomcat-7.0.62/webapps/ROOT/WEB-INF/classes/portal-ext.properties \
#&& rm /tmp/portal-ext.properties
USER 1000

ENTRYPOINT ["/opt/liferay/ejecuta.sh"]
