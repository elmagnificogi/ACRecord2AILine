"""Unpack read-only ACD copy into a separate audit directory.
Layout / key source verified against gro-ove/actools AcdReader.cs and AcdEncryption.cs.
Key arithmetic uses the inspected GPL-2.0 acd.py module, bundled with license:
https://github.com/philippkosarev/acd.py
"""
from pathlib import Path
import json, hashlib
import acd_reader_vendor as acd
base=Path(__file__).resolve().parent
source=base.parent/'car'/'negi_su7_ultra_prototype'/'data.acd'
out=base/'prototype-data'
key=acd.get_encryption_key(str(source))
original_hash=hashlib.sha256(source.read_bytes()).hexdigest()
entries=acd.read_file(str(source))
# Reject malformed plaintext before creating data files.
for required in ('car.ini','suspensions.ini','tyres.ini','aero.ini'):
    value=entries[required]
    if b'[' not in value[:300] or b'=' not in value[:600]:
        raise ValueError('Wrong ACD key or unreadable plaintext: '+required)
out.mkdir(exist_ok=True)
manifest=[]
for name,data in entries.items():
    target=(out/name).resolve()
    if not target.is_relative_to(out.resolve()): raise ValueError('Invalid archive entry path')
    target.parent.mkdir(parents=True,exist_ok=True)
    target.write_bytes(data)
    manifest.append(dict(name=name,bytes=len(data),sha256=hashlib.sha256(data).hexdigest()))
assert hashlib.sha256(source.read_bytes()).hexdigest()==original_hash
info=dict(source=str(source),key_source=source.parent.name,key=key.decode('ascii'),source_sha256=original_hash,count=len(entries),entries=manifest)
(base/'prototype_acd_manifest.json').write_text(json.dumps(info,indent=2),encoding='utf-8')
print(json.dumps(info,indent=2))
