#!/bin/bash -x -e

wget http://skarnet.org/software/s6/s6-2.6.0.0.tar.gz
wget http://skarnet.org/software/execline/execline-2.3.0.1.tar.gz
wget http://skarnet.org/software/skalibs/skalibs-2.5.1.1.tar.gz
wget http://skarnet.org/software/s6-linux-utils/s6-linux-utils-2.4.0.0.tar.gz
wget http://skarnet.org/software/s6-networking/s6-networking-2.3.0.1.tar.gz
wget http://skarnet.org/software/s6-dns/s6-dns-2.2.0.0.tar.gz
wget http://skarnet.org/software/s6-linux-init/s6-linux-init-0.3.0.0.tar.gz
wget http://skarnet.org/software/s6-portable-utils/s6-portable-utils-2.2.1.0.tar.gz
wget http://skarnet.org/software/s6-rc/s6-rc-0.2.1.1.tar.gz

./skalibs.SlackBuild 
installpkg /tmp/skalibs-2.5.1.1-x86_64-1_Jw.txz 

./execline.SlackBuild 
installpkg /tmp/execline-2.3.0.1-x86_64-1_Jw.tgz 

./s6-dns.SlackBuild 
installpkg /tmp/s6-dns-2.2.0.0-x86_64-1_Jw.tgz 

./s6-portable-utils.SlackBuild 
installpkg /tmp/s6-portable-utils-2.2.1.0-x86_64-1_Jw.tgz 

./s6-linux-utils.SlackBuild 
installpkg /tmp/s6-linux-utils-2.4.0.0-x86_64-1_Jw.tgz 

./s6.SlackBuild
installpkg /tmp/s6-2.6.0.0-x86_64-1_Jw.tgz 

./s6-networking.SlackBuild 
installpkg /tmp/s6-networking-2.3.0.1-x86_64-1_Jw.tgz 

./s6-linux-init.SlackBuild 
installpkg /tmp/s6-linux-init-0.3.0.0-x86_64-1_Jw.tgz 

