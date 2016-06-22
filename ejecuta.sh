
#!/bin/sh
/opt/confd -onetime -backend env
/opt/liferay/tomcat/bin/catalina.sh run
