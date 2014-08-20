Sample-Docker
=========

Sample-Docker contains several helper scripts & Dockerfile for an application.

  - DNS
  - Apache
  - Wildfly
  - Mysql
  - Postgresql ( will be updated )

What is [Docker] [1]?:
 
> Docker is an open platform for developers and sysadmins to build, ship, and run distributed 
> applications. Consisting of Docker Engine, a portable, lightweight runtime and packaging tool, 
> and Docker Hub, a cloud service for sharing applications and automating workflows, Docker enables
> apps to be quickly assembled from components and eliminates the friction between development, QA,
> and production environments. As a result, IT can ship faster and run the same app, unchanged, 
> on laptops, data center VMs, and any cloud.


Getting quick start
-------------------

* [Testing Environment for clustered Wildfly using DNS 1]
* [Testing Environment for clustered Wildfly using DNS 2]

Helper scripts document
-----------------------
* [Helper scripts document]


Notice
--------------

It still uses lxc so you need to change default driver from libcontainer to LXC.

Edit */usr/lib/systemd/system/docker.service* (Fedora version) and add "** -e lxc **"
```sh
other_args="--selinux-enabled -e lxc -b none"

or

ExecStart=/usr/bin/docker -d --selinux-enabled -e lxc -b none -H fd://

```



License
----

Licensed under the Apache License, Version 2.0


**Free Software*
[1]:https://www.docker.com/whatisdocker/
[Testing Environment for clustered Wildfly using DNS 1]:http://jhouse0317.tistory.com/entry/Docker-Testing-Environment-for-clustered-Wildfly-using-DNS-1
[Testing Environment for clustered Wildfly using DNS 2]:http://jhouse0317.tistory.com/entry/Testing-Environment-for-clustered-Wildfly-using-DNS-2
[Helper scripts document]:http://jhouse0317.tistory.com/entry/Docker-Default-Helper-Scripts-files

