FROM liferay_base:latest

MAINTAINER AXA MedLA

USER 0

ADD /confd/portal-bundle.properties.tmpl /etc/confd/templates/
ADD /confd/portal-bundle.properties.toml /etc/confd/conf.d/
ADD /confd/cluster-config.xml.tmpl /etc/confd/templates/
ADD /confd/cluster-config.xml.toml /etc/confd/conf.d/
ADD /confd/portal-ext.properties.tmpl /etc/confd/templates/
ADD /confd/portal-ext.properties.toml /etc/confd/conf.d/


RUN cd /tmp \
&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/mysql-connector-java-5.1.23.jar \
&& mv /tmp/mysql-connector-java-5.1.23.jar /opt/liferay/tomcat/lib/ext/mysql-connector-java-5.1.23.jar \
&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO  http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/Elasticray.lpkg \
&& mv /tmp/Elasticray.lpkg /opt/liferay/deploy/Elasticray.lpkg \
&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO  http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/lcs-portlet.war \
&& mv /tmp/lcs-portlet.war /opt/liferay/deploy/lcs-portlet.war \
&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO  http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/lcs-aatf-1613083.aatf \
&& mv /tmp/lcs-aatf-1613083.aatf /opt/liferay/data/lcs-aatf-1613083.aatf \
&& chmod 777 /opt/liferay/deploy/* \
&& chmod 777 /opt/liferay/data/lcs-aatf-1613083.aatf \
&& mkdir /opt/liferay/cluster-config \
&& chmod 777 /opt/liferay/cluster-config

EXPOSE 8080 8009

WORKDIR $LIFERAY_HOME
