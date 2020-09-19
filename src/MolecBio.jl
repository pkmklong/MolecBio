__precompile__()


module MolecBio
using DataFrames
using CSV

molecbio = MolecBio
export molecbio



df = CSV.File(file_path) |> DataFrame


function make_output_path()
end

function load_table(file_path:: string)
    df = CSV.File(file_path) |> DataFrame
    return df
end


function calculate_ddct(df)
    
        df[Symbol("delta_ct"] = df[:target] - df[:normalizer]

        avg_delta_ct_control = df[df[:group .== :control],:delta_ct.mean()

        df["delta_delta_ct"] = df.delta_ct - avg_delta_ct_control

        df["fold_change"] = 2 ** (-df.delta_delta_ct)
    end

function save_table()
    end
