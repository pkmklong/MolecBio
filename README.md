# MolecBio
WIP: Julia utility for relative gene expression

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
```
