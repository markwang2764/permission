FROM tomcat:8.5

MAINTAINER markwang2764@gmail.com

RUN rm -rf /usr/local/tomcat/webapps/*


ADD ./target/permission.war /usr/local/tomcat/webapps/

#端口
EXPOSE 8080

#设置启动命令
ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh","run"]