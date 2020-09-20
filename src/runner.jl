using ArgParse
using MolecBio

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
        "--normalizer", "-n"
            help = "The name of your normalizing reference transcript"
            arg_type = String
            required = true
        "--target", "-t"
            help = "The name of your target transcript"
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
    raw_table = MolecBio.load_table(
        get(args, "file_path", nothing)
    )
    ddct_table = MolecBio.calculate_ddct(
        raw_table, 
        get(args, "control", nothing), 
        get(args, "normalizer", nothing),
        get(args, "target", nothing)
        )
    output_path = MolecBio.make_output_path(
        get(args, "file_path", nothing)
        )
    MolecBio.save_table_to_csv(ddct_table, output_path)
end

main()
