#!/bin/bash
cp /etc/crontab /etc/backup-crontab
cp easycrontab.sh /bin/easycron
cp easycrontab.sh /bin/ecrontab
chmod +x /bin/easycron
chmod +x /bin/ecrontab
clear
echo "Finished"
echo "Type in \"easycron\" or \"ecrontab\""
