#!/bin/sh
/opt/confd -onetime -backend env
/opt/liferay/tomcat-7.0.62/bin/catalina.sh run