[![Documentation Status](https://readthedocs.org/projects/docs/badge/?version=latest)](https://molecbio.readthedocs.io/en/latest/) Check out the [MolecBio documentation on ReadTheDocs](https://molecbio.readthedocs.io/en/latest/).
[![<ORG_NAME>](https://circleci.com/gh/pkmklong/MolecBio.svg?style=shield)](https://github.com/pkmklong/MolecBio/blob/master/.circleci/config.yml)

# MolecBio (WIP)
A simple Julia utility to automate delta delta ct [relative quantification of mRNA](https://en.wikipedia.org/wiki/Real-time_polymerase_chain_reaction) from thermocycler ct data. Assumes perfect amplification efficiency and unpaired samples.


<b>Installation</b>
```julia
using Pkg

pkg"add https://github.com/pkmklong/MolecBio.git"
```

<b>Entry point</b>
```julia
$ julia runner.jl --h
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

<b>Input data dictionary</b>
```
{column:                            type      description}
"group":                            String    Names of comparison groups
user defined target column:         Float64   ct values of target transcript
user defined normalizing column:    Float64   ct values of normalizing reference transcript
```

<b>Fold change</b>

<img src="https://github.com/pkmklong/molecbio/blob/master/images/ddct.svg" height="250"  class="center" title="delta delta CT">


<b>Demo</b>
```julia
$ julia src/runner.jl -f "data/demo_data.csv" -c "control" -t "egf1r" -n "rpl19" 
Parsed args:
  normalizer  =>  rpl19
  target  =>  egf1r
  control  =>  control
  file_path  =>  data/demo_data.csv
┌ Info: Loading CT values table
└   args["file_path"] = "data/demo_data.csv"
┌ Info: Computing fold change with delta delta ct
│   first(ddct_table, 5) =
│    5×6 DataFrame
│    │ Row │ group   │ egf1r   │ rpl19   │ delta_ct │ delta_delta_ct │ fold_change │
│    │     │ String  │ Float64 │ Float64 │ Float64  │ Float64        │ Float64     │
│    ├─────┼─────────┼─────────┼─────────┼──────────┼────────────────┼─────────────┤
│    │ 1   │ control │ 25.6    │ 17.5    │ -8.1     │ 0.4665         │ 1.38175     │
│    │ 2   │ control │ 25.8    │ 16.9    │ -8.9     │ -0.3335        │ 0.793609    │
│    │ 3   │ control │ 26.0    │ 17.4    │ -8.6     │ -0.0335        │ 0.977047    │
│    │ 4   │ control │ 25.4    │ 17.7    │ -7.7     │ 0.8665         │ 1.82323     │
└    │ 5   │ control │ 25.45   │ 17.2    │ -8.25    │ 0.3165         │ 1.24531     │
┌ Info: Saving output table to 
└   ddct_table_path = "data/demo_data_processed.csv"
┌ Info: Saving output figure to 
└   ddct_figure_path = "data/demo_data_processed.svg"

```
<b>Visuals</b>

<img src="https://github.com/pkmklong/molecbio/blob/master/images/demo_data_processed.svg" height="400"  class="center" title="Demo visualization">


TODO: 
* add feature to flag normalizer gene outliers (> 2 SD from mean) in ddct table
* produce visuals +/- outliers
* add a normality test
* generate outputs expressed as % change and run two-sided t-test
* generate outputs expressed as % change and run nonparametric two sample test
* add yaml based entrypoint
* unit tests and code coverage
* circleci for CI
