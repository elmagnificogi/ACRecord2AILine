"""Extract evidence from a locally obtained official CSP 0.2.11 SDK.

SDK/documentation snapshots are local audit inputs, excluded from Git.
Acquire the official archive noted in references/csp-api-source-manifest.json
and place ac_car_cphys-lib.lua at the versioned reference path before running.
"""
from pathlib import Path
import json,hashlib
base=Path(__file__).resolve().parent
refs=base/'references'
source=refs/'csp-0.2.11-ac_car_cphys-lib.lua'
lines=source.read_text(encoding='utf-8-sig').splitlines()
ranges=[(146,167),(3771,3830),(3880,3910),(4117,4170),(8431,8490),(8506,8526),(8545,8550),(8696,8740),(9043,9142),(9156,9184)]
text=['-- Official CSP 0.2.11 generated physics SDK excerpts.','-- Original line numbers refer to csp-0.2.11-ac_car_cphys-lib.lua.','-- Source archive: https://acstuff.club/patch/?get=0.2.11','-- Definitions are documentation stubs; do NOT require this file as runtime code.']
for lo,hi in ranges:
    text.append(f'\n-- ORIGINAL LINES {lo}-{hi}')
    text.extend(lines[lo-1:hi])
(refs/'csp-0.2.11-physics-api-excerpts.lua').write_text('\n'.join(text)+'\n',encoding='utf-8')
items=[]
for path in refs.iterdir():
    if path.is_file(): items.append(dict(file=path.name,bytes=path.stat().st_size,sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
manifest=dict(checked_date='2026-10-09',release='0.2.11',download='https://acstuff.club/patch/?get=0.2.11',github_sources=['https://github.com/ac-custom-shaders-patch/acc-lua-sdk/blob/main/ac_car_cphys.lua','https://github.com/ac-custom-shaders-patch/acc-lua-sdk/blob/main/common/ac_car_cphys_enums.lua','https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Physics-scripts'],local_runtime='No Assetto Corsa/CSP found in registered E:/Steam or D:/SteamLibrary; installed version unknown.',files=items)
(refs/'csp-api-source-manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2),encoding='utf-8')
(base/'_downloads'/'.gitignore').write_text('*\n!.gitignore\n',encoding='utf-8')
print('Saved excerpts and provenance')
