FROM ubuntu:18.04
RUN apt-get -y update 
RUN apt-get -y upgrade 
RUN DEBIAN_FRONTEND=noninteractive 
RUN apt-get install apache2 -y 
RUN apt-get install git -y 
RUN apt-get install python3 -y 


RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

WORKDIR /var/www/html/ 

RUN rm index.html -r
RUN git init 
RUN git remote add origin https://github.com/broadinstitute/covid19-testing.git 
RUN git pull origin master 

RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh && \
 echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh && \
 echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh && \ 
 echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh && \ 
 chmod 755 /root/run_apache.sh

EXPOSE 80 


CMD /root/run_apache.sh
