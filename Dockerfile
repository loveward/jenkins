# base image
FROM electronuserland/builder:wine

# MAINTAINER
MAINTAINER loveward94@gmail.com

EXPOSE 8080
EXPOSE 5000


# running required command
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install default-jre wget -y

# 这是什么菜鸡？？？
# jenkins : Depends: daemon but it is not installable
#           Depends: psmisc but it is not installable
#           Depends: net-tools but it is not installable
#RUN wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
#RUN echo "deb https://pkg.jenkins.io/debian-stable binary/ " >  /etc/apt/sources.list
#RUN apt-get update -y
#RUN apt-get install -y jenkins 

RUN wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war

# copy file
ADD apache-tomcat-9.0.19.tar.gz /tomcat
RUN rm -rf /tomcat/apache-tomcat-9.0.19/webapps/*
RUN cp jenkins.war /tomcat/apache-tomcat-9.0.19/webapps/ROOT.war

# install python3
RUN apt-get install python3.5 python3-pip -y

# remove useless pkg
RUN apt autoremove -y 

# install minio-client
RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc
RUN chmod +x mc
RUN ln -s /project/mc /bin/mc 

# define ENTRYPOINT
#ENTRYPOINT ["/tomcat/apache-tomcat-9.0.19/bin/catalina.sh","run"]
ADD run.sh /root
RUN chmod 755 /root/run.sh
CMD ["/bin/bash","/root/run.sh"]

