__precompile__()


module MolecBio
using DataFrames
using CSV

molecbio = MolecBio
export molecbio



df = CSV.File(file_path) |> DataFrame


function make_output_path()
    end

function load_table()
    end

function calculate_ddct()
    end

function save_table()
    end
