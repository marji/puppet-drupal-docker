FROM ubuntu:12.04
MAINTAINER marji@morpht.com
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y openssh-server supervisor git puppet
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

# Remove host checking
#RUN echo "Host bitbucket.org\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

RUN git clone git://github.com/morpht/puppet-drupal-box.git /opt/puppet-drupal-box
RUN cd /opt/puppet-drupal-box && git submodule update --init
RUN puppet apply --modulepath=/opt/puppet-drupal-box/modules -e 'include drupal_sandbox'

RUN echo 'root:secret' | chpasswd

# Make this LAMP server one site only (overriding the puppet deploy)
RUN mkdir /var/www/docroot
ADD vhost /etc/apache2/sites-available/vhost_alias

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22 80 8080
CMD ["/usr/bin/supervisord"]
