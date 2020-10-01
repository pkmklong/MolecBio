using ArgParse
using MolecBio
using DataFrames


function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table! s begin
        "--file_path", "-f"
            help = "The path to raw ct data (csv) for relative RNA quantification"
            arg_type = String
            required = true
        "--control", "-c"
            help = "The name of your control group"
            arg_type = String
            default = "control"
            required = true
        "--target", "-t"
            help = "The name of your target transcript"
            arg_type = String
            required = true
        "--normalizer", "-n"
            help = "The name of your normalizing reference transcript"
            arg_type = String
            required = true
    end
    return parse_args(s)
end


function main()
    args = parse_commandline()
    println("Parsed args:")
    for (arg,val) in args
        println("  $arg  =>  $val")
    end
    @info "Loading CT values table" args["file_path"]
    raw_table = MolecBio.load_table(args["file_path"])
    ddct_table = MolecBio.calculate_ddct(
        raw_table,
        args["control"], 
        args["normalizer"],
        args["target"]
    )
    @info "Computing fold change with delta delta ct " first(ddct_table, 5)
    
    ddct_table = MolecBio.calculate_percent_change(ddct_table)
    @info "Computing percent change " first(ddct_table, 5)
 
    ddct_table_path = MolecBio.make_output_path(args["file_path"], ".csv")
    @info "Saving output table to " ddct_table_path
    MolecBio.save_table(ddct_table, ddct_table_path)
    
    ddct_figure_path = MolecBio.make_output_path(args["file_path"], ".svg")
    @info "Saving output figure to " ddct_figure_path
    MolecBio.plot_fold_change(ddct_table, args["normalizer"], ddct_figure_path)
end

main()
