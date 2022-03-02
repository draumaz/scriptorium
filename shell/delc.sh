# Draumaz's Epic Layout Switcher
# Switch between two keymaps on raw Xorg

## BEGIN CONFIG ##

PRIMARY_KEYMAP="" # e.g. us
SECONDARY_KEYMAP="" # e.g. ge

## END   CONFIG ##

if [ "$PRIMARY_KEYMAP" == "" ]; then
	echo "missing primary keymap config"
	CFG_CHK=1
fi; if [ "$SECONDARY_KEYMAP" == "" ]; then
	echo "missing secondary keymap config"
	CFG_CHK=1
fi; if [ "$CFG_CHK" == "1" ]; then exit; fi

FILE="/tmp/delc.conf" # generate file to monitor layout
touch $FILE

if [ "$(cat $FILE)" == "" ]; then
	echo 0 > $FILE
	echo "initialized file at $FILE."
	echo "please re-run the script."
	exit
fi

VAR=$(cat $FILE)

if [ "$VAR" == "1" ]; then
	setxkbmap $PRIMARY_KEYMAP
	echo 0 > $FILE
	echo "switched to primary keymap ($PRIMARY_KEYMAP)."
else if [ "$VAR" == "0" ]; then
	setxkbmap $SECONDARY_KEYMAP
	echo 1 > $FILE
	echo "switched to secondary keymap ($SECONDARY_KEYMAP)."
fi fi
