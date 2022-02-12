export PATCH_URL="https://raw.githubusercontent.com/draumaz/patches/main/mpv_sponsorblock"
export PO5_SB_URL="https://github.com/po5/mpv_sponsorblock"

mkdir -pv $HOME/.config/mpv/scripts
echo "Moving into $HOME/.config/mpv/scripts" && cd $HOME/.config/mpv/scripts;
git clone $PO5_SB_URL
mv -v mpv_sponsorblock/sponsorblock.lua ./sponsorblock.lua
mv -v mpv_sponsorblock/sponsorblock_shared .
rm -rf mpv_sponsorblock
patch sponsorblock.lua <(curl $PATCH_URL/sponsorblock.lua.patch)
patch sponsorblock_shared/sponsorblock.py <(curl $PATCH_URL/sponsorblock_shared/sponsorblock.py.patch)
rm -rfv sponsorblock.lua.patch sponsorblock.py.patch LICENSE README.md
