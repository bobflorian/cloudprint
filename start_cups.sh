#!/bin/sh
set -e
set -x

#if [ $(grep -ci $CUPS_USER_ADMIN /etc/shadow) -eq 0 ]; then
#    useradd $CUPS_USER_ADMIN --system -G root,lpadmin --no-create-home --password $(mkpasswd $CUPS_USER_PASSWORD)
#fi

if [ -d "/var/spool/cups-pdf/REVEAL/$AWSFOLDER" ]
then
  echo "Directory /var/spool/cups-pdf/REVEAL/$AWSFOLDER exists."
else
  mkdir /var/spool/cups-pdf/REVEAL/$AWSFOLDER
  chown nobody:nogroup /var/spool/cups-pdf/REVEAL/$AWSFOLDER
fi

# concat AnonDirName to end of conf file
echo "AnonDirName /var/spool/cups-pdf/REVEAL/$AWSFOLDER" >> /etc/cups/cups-pdf.conf

# start CUPS
exec /usr/sbin/cupsd -f
