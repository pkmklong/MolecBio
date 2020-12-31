__precompile__()

module MolecBio
using DataFrames
using CSV
using Statistics
using Gadfly

molecbio = MolecBio
export molecbio
export calculate_ddct


function make_output_path(file_path:: String, file_type:: String)   
    ind = findlast(isequal('.'), file_path) -1 
    output_path = string(file_path[1:ind], "_processed", file_type)
    return output_path
end


function load_table(file_path:: String)
    df = CSV.File(file_path) |> DataFrame
    return df
end


"""
    calculate_ddct(df, control, target, normalizer)
 
Returns delta delta ct values for target gene
"""
function calculate_ddct(df:: DataFrame, 
        control:: String,
        target:: String,
        normalizer:: String)  
    
    df[!, Symbol("delta_ct")] = df[!, Symbol(target)] .- df[!, Symbol(normalizer)]
    
    avg_delta_ct_control = mean(df[df[!, :group] .== control, :delta_ct])
    df[!, Symbol("delta_delta_ct")] = df.delta_ct .- avg_delta_ct_control   
    
    f = (x) -> 2^(-x)
    df[!, Symbol("fold_change")] = f.(-df.delta_delta_ct)

    return df
end


function calculate_percent_expression(df:: DataFrame, control:: String)
    
    f = (x) -> 2^(-x)
    df[!, Symbol("expression")] = f.(-df.delta_ct)
    average_expression = mean(df[df[!, :group] .== control, :expression])
    df[!, Symbol("percent_expression")] = (df.expression ./ average_expression) .* 100
    return df
end


function save_table(df:: DataFrame, output_path:: String)
    CSV.write(output_path, df)
end


function plot_fold_change(df:: DataFrame, 
        target:: String,
        normalizer:: String,
        output_path:: String)  
    fold = plot(
        df, x=:group, y=:fold_change, 
        Geom.boxplot,
        color=:group,
        Guide.title("Fold Change $target"),
        Guide.xticks(orientation=:vertical)
    )
    expression = plot(
        df, x=:group, y=:percent_expression, 
        Geom.boxplot,
        color=:group,
        Guide.title("Percent Change $target"),
        Guide.xticks(orientation=:vertical)
    )
    target = plot(
        df, x=:group, y=target, 
        Geom.boxplot,
        color=:group,
        Guide.title("Raw CT $target"),
        Guide.xticks(orientation=:vertical)
    )
    normalizer = plot(
        df, x=:group, y=normalizer, 
        Geom.boxplot,
        color=:group,
        Guide.title("Raw CT $normalizer"),
        Guide.xticks(orientation=:vertical)
    )
    #p = hstack(fold, expression, target, normalizer)
    p = gridstack([fold expression; target normalizer])
    img = SVG(output_path, 6inch, 8inch)
    draw(img, p)
end 

end # module
