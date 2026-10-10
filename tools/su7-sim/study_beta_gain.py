import json
from pathlib import Path
import simulate as sim
root=Path(__file__).resolve().parent
original=sim.LuaController
case=next(s for s in sim.SCENARIOS if s.name=='low_mu_exit')
rows=[]
for gain in [7000,20000,40000,60000]:
    class Trial(original):
        def __init__(self,*a,**kw):
            super().__init__(*a,**kw);self.config['betaGain']=gain
    sim.LuaController=Trial
    result=sim.run_scenario(case,'experimental')
    row={'betaGain':gain,**result['metrics']};rows.append(row)
    print(json.dumps(row),flush=True)
(root/'outputs'/'beta-gain-study.json').write_text(json.dumps({'scope':'Hypothetical low-mu plant only, not measured Xiaomi gains','rows':rows},indent=2),encoding='utf-8')
