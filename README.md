Installation
=================

Ubuntu 14 based vagrant VM which serves as a docker host for the webdrupal site. All containers run on a CentOS 6.6 base.


# Setup
Install [vagrant](vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

The webdrupal folder will be mounted into the vagrant host via NFS, so you'll need and NFS server running on your computer.

## Before Building

Ensure nothing is running locally on the following ports, as vagrant will try to use them and will almost certain be unhappy if it cant:

    8080
    8081
    3306
    7070
    11211


You'll also want to add an entry in your /etc/hosts file for the webdrupal.dev site, the entry should look like this:
```
127.0.0.1   webdrupal.dev
```

For advanced usage, you also might want to provide host entries for some of the services vagrant runs, which will allow you to do things like use drush from the host machine.
```
127.0.0.1   memcache db
```

## Building

Once you've completed setup can just run the make. The initial build can take quite a while (30 minutes or so), as it needs to install multiple operating systems and build the dependencies for the various containers.

```
reactor[~/Projects/webdrupal] $ make vagrant
```


Exposed Services
=====================
A handful of ports are passed through and bound to the host machine, here's an overview of which ports are exposed and for what reason. This also serves as a decent description of the services this vagrant provides.

### MySQL - Port 3306
Standard mysql port. This allows you to connect to your mysql instance from the vagrant host machine. To connect, you must still provide a host argument to mysql, as if you don't it will assume the local socket.

Example:
```
reactor[~/Projects/webdrupal] $ mysql -uroot -proot -hwebdrupal.dev
```

### HAProxy - Port 8080
HTTP port the HAProxy load balancer runs on.  Using this port will use roundrobin style load balancing to serve webdrupal from the multiple web nodes running.

### Apache HTTPD - Port 8081
HTTP port. This is a passthrough directly to the webhead web1, for situations where you might not want to go through the load balancer.

### HAProxy Stats - Port  7070
HTTP port for HAProxy stats. Will tell you the current status of each webhead. Pretty neat, but probably not super useful for every day use.

### Memcached - Port 11211
Memcache port. Allows you to check stats like so:

```
reactor[~/Projects/webdrupal] $ echo stats | nc 127.0.0.1 11211
```

