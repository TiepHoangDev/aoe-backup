# AoE Rise of Rome trên Linux (Wine + cnc-ddraw)

- `aoe.sh`: launcher (WINEPREFIX=~/Games/AOE-wine-prefix, cnc-ddraw). Chép vào ~/Games/.
- `aoe.desktop`: chép vào ~/.local/share/applications/.
- `patch_empiresx.py`: pop limit chơi đơn 100, Random Map mặc định Hill Country + 2 người.
  `python3 patch_empiresx.py ~/Games/AOE/Empiresx.exe 100`

Wine prefix không lưu: tự tạo lại khi chạy aoe.sh lần đầu.
