#!/bin/bash
DKIMPATH=/etc/opendkim
KEYSPATH=$DKIMPATH/keys
DOMAINKEYSPATH=$KEYSPATH/$1

TRUSTEDHOSTSFILE=$DKIMPATH/TrustedHosts
KEYTABLEFILE=$DKIMPATH/KeyTable
SIGNTABLEFILE=$DKIMPATH/SigningTable
PRIVATEKEYFILE=$DOMAINKEYSPATH/mail.private
PUBLICKEYFILE=$DOMAINKEYSPATH/mail.txt
TMPFILE=`tempfile`

if [ ! "$1" ]
then
	echo "Usage: $0 <DOMAIN>"
	exit 1
fi

if [ -e $DOMAINKEYSPATH ]
then
	# Delete key table entry if it exists
	KEYENTRY="mail._domainkey.$1 $1:mail:$PRIVATEKEYFILE"
	if grep -Fxq "$KEYENTRY" "$KEYTABLEFILE"
	then
		grep -v "$KEYENTRY" "$KEYTABLEFILE" > "$TMPFILE"
		cat "$TMPFILE" > "$KEYTABLEFILE"
	fi

	# Delete trusted host table entry if it exists
	TRUSTEDHOSTENTRY="*.$1"
	if grep -Fxq "$TRUSTEDHOSTENTRY" "$TRUSTEDHOSTSFILE"
	then
		grep -v "$TRUSTEDHOSTENTRY" "$TRUSTEDHOSTSFILE" > "$TMPFILE"
		cat "$TMPFILE" > "$TRUSTEDHOSTSFILE"
	fi

	# Delete sign table entry if it exists
	SIGNTABLEENTRY="*@$1 mail.domainkey.$1"
	if grep -Fxq "$SIGNTABLEENTRY" "$SIGNTABLEFILE"
	then
		echo "$SIGNTABLEENTRY" >> "$SIGNTABLEFILE"
		grep -v "$SIGNTABLEENTRY" "$SIGNTABLEFILE" > "$TMPFILE"
		cat "$TMPFILE" > "$SIGNTABLEFILE"

	fi

	if [ -e "$DOMAINKEYSPATH" ]
	then
		rm $PRIVATEKEYFILE
		rm $PUBLICKEYFILE
        rm -r "$DOMAINKEYSPATH"
	fi
else
	echo "No Entry for Domain $1 found. Exiting..."
	exit 1
fi
