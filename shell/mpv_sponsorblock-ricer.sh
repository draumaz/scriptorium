export lua_pf="https://raw.githubusercontent.com/draumaz/patches/main/mpv_sponsorblock/sponsorblock.lua.patch"
export py_pf="https://raw.githubusercontent.com/draumaz/patches/main/mpv_sponsorblock/sponsorblock_shared/sponsorblock.py.patch"
export sb_url="https://github.com/po5/mpv_sponsorblock"

mkdir -pv $HOME/.config/mpv/scripts
echo "Moving into $HOME/.config/mpv/scripts" && cd $HOME/.config/mpv/scripts;
git clone $sb_url
mv -v mpv_sponsorblock/sponsorblock.lua ./sponsorblock.lua
mv -v mpv_sponsorblock/sponsorblock_shared .
rm -rf mpv_sponsorblock
patch sponsorblock.lua <(curl $lua_pf)
patch sponsorblock_shared/sponsorblock.py <(curl $py_pf)
rm -rfv sponsorblock.lua.patch sponsorblock.py.patch LICENSE README.md
