#!/bin/bash -x -e

wget http://skarnet.org/software/s6-linux-utils/s6-linux-utils-2.4.0.0.tar.gz
wget http://skarnet.org/software/s6-networking/s6-networking-2.3.0.1.tar.gz
wget http://skarnet.org/software/s6-dns/s6-dns-2.2.0.0.tar.gz
wget http://skarnet.org/software/s6-portable-utils/s6-portable-utils-2.2.1.0.tar.gz

./s6-dns.SlackBuild 
installpkg /tmp/s6-dns-2.2.0.0-x86_64-1_Jw.tgz 

./s6-portable-utils.SlackBuild 
installpkg /tmp/s6-portable-utils-2.2.1.0-x86_64-1_Jw.tgz 

./s6-linux-utils.SlackBuild 
installpkg /tmp/s6-linux-utils-2.4.0.0-x86_64-1_Jw.tgz 

./s6-networking.SlackBuild 
installpkg /tmp/s6-networking-2.3.0.1-x86_64-1_Jw.tgz 
