
for j in *.pdb
do 
	var=${j%.pdb}
	mkdir $var
	mv "$j" "$var/"
	
chains_to_design="A B C D E F G H"  
folder_with_pdbs="./$var/"
path_for_parsed_chains="./$var/parsed_pdbs.jsonl"
path_for_tied_positions="./$var/tied_pdbs.jsonl"
path_for_designed_sequences="./$var/"
path_for_fixed_positions="./$var/fixed_pdbs.jsonl"
fixed_positions="84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133, 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133, 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133, 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133, 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133, 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133, 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133, 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133, 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133"

python ../submodules/ppi_iterative_opt/mpnn_fr/ProteinMPNN/helper_scripts/parse_multiple_chains.py --input_path=$folder_with_pdbs --output_path=$path_for_parsed_chains

python ../submodules/ppi_iterative_opt/mpnn_fr/ProteinMPNN/helper_scripts/make_fixed_positions_dict.py --input_path=$path_for_parsed_chains --output_path=$path_for_fixed_positions --chain_list "$chains_to_design" --position_list "$fixed_positions"

python ../submodules/ppi_iterative_opt/mpnn_fr/ProteinMPNN/helper_scripts/make_tied_positions_dict.py --input_path=$path_for_parsed_chains --output_path=$path_for_tied_positions --homooligomer 1 

python ../submodules/ppi_iterative_opt/mpnn_fr/ProteinMPNN/protein_mpnn_run.py \
        --path_to_model_weights "../submodules/ppi_iterative_opt/mpnn_fr/ProteinMPNN/soluble_model_weights/"\
	--jsonl_path $path_for_parsed_chains \
        --tied_positions_jsonl $path_for_tied_positions \
	--fixed_positions_jsonl $path_for_fixed_positions\
        --out_folder $path_for_designed_sequences \
        --num_seq_per_target 10 \
        --sampling_temp "0.2" \
        --batch_size 8 \
        --pack_side_chains 1 \
        --num_packs 1 

done >> array_cmd_s
