__precompile__()

module MolecBio
using DataFrames
using CSV
using Statistics

molecbio = MolecBio
export molecbio


function make_output_path(file_path:: String, file_type:: String)
    
    ind = findlast(isequal('.'), file_path) -1 
    output_path = string(file_path[1:ind], "_processed"), file_type)
    return output_path
end


function load_table(file_path:: String)
    df = CSV.File(file_path) |> DataFrame
    return df
end


function calculate_ddct(df:: DataFrame, 
        control:: String,
        target:: String,
        normalizer:: String)  
    
    df[Symbol("delta_ct")] = df[Symbol(target)] - df[Symbol(normalizer)]
    
    avg_delta_ct_control = mean(df[df[:group] .== control,:delta_ct])
    df[Symbol("delta_delta_ct")] = df.delta_ct .- avg_delta_ct_control   
    
    f = (x) -> 2^(-x)
    df[Symbol("fold_change")] = f.(-df.delta_delta_ct)
    return df
end


function save_table(df:: DataFrame, output_path:: String)
    CSV.write(output_path, df)
end


end
