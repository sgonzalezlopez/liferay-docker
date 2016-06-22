FROM liferay-base

MAINTAINER AXA MedLA
USER 0

RUN cd /tmp \
&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/mysql-connector-java-5.1.23.jar \
&& mv /tmp/mysql-connector-java-5.1.23.jar /opt/liferay/tomcat/lib/ext/mysql-connector-java-5.1.23.jar \
&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO  http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/Elasticray.lpkg \
&& mv /tmp/Elasticray.lpkg /opt/liferay/deploy/Elasticray.lpkg \
&& chmod 777 /opt/liferay/deploy/*

ADD /confd/*.tmpl /etc/confd/templates/
ADD /confd/*.toml /etc/confd/conf.d/

ADD ejecuta.sh /opt/liferay/
RUN chown 1000:1000 /opt/liferay/ejecuta.sh \
&& chmod +x /opt/liferay/ejecuta.sh

RUN cd /opt/liferay/deploy/ \
&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/license-portaldevelopment-developer-6.2ee-axa.xml
