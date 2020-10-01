__precompile__()

module MolecBio
using DataFrames
using CSV
using Statistics
using Gadfly

molecbio = MolecBio
export molecbio


function make_output_path(file_path:: String, file_type:: String)   
    ind = findlast(isequal('.'), file_path) -1 
    output_path = string(file_path[1:ind], "_processed", file_type)
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


function calculate_percent_expression(df:: DataFrame, control:: String)
    
    f = (x) -> 2^(-x)
    df[Symbol("expression")] = f.(-df.delta_ct)
    df[Symbol("average_expression")] = mean(df[df[:group] .== control,:expression])
    df[Symbol("percent_expression")] = (df.expression ./ df.average_expression) .* 100
    return df
end


function save_table(df:: DataFrame, output_path:: String)
    CSV.write(output_path, df)
end


function plot_fold_change(df:: DataFrame, 
        normalizer:: String, 
        output_path:: String)  
    fold = plot(
        df, x="group", y="fold_change", 
        Geom.boxplot,
        Guide.title("Fold Change in Target Expression")
    )
    expression = plot(
        df, x="group", y="percent_expression", 
        Geom.boxplot,
        Guide.title("Percent Change in Target Expression")
    )
    normalizer = plot(
        df, x="group", y=normalizer, 
        Geom.boxplot,
        Guide.title("Raw CT $normalizer")
    )
    p = hstack(fold, expression, normalizer)
    img = SVG(output_path, 5inch, 4inch)
    draw(img, p)
end 

end # module
