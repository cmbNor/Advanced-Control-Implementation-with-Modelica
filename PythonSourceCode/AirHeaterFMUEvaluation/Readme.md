# PythonMPC
 
The FMU is imported with the use of CATIA-Systems/FMPy (https://github.com/CATIA-Systems/FMPy)

Install files:

Install with conda: 
```
conda install -c conda-forge fmpy
```

Install with from PyPI: 
```
python -m pip install fmpy[complete]
```

### < GUI >

Start graphical user interface in command with:
```
python -m fmpy.gui
```

### < Python prompt >

Get FMU information: 
```
dump(fmu-Name)
```

Simulate model: 
```
result = simulate_fmu(fmu-Name)
```

Add plot function: 
```
from fmpy.util import plot_result
```

Plot results: 
```
plot_results(results)
```

### < Jupyter Notebook >

Open an FMU in the GUI and choose Tools -> create Jupyter Notebook..

Open notebook with: 
```
jupyter notebook fmu-Name.ipynb
```
