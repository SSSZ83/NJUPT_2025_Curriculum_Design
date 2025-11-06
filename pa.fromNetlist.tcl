
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name B23020317 -dir "C:/projects/B23020317/planAhead_run_4" -part xc3s50antqg144-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/projects/B23020317/music_system_top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/projects/B23020317} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "music_system_top.ucf" [current_fileset -constrset]
add_files [list {music_system_top.ucf}] -fileset [get_property constrset [current_run]]
link_design
