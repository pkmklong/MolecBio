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
│ 11  │ trt_a   │ 25.194  │ 17.9    │ 7.294    │ -1.2725        │ 0.413942    │
│ 12  │ trt_a   │ 25.398  │ 17.3    │ 8.098    │ -0.4685        │ 0.722716    │
│ 13  │ trt_a   │ 24.3    │ 17.4    │ 6.9      │ -1.6665        │ 0.315017    │
│ 14  │ trt_a   │ 24.5    │ 17.3    │ 7.2      │ -1.3665        │ 0.387831    │
│ 15  │ trt_a   │ 24.7    │ 17.9    │ 6.8      │ -1.7665        │ 0.293921    │
│ 16  │ trt_a   │ 24.9    │ 17.3    │ 7.6      │ -0.9665        │ 0.511746    │
│ 17  │ trt_a   │ 24.99   │ 17.3    │ 7.69     │ -0.8765        │ 0.544687    │
│ 18  │ trt_a   │ 24.786  │ 17.4    │ 7.386    │ -1.1805        │ 0.441199    │
│ 19  │ trt_b   │ 25.9498 │ 17.9895 │ 7.96032  │ -0.60618       │ 0.656934    │
│ 20  │ trt_b   │ 26.1599 │ 17.3865 │ 8.77344  │ 0.20694        │ 1.15424     │
│ 21  │ trt_b   │ 25.029  │ 17.487  │ 7.542    │ -1.0245        │ 0.491581    │
│ 22  │ trt_b   │ 25.235  │ 17.3865 │ 7.8485   │ -0.718         │ 0.60794     │
│ 23  │ trt_b   │ 25.441  │ 17.9895 │ 7.4515   │ -1.115         │ 0.461691    │
│ 24  │ trt_b   │ 25.647  │ 17.3865 │ 8.2605   │ -0.306         │ 0.808881    │
│ 25  │ trt_b   │ 25.7397 │ 17.3865 │ 8.3532   │ -0.2133        │ 0.862562    │
│ 26  │ trt_b   │ 25.5296 │ 17.487  │ 8.04258  │ -0.52392       │ 0.69548     │
```
