export lua_pf="https://raw.githubusercontent.com/draumaz/patches/main/mpv_sponsorblock/sponsorblock.lua.patch"
export py_pf="https://raw.githubusercontent.com/draumaz/patches/main/mpv_sponsorblock/sponsorblock_shared/sponsorblock.py.patch"
export sb_url="https://github.com/po5/mpv_sponsorblock"
export wget_args="--quiet --show-progress"

mkdir -pv $HOME/.config/mpv/scripts
echo "Moving into $HOME/.config/mpv/scripts" && cd $HOME/.config/mpv/scripts;
git clone $sb_url
mv -v mpv_sponsorblock/sponsorblock.lua ./sponsorblock.lua | sed 's/renamed //g'
mv -v mpv_sponsorblock/sponsorblock_shared . | sed 's/renamed //g'
rm -rf mpv_sponsorblock
wget $wget_args $lua_pf
wget $wget_args $py_pf
patch sponsorblock.lua < sponsorblock.lua.patch
patch sponsorblock_shared/sponsorblock.py < sponsorblock.py.patch
rm -rfv sponsorblock.lua.patch sponsorblock.py.patch LICENSE README.md
