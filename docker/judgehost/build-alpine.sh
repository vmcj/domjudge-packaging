#!/bin/sh -eu

cd /domjudge-src/domjudge*
chown -R domjudge: .
# If we used a local source tarball, it might not have been built yet
#sudo -u domjudge make configure
echo "permit nopass domjudge as root" >> /etc/doas.d/doas.conf
echo "permit nopass root as domjudge" >> /etc/doas.d/doas.conf
sudo -u domjudge ./configure -with-baseurl=http://localhost/

echo "default	http://localhost/api	dummy	dummy" | sudo -u domjudge tee etc/restapi.secret > /dev/null

sudo -u domjudge make judgehost
make install-judgehost
