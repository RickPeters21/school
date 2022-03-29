FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && \
 apt-get -y install apache2

EXPOSE 80

CMD /var/www/html/build.pro.site.sh
