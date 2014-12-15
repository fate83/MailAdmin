#!/bin/bash
DKIMPATH=/etc/opendkim
KEYSPATH=$DKIMPATH/keys
DOMAINKEYSPATH=$KEYSPATH/$1

TRUSTEDHOSTSFILE=$DKIMPATH/TrustedHosts
KEYTABLEFILE=$DKIMPATH/KeyTable
SIGNTABLEFILE=$DKIMPATH/SigningTable
PRIVATEKEYFILE=$DOMAINKEYSPATH/mail.private
PUBLICKEYFILE=$DOMAINKEYSPATH/mail.txt

if [ ! "$1" ]
then
	echo "Usage: $0 <DOMAIN>"
	exit 1
fi

if [ ! -e $DOMAINKEYSPATH ]
then
	mkdir -p $DOMAINKEYSPATH

	if [ ! -e "$TRUSTEDHOSTSFILE" ]; then touch "$TRUSTEDHOSTSFILE"; fi
	if [ ! -e "$KEYTABLEFILE" ]; then touch "$KEYTABLEFILE"; fi
	if [ ! -e "$SIGNTABLEFILE" ]; then touch "$SIGNTABLEFILE"; fi

	# Generate key table entry
	KEYENTRY="mail._domainkey.$1 $1:mail:$PRIVATEKEYFILE"
	if ! grep -Fxq "$KEYENTRY" "$KEYTABLEFILE"
	then
		echo "$KEYENTRY" >> "$KEYTABLEFILE"
	fi

	# Generate trusted host table entry
	TRUSTEDHOSTENTRY="*.$1"
	if ! grep -Fxq "$TRUSTEDHOSTENTRY" "$TRUSTEDHOSTSFILE"
	then
		echo "$TRUSTEDHOSTENTRY" >> "$TRUSTEDHOSTSFILE"
	fi
	
	# Generate sign table entry
	SIGNTABLEENTRY="*@$1 mail.domainkey.$1"
	if ! grep -Fxq "$SIGNTABLEENTRY" "$SIGNTABLEFILE"
	then
		echo "$SIGNTABLEENTRY" >> "$SIGNTABLEFILE"
	fi

	if [ ! -e "$PRIVATEKEYFILE" ]
	then
		cd "$DOMAINKEYSPATH" && opendkim-genkey -s mail -d $1
		chown opendkim:opendkim "$PRIVATEKEYFILE"
		cat "$PUBLICKEYFILE"
	fi
else
	echo "Entry for Domain $1 does already exist. Exiting..."
	exit 1
fi
