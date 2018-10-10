#!/bin/sh
if [ ! -f /root/.ESP/bootstrap.dat ]; then 
echo "Downloading bootstrap.dat"
wget https://espers.club/snapshot/linux-mac/Espers_Latest_Offical_Bootstrap-Linux-Mac.zip -O /tmp/bootstrap.zip \
        && unzip /tmp/bootstrap.zip -d /root/.ESP \
        && chmod 0777 /root/.ESP/bootstrap.dat
echo "Done downloading and unzipping"
fi
#Start the espers daemon
echo "Starting Espers daemon"
./opt/Espersd -debug=0
echo "Waiting for it to start"
#Wait for it to boot up
sleep 5;
echo "Daemon started"
#Check for info
while true; do
	./opt/Espersd getinfo
	echo "Sleeping for 10 seconds to get new info"
	sleep 10;
done
