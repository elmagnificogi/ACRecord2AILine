"""Generate an independent physics overlay; original mod is read-only.

Default is SHADOW, preserves all original physical parameters.
Active forward-only bench build requires actual measured runtime calibration.
"""
from pathlib import Path
from vehicle_variants import hardware_scope
from ecu_levels import setup_controls
import argparse, hashlib, json, math, re, shutil
ROOT=Path(__file__).resolve().parent
SOURCE=ROOT.parent/'car'/'msk_stw_xiaomi_su7_ultra - 2.0'/'data'

def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest()
def rewrite_ini(path,updates):
    rows=path.read_text(encoding='utf-8-sig',errors='replace').splitlines()
    section=None;seen=set();result=[]
    for row in rows:
        m=re.match(r'^\s*\[([^]]+)\]',row)
        if m: section=m[1]
        k=re.match(r'^\s*([A-Za-z0-9_]+)\s*=',row)
        pair=(section,k[1]) if k else None
        if pair in updates:
            result.append(k[1]+'='+str(updates[pair]));seen.add(pair)
        else:result.append(row)
    missing=set(updates)-seen
    if missing: raise ValueError(('INI key missing',path,missing))
    path.write_text('\n'.join(result)+'\n',encoding='utf-8')

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--active',action='store_true');ap.add_argument('--calibration',type=Path)
    args=ap.parse_args(); cal=None
    if args.active:
        if args.calibration is None:raise SystemExit('Active build requires measured --calibration JSON; default shadow build is ready.')
        cal=json.loads(args.calibration.read_text(encoding='utf-8-sig'))
        required=['verified','wheel_order_verified','body_basis_verified','wheel_heading_verified',
          'torque_unit_and_sign_verified','legacy_brakes_verified','driveline_isolation_verified']
        if any(cal.get(k) is not True for k in required):raise SystemExit('Missing measured runtime checks: '+', '.join(k for k in required if cal.get(k) is not True))
        for key in ['omegaSigns','torqueSigns']:
            if len(cal.get(key,[]))!=4 or any(x not in (-1,1) for x in cal[key]):raise SystemExit('Invalid '+key)
        if not .01<=float(cal.get('torqueUnitsPerNm',0))<=100:raise SystemExit('Invalid measured torque scale')
        if len(cal.get('radiiM',[]))!=4 or not all(.2<float(x)<.5 for x in cal['radiiM']):raise SystemExit('Invalid effective wheel radii')
    name='csp-active-bench' if args.active else 'csp-shadow'
    dest=ROOT/name/'data';dest.mkdir(parents=True,exist_ok=True)
    before={p.name:sha(p) for p in SOURCE.iterdir() if p.is_file()}
    for p in SOURCE.iterdir():
        if p.is_file():shutil.copy2(p,dest/p.name)
    shutil.copy2(SOURCE/'power.lut',dest/'su7_base_power.lut')
    shutil.copy2(SOURCE/'engine_map1.lut',dest/'su7_base_throttle_m1.lut')
    for module in ['su7_control.lua','su7_config.lua']:
        shutil.copy2(ROOT/module,dest/module)
    (dest/'script.lua').write_text((ROOT/'csp_adapter.lua').read_text(encoding='utf-8-sig'),encoding='utf-8')
    signs=cal['omegaSigns'] if cal else [1,1,1,1]
    torque_signs=cal['torqueSigns'] if cal else [1,1,1,1]
    scale=cal['torqueUnitsPerNm'] if cal else 1
    runtime='return {active=%s,calibrated=%s,nativeTC=false,defaultMode=0,defaultESC=4,defaultTC=8,defaultTVC=0,omegaSigns={%s},torqueSigns={%s},torqueUnitsPerNm=%s}\n'%(
      str(args.active).lower(),str(args.active).lower(),','.join(map(str,signs)),','.join(map(str,torque_signs)),scale)
    (dest/'su7_runtime.lua').write_text(runtime,encoding='utf-8')
    if args.active:
        config=(dest/'su7_config.lua').read_text(encoding='utf-8')
        radii=','.join(str(float(x)) for x in cal['radiiM'])
        config=re.sub(r'radii=\{[^}]+\}', 'radii={'+radii+'}',config,count=1)
        (dest/'su7_config.lua').write_text(config,encoding='utf-8')
        (dest/'su7_zero_power.lut').write_text('0|0\n30000|0\n',encoding='utf-8')
        rewrite_ini(dest/'engine.ini',{('HEADER','POWER_CURVE'):'su7_zero_power.lut',('COAST_REF','TORQUE'):0,
          ('COAST_DATA','COAST0'):0,('COAST_DATA','COAST1'):0,('COAST_DATA','COAST'):0})
        diff={('CLUTCH','MAX_TORQUE'):0,('DIFFERENTIAL','POWER'):0,('DIFFERENTIAL','COAST'):0,('DIFFERENTIAL','PRELOAD'):0}
        for ax in ['FRONT','CENTRE','REAR']:
            for k in ['POWER','COAST','PRELOAD']:diff[('AWD',ax+'_DIFF_'+k)]=0
        rewrite_ini(dest/'drivetrain.ini',diff)
        old_controller=dest/'ctrl_single_lock.ini'
        if old_controller.exists():
            (dest/'ctrl_single_lock.original-disabled.txt').write_bytes(old_controller.read_bytes())
            old_controller.unlink()
        elec={}
        for sec in ['TRACTION_CONTROL','EDL','ABS']:
            elec[(sec,'PRESENT')]=0;elec[(sec,'ACTIVE')]=0
        rewrite_ini(dest/'electronics.ini',elec)
    setup=(dest/'setup.ini').read_text(encoding='utf-8-sig')
    setup+=setup_controls(active=args.active)
    (dest/'setup.ini').write_text(setup,encoding='utf-8')
    after={p.name:sha(p) for p in SOURCE.iterdir() if p.is_file()}
    if before!=after:raise AssertionError('Original mod source changed during build')
    report={'hardwareScope':hardware_scope('source_mod'), 'mode':name,'actuation':args.active,'targetCSP':'0.2.11 API verified, actual runtime still needs validation',
      'originalSourceSHA256':before,'originalUnchanged':True,
      'files':{p.name:sha(p) for p in dest.iterdir() if p.is_file()},
      'scope':'physics overlay only; no KN5, audio, skins or installed game modifications',
      'limitations':['Active bench is forward-only; reverse electric driving is not implemented',
        'Mechanical drivetrain isolation must be verified in game',
        'Unknown OEM gains, motor maps, ratios and efficiencies remain assumptions']}
    (dest.parent/'manifest.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
    print(json.dumps({'output':str(dest),'mode':name,'originalUnchanged':True,'files':len(report['files'])}))
if __name__=='__main__': main()
