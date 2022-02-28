# Draumaz's Epic Layout Switcher
# Switch between two keymaps on raw Xorg


## BEGIN CONFIG ##
PRIMARY_KEYMAP="" # e.g. us
SECONDARY_KEYMAP="" # e.g. ge
## END CONFIG ##

FILE="/tmp/delc.conf" # generate file to monitor layout
touch $FILE

if [ "$(cat $FILE)" == "" ]; then
	echo 0 > $FILE
	echo "initialized file at $FILE."
	echo "please re-run the script."
	exit
fi

VAR=$(cat $FILE)

if [ "$VAR" == "1" ]; then # I imagine this could be pretty easily
	setxkbmap $PRIMARY_KEYMAP # expanded into a carousel, but I only
	echo 0 > $FILE			    # needed two keymaps.
	echo "switched to primary keymap."
else if [ "$VAR" == "0" ]; then
	setxkbmap $SECONDARY_KEYMAP
	echo 1 > $FILE
	echo "switched to secondary keymap."
fi fi