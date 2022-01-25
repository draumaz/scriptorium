# draumaz/deplo
# Backup critical files for a Gentoo install
# GPL-3

# deps: tar date (g)sed

# COMPRESSION environment variable sets tar output.
# $ COMPRESSION=xz sh deplo.sh -qk

export version="1.2"

export RED="\e[1;31m"
export WHITE="\033[0m"

## CONFIG BEGIN ~ Verify that these are valid for your system.
export kernel_config_pth="/usr/src/linux/.config"
export make_conf_pth="/etc/portage/make.conf"
export package_use_pth="/etc/portage/package.use"
export i3_config_pth="$HOME/.config/i3/config"
export i3_status_config_pth="$HOME/.config/i3status/config"
export bashrc_pth="$HOME/.bashrc"
## CONFIG END

if [ "${1:1:1}" == "h" ]; then
	echo "usage: deplo [--quiet | -q] [--keep | -k] [ --no-build | -n ]"
	echo -e "\n   deplo            collect vital Gentoo dotfiles and archive"
	echo -e "\n   deplo --keep     don't delete copied files after making tarball"
	echo -e "\n   deplo --quiet    silence all non-critical output"
	echo -e "\n   deplo --no-build  only retrieve files, don't make tarball"
	echo -e "\n   deplo --version  show current version number of deplo"
	echo -e "\n   deplo --help     you are here!\n"
	exit
else if [ "${1:1:1}" == "v" ]; then
	echo $version
	exit
fi fi

if [ "${1:2}" == "quiet" ] || [ "${2:2}" == "quiet" ] || [ "${3:2}" == "quiet" ] || \
   [ "${1:1:1}" == "q" ] || [ "${1:2:1}" == "q" ] || [ "${1:3:1}" == "q" ] || \
   [ "${2:1:1}" == "q" ] || [ "${2:2:1}" == "q" ] || [ "${2:3:1}" == "q" ] || \
   [ "${3:1:1}" == "q" ] || [ "${3:2:1}" == "q" ] || [ "${3:3:1}" == "q" ]; then
	export copcom=""
	export copcom2=""
	export mkcom="-p"
	export tarcom="-cf"
	export remcom="-r"
else
	export copcom="-v"
	export copcom2="-rv"
	export mkcom="-pv"
	export tarcom="cvf"
	export remcom="-rv"
fi

export kern="kernel_config-$(uname -r)_$(date -I)_$(date +%T | sed 's/:/-/g')"
echo -e "${RED}> Compiling files${WHITE}"
mkdir $mkcom portage dotfiles
cp $copcom2 $package_use_pth portage/
comp_one+=("${make_conf_pth}" "${kernel_config_pth}" "${i3_config_pth}" \
	"${i3_status_config_pth}" "${bashrc_pth}")
comp_two+=("portage/make.conf" "dotfiles/${kern}" "dotfiles/i3-config" "dotfiles/i3status-conf" "dotfiles/bashrc")
for i in {0..4}; do cp $copcom "${comp_one[i]}" ./"${comp_two[i]}"; done

if [ "${1:2}" == "no-build" ] || [ "${2:2}" == "no-build" ] || [ "${3:2}" == "no-build" ] || \
   [ "${1:1:1}" == "n" ] || [ "${1:2:1}" == "n" ] || [ "${1:3:1}" == "n" ] || \
   [ "${2:1:1}" == "n" ] || [ "${2:2:1}" == "n" ] || [ "${2:3:1}" == "n" ] || \
   [ "${3:1:1}" == "n" ] || [ "${3:2:1}" == "n" ] || [ "${3:3:1}" == "n" ]; then
	exit
fi

if [ "$COMPRESSION" == "" ]; then export COMPRESSION="gz"; fi
export tar_out="deplo-$(date -I).tar.${COMPRESSION}"

echo -e "${RED}> Creating $tar_out${WHITE}"
tar $tarcom ./$tar_out dotfiles/ portage/ deplo.sh

if [ "${1:2}" == "keep" ] || [ "${2:2}" == "keep" ] || [ "${3:2}" == "keep" ] || \
   [ "${1:1:1}" == "k" ] || [ "${1:2:1}" == "k" ] || [ "${1:3:1}" == "k" ] || \
   [ "${2:1:1}" == "k" ] || [ "${2:2:1}" == "k" ] || [ "${2:3:1}" == "k" ] || \
   [ "${3:1:1}" == "k" ] || [ "${3:2:1}" == "k" ] || [ "${3:3:1}" == "k" ]; then
	exit
else
	echo -e "${RED}> Cleaning local directory${WHITE}"
	rm $remcom ./portage
	rm $remcom ./dotfiles
fi
