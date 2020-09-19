using ArgParse

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table! s begin
        "--file_path"
            help = "The path to raw ct data (csv) for relative RNA quantification"
        "--control", "-o"
            help = "The name of your control group"
            arg_type = Int
            default = 0
        "--normalizer"
            help = "The name of your normalizing reference transcript"
            action = :store_true
        "--target"
            help = "The name of your target transcript"
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
    raw_table = molecbio.load_table(args.file_path)
    ddct_table = molecbio.calculate_ddct(raw_table, args.control, args.target, args.normalizer)
    output_path = molecbio.make_output_path(args.file_path)
    molecbio.save_table_to_csv(ddct_table, output_path)
end

main()
