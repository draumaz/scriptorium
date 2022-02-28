# iPod sync tool (rsync, bash)
# draumaz, 2022 | GPL v3

## BEGIN CONFIG ##

LOCAL_MUSIC_FOLDER_PREFIX="" # e.g. /media/Storage/Music/
DESTINATION_MUSIC_FOLDER="" # e.g. /home/gungo/iPod/Music
DESTINATION_MOUNT_POINT="" # e.g. /home/gungo/iPod
DESTINATION_MOUNT_DRIVE="" # e.g. /dev/sda2

## END CONFIG ##

RSYNC_ARGUMENTS="--recursive --update --verbose --checksum --delete"

elev_chk() {
	if [ "$(id -u)" == "1000" ]; then 
		if [ -f /usr/bin/doas ]; then
			SU="doas"
		else
			SU="sudo"
		fi
	else 
		SU=""
	fi
}

su_att() {
	"$SU" false # init superuser access thru persist
}

dev_mnt() {
	if [ "$(ls $DESTINATION_MOUNT_POINT)" == "" ]; then
		echo -n "connect your iPod and hit enter to mount. "; read i
		if "$SU" mount $DESTINATION_MOUNT_DRIVE "$DESTINATION_MOUNT_POINT" > /dev/null 2>&1; then
			echo "mounted iPod."
		else
			echo "couldn't mount iPod."
			exit
		fi
	fi
}

rs_put() {
	echo ""
	"$SU" rsync $RSYNC_ARGUMENTS "$LOCAL_MUSIC_FOLDER_PREFIX" "$DESTINATION_MUSIC_FOLDER"
	echo ""
}

fs_post() {
	echo -n "syncing..."
	if sync; then echo " done"; else echo " fail"; fi
	echo ""
}

dev_umnt() {
	echo -n "unmount iPod? (y/n): "; read i
	if [ "$i" == "y" ] || [ "$i" == "Y" ]; then
		"$SU" umount "$DESTINATION_MOUNT_POINT"
		echo "unmounted. remember to update your rockbox database."
	fi
}

elev_chk
su_att
dev_mnt
rs_put
fs_post
dev_umnt
