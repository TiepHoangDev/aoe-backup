#!/bin/bash
# Age of Empires: Rise of Rome qua Wine + cnc-ddraw
GAME=~/Games/AOE
# Lần đầu: lấy thư mục game vừa chép từ VM (shared folder) sang
if [ ! -f "$GAME/Empiresx.exe" ]; then
  SRC=$(find ~/Games/from-vm -maxdepth 4 -iname Empiresx.exe -printf '%h\n' | head -1)
  [ -z "$SRC" ] && { notify-send "AoE" "Chưa thấy Empiresx.exe trong ~/Games/from-vm"; exit 1; }
  mkdir -p "$GAME" && cp -a "$SRC"/. "$GAME"/
fi
[ -f "$GAME/ddraw.dll" ] || cp -a ~/Games/cnc-ddraw/{ddraw.dll,ddraw.ini,Shaders} "$GAME"/
cd "$GAME"
export WINEPREFIX=~/Games/AOE-wine-prefix WINEDEBUG=-all WINEDLLOVERRIDES="ddraw=n,b"
# AOE_DESKTOP=1: chạy trong cửa sổ "desktop ảo" của Wine, game không bị mất focus khi click ra ngoài
if [ "$AOE_DESKTOP" = 1 ]; then
  RES=$(xrandr 2>/dev/null | awk '/\*/{print $1; exit}')
  exec wine explorer /desktop=AOE,${RES:-1920x1080} Empiresx.exe "$@"
fi
exec wine Empiresx.exe "$@"
