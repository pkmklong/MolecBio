# MolecBio (WIP)
A quick and simple Julia utility to automate delta delta ct [relative quantification of mRNA](https://en.wikipedia.org/wiki/Real-time_polymerase_chain_reaction) from thermocycler ct data. Assumes perfect amplification efficiency and unpaired samples.


<b>Installation</b>
```julia
using Pkg

pkg"add https://github.com/pkmklong/MolecBio.git"
```

<b>Entry point</b>
```julia
julia runner.jl --h
usage: runner.jl -f FILE_PATH -c CONTROL -t TARGET -n NORMALIZER [-h]

optional arguments:
  -f, --file_path FILE_PATH
                        The path to raw ct data (csv) for relative RNA
                        quantification
  -c, --control CONTROL
                        The name of your control group (default:
                        "control")
  -t, --target TARGET   The name of your target transcript
  -n, --normalizer NORMALIZER
                        The name of your normalizing reference
                        transcript
  -h, --help            show this help message and exit
```

<b>Demo</b>
```julia
julia src/runner.jl -f data/demo_data.csv -c "control" -t "egf1r" -n "rpl19" 

│ Row │ group   │ egf1r   │ rpl19   │ delta_ct │ delta_delta_ct │ fold_change │
│     │ String  │ Float64 │ Float64 │ Float64  │ Float64        │ Float64     │
├─────┼─────────┼─────────┼─────────┼──────────┼────────────────┼─────────────┤
│ 1   │ control │ 25.6    │ 17.5    │ 8.1      │ -0.4665        │ 0.723718    │
│ 2   │ control │ 25.8    │ 16.9    │ 8.9      │ 0.3335         │ 1.26007     │
│ 3   │ control │ 26.0    │ 17.4    │ 8.6      │ 0.0335         │ 1.02349     │
│ 4   │ control │ 25.4    │ 17.7    │ 7.7      │ -0.8665        │ 0.548476    │
│ 5   │ control │ 25.45   │ 17.2    │ 8.25     │ -0.3165        │ 0.803016    │
│ 6   │ control │ 25.959  │ 17.2    │ 8.759    │ 0.1925         │ 1.14274     │
│ 7   │ control │ 25.908  │ 17.7    │ 8.208    │ -0.3585        │ 0.779975    │
│ 8   │ control │ 26.112  │ 17.5    │ 8.612    │ 0.0455         │ 1.03204     │
│ 9   │ control │ 26.316  │ 16.9    │ 9.416    │ 0.8495         │ 1.80188     │
│ 10  │ control │ 26.52   │ 17.4    │ 9.12     │ 0.5535         │ 1.46764     │
```
