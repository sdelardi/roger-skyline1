#!/bin/bash
if [ ! -e /etc/crontemp ]
then
	echo "0 0 * * * sh `pwd`/04.sh" >> /etc/crontab
	cp /etc/crontab /etc/crontemp
else
	diff /etc/crontemp /etc/crontab > difftmp
	if [ $? -ne 0 ]
	then
		mail -s "Crontab changed !" user@`hostname` < difftmp
		rm difftmp
		rm -f /etc/crontemp
		cp /etc/crontab /etc/crontemp
	fi
fi
