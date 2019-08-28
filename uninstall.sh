#!/bin/bash
main() {
clear
echo "Reset Crontab from Backup?"
echo "1. Reset"
echo "2. Reset and remove EasyCrontab"
echo "3. Show Backup"
echo "4. Just remove EasyCrontab"
echo "5. Exit"
read x
case "$x" in
1)
cp /etc/backup-crontab /etc/crontab
echo "Done"
exit="true"
;;
2)
mv /etc/backup-crontab /etc/crontab
rm /bin/ecrontab
rm /bin/easycron
rm /bin/uninstall-easycrontab
echo "Done"
exit="true"
;;
3)
nano /etc/backup-crontab
;;
4)
rm /bin/ecrontab
rm /bin/easycron
rm /bin/uninstall-easycrontab
echo "Done"
exit="true"
;;
5)
exit="true"
;;
esac
echo "Finished"
}


exit="false"
while [[ $exit == "false" ]]
do
main
done

