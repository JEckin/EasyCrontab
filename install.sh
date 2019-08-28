#!/bin/bash
apt-get install cron
apt-get install nano

cp /etc/crontab /etc/backup-crontab
cp easycrontab.sh /bin/easycron
cp easycrontab.sh /bin/ecrontab
cp uninstall.sh /bin/uninstall-easycrontab
chmod +x /bin/easycron
chmod +x /bin/ecrontab
chmod +x /bin/uninstall-easycrontab
clear
echo "Finished"
echo "Type in \"easycron\" or \"ecrontab\""
