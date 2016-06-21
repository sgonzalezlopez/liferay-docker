FROM centos

MAINTAINER AXA MedLA

# install liferay

#ENV PROXY_HOST 10.185.4.54
#ENV PROXY_PORT 3128

#ENV REPO_USER user
#ENV REPO_PASS pass

ENV NEXUS_REPOSITORY nexus.axamedla-liferay.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/service/local/repositories/releases/content

ENV http_proxy http://${proxyHost}:${proxyPort}
ENV https_proxy http://${proxyHost}:${proxyHost}
ENV LIFERAY_HOME /opt/liferay 
ENV CATALINA_OPTS -Dhttp.proxyHost=${proxyHost} -Dhttp.proxyPort=${proxyPort} -Dhttps.proxyHost=${proxyHost} -Dhttps.proxyPort=${proxyPort}

RUN cd /opt \
&& curl -LO -x ${http_proxy} https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 \
&& chmod 777 /opt/confd-0.11.0-linux-amd64 \
&& mv confd-0.11.0-linux-amd64 confd \
&& mkdir -p /etc/confd/{conf.d,templates} \
&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/portal-bundle.properties.tmpl \
&& mv portal-bundle.properties.tmpl /etc/confd/templates/ \
&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/portal-bundle.properties.toml \
&& mv portal-bundle.properties.toml /etc/confd/conf.d/


RUN yum -y update \
&& yum install -y unzip \ 
&& yum clean all

#ADD jdk-7u79-linux-x64.rpm .
RUN cd /tmp \
&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/jdk-7u79-linux-x64.rpm \
&& rpm -i /tmp/jdk-7u79-linux-x64.rpm \
&& rm -f /tmp/jdk-7u79-linux-x64.rpm

RUN cd /opt \
    && curl -LO http://${NEXUS_REPOSITORY}/liferay/bundle/6.2-ee-axa/bundle-6.2-ee-axa.tar.gz \
    && tar xzvf bundle-6.2-ee-axa.tar.gz \
    && rm -f bundle-6.2-ee-axa.tar.gz \
    && ln -s /opt/liferay-portal-6.2-ee-axa /opt/liferay

#ADD liferay-portal-tomcat-6.2-ee-sp14-20151105114451508.zip /tmp
#RUN cd /tmp \
#&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/liferay-portal-tomcat-6.2-ee-sp14-20151105114451508.zip \
#&& unzip /tmp/liferay-portal-tomcat-6.2-ee-sp14-20151105114451508.zip -d /opt \
#&& rm -f /tmp/liferay-portal-tomcat-6.2-ee-sp14-20151105114451508.zip \
#&& ln -s /opt/liferay-portal-6.2-ee-sp14 /opt/liferay

RUN mkdir /opt/liferay/deploy/
#&& cd /opt/liferay/deploy/ \
#&& curl --digest -x ${http_proxy} --user ${REPO_USER}:${REPO_PASS} -LO http://filerepo.osappext.pink.eu-central-1.aws.openpaas.axa-cloud.com/liferay-docker/license-portaldevelopment-developer-6.2ee-axa.xml

RUN groupadd 1000 \
    && useradd -g 1000 -d $LIFERAY_HOME -s /bin/bash -c "Docker image user" 1000 \
    && chown -R 1000:1000 /opt/liferay \
    && chmod -R 777 /opt/liferay

USER 1000

RUN /opt/confd -onetime -backend env

EXPOSE 8080 8009

WORKDIR $LIFERAY_HOME

ENTRYPOINT ["/opt/liferay/tomcat-7.0.42/bin/catalina.sh", "run"]
