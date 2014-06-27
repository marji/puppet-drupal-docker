# Puppet Drupal Docker

## Description
Dockerfile to build Puppet Drupal Docker from https://github.com/morpht/puppet-drupal-box

## Usage
Get:
```
$ git clone https://github.com/marji/puppet-drupal-docker.git
$ cd puppet-drupal-docker
```
Build:
```
$docker build -t yourname/puppet-drupal-docker .
```
Run:
```
$ docker run -d -v /your/dir/with/drupal:/var/www/docroot yourname/puppet-drupal-docker
```
Get your IP address:
```
$ docker ps | head
# see the name of the container you just executed, say it is "dockered_drupal"
$ docker inspect dockered_drupal | grep IPA
        "IPAddress": "172.17.0.239",
```
Connect:
```
http://172.17.0.239:8080/ (apache)
http://172.17.0.239:80/   (via varnish)
ssh root@172.17.0.239     (pass is secret - see Dockerfile)
```
Don't forget to load your html / php files under /your/dir/with/drupal directory, files there will appear under /var/www/docroot inside the container.
