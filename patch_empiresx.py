#!/usr/bin/env python3
"""Patch Age of Empires: Rise of Rome Empiresx.exe (bản trong thư mục AOE).
- Giới hạn quân chơi đơn: 50 -> POP (mặc định 100, tối đa 255)
- Random Map chơi đơn: Map Type mặc định Hill Country, 2 người chơi
Dùng: python3 patch_empiresx.py path/to/Empiresx.exe [POP]
"""
import os, sys
p = sys.argv[1]; pop = int(sys.argv[2]) if len(sys.argv) > 2 else 100
assert 25 <= pop <= 255
b = bytearray(open(p, 'rb').read())
patches = [
    (0x106f84, ['b032', 'b0'], 'b0' + f'{pop:02x}'),          # mov al, 50 -> mov al, POP
    (0x897f9, ['e822e0090099b9', 'b807000000eb58'], 'b807000000eb58'),  # map type = 7
    (0x89877, ['6a04', '6a02'], '6a02'),                       # 4 -> 2 players
]
for off, ok, new in patches:
    cur = b[off:off + len(bytes.fromhex(new))].hex()
    assert any(cur.startswith(o) for o in ok), f'bytes lạ ở {off:#x}: {cur}'
    b[off:off + len(bytes.fromhex(new))] = bytes.fromhex(new)
open(p + '.new', 'wb').write(b); os.chmod(p + '.new', 0o775); os.replace(p + '.new', p)
print('Đã patch', p)
