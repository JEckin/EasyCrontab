#!/bin/bash
clear

create() {
clear
echo "User?"
read user
echo "Command?"
read command
clear
echo "1) Every day at certain Time 2) Every certain Minute"
echo "3) Certain Day in a Month at certain Time"
echo "4) Certain Day in every Week at certain Time"
echo "5) Every reboot"
echo "99) Other"
read c
case "$c" in
1)
clear
echo "Hour?"
read hour
echo "Minute?"
read minute
a="$minute $hour * * *"
;;
2)
clear
echo "Minute/s?"
read time
a="*/$time * * * *"
;;
3)
clear
echo "Day of the Month"
read day
echo "Hour"
read hour
echo "Minute"
read minute
a="$minute $hour $day * *"
;;
4)
echo "Day of the week (0&7=Sunday,1=Monday,2=Tuesday,3=Wednesday,4=Thursday,5=Friday,6=Saturday)"
read week
echo "Hour"
read hour
echo "Minute"
read minute
a="$minute $hour * * $week"
;;
99)
echo "Minute           (* = Every minute, */5 = Every 5 Minutes)"
read minute
echo "Hour             (* = Every hour , */5 = Every 5 Hours)"
read hour
echo "Day of the Month (* = Every Day, */5 = Every 5 Days)"
read day
echo "Month            (* = Every Month , */5 = Every 5 Months)"
read month
echo "Day of the week"
echo "                 0&7=Sunday, 1=Monday, 2=Tuesday, 3=Wednesday, 4=Thursday"
echo "                 5=Friday, 6=Saturday, *=Every Week"
read week
a="$minute $hour $day $month $week"
;;
5)
a="@reboot	"
;;
*)
a="* * * * *"
;;
esac
echo "$a	$user	$command" >> /etc/crontab
list
}

backup() {
clear
echo "1) Create Backup from Crontab"
echo "2) Create a Crontab auto backup"
echo "3) List all Backups"
echo "4) Cancel"
read t
date=$(date +"%H:%M_%d.%m.%Y")
if [[ ! -d /etc/crontab-backup ]]
then
mkdir /etc/crontab-backup
fi
case "$t" in
1)
cp /etc/crontab /etc/crontab-backup/backup-$date
clear
echo "Backup folder: /etc/crontab-backup"
echo "============================="
ls -l /etc/crontab-backup/
echo "============================="
echo "Press enter..."
read temp
;;
2)
clear
echo "1) Every month"
echo "2) Every Day"
read tt
if [[ $tt == "1" ]]
then
clear
echo "User:"
read user
echo "Minute:"
read minute
echo "Hour:"
read hour
echo "Day:"
read day
a="$minute $hour $day * *"
else
clear
echo "User:"
read user
echo "Minute:"
read minute
echo "Hour:"
read hour
a="$minute $hour * * *"
fi
;;
3)
clear
du -hs /etc/crontab-backup
echo "============================="
ls -l /etc/crontab-backup/
echo "============================="
echo "Press enter..."
read temp
;;
*)
;;
esac
if [[ ! $user == "" ]]
then
echo "$a        $user   cp /etc/crontab /etc/crontab-backup/backup-\$(date +'%H:%M_%d.%m.%Y')" >> /etc/crontab
list
user=""
fi
}

list() {
clear
echo "==========================================="
grep -v '^$\|^\s*\#' /etc/crontab
echo "==========================================="
echo "Press enter"
read temp
}

remove() {
clear
echo "Remove"
echo "==========================================="
cat -n /etc/crontab
echo "==========================================="
echo "Line?"
read line
if [[ $line != "" ]]
then
touch /tmp/crontab
sed -e "$(echo $line )d" /etc/crontab > /tmp/crontab
cp /tmp/crontab /etc/crontab
rm /tmp/crontab

fi
}

edit() {
nano /etc/crontab
}

main() {
clear
echo "==================================================="
echo "  ___               ___             _        _"
echo " | __|__ _ ____  _ / __|_ _ ___ _ _| |_ __ _| |__"
echo " | _|/ _\` (_-< || | (__| '_/ _ \ ' \  _/ _\` | '_ \\"
echo " |___\__,_/__/\_, |\___|_| \___/_||_\__\__,_|_.__/"
echo "              |__/"
echo "==================================================="
echo " 1) Create"
echo " 2) List"
echo " 3) Remove"
echo " 4) Edit"
echo " 5) Backup"
echo " 6) Exit"
read o
case "$o" in
"exit"|"q")
exit=true
;;
1)
create
;;
2)
list
;;
3)
remove
;;
4)
edit
;;
5)
backup
;;
6)
exit
;;
*)
echo ""
;;
esac
}


exit="false"
while [[ $exit == "false" ]]
do
main
done
