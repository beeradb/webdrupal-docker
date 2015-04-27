Drupal Dockerfiles
==================

A Fedora 21 based vagrant VM which serves as a docker host for a Drupal site.

# Setup
Install [vagrant](vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

Before running vagrant you need to create a webdrupal/ and webdrupal-conf directory. Both of these get mounted by the vagrant virtual machine.

## conf/
This folder should contain a valid settings.php file and a "webdrupal.sql" which will be imported during provisioning.

## webdrupal/
This folder should contain your website, and specifically webdrupal/html/ should contain your Drupal site root directory.

# Installation
Once setup is complete you can initialize vagrant by running

```
# vagrant up
```