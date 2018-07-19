Usage: gp_gistic2_from_seg 
  -b base_dir 
  -seg segmentation_file
  -refgene ref_gene_file 
  [-mk markers_file] 
  [-alf array_list_file(def:empty)]
  [-cnv cnv_file] 
  [-ta amplifications_threshold(def=.1)] 
  [-td deletions_threshold(def=.1)]
  [-js join_segment_size(def=8)] 
  [-ext extension] 
  [-qvt qv_thresh(def=0.25)]
  [-rx remove_x(def=1)] 
  [-v verbosity_level(def=0)] 
  [-cap cap_val(def=1.5]]
  [-broad run_broad_analysis(def=0)] 
  [-brlen broad_length_cutoff(def=0.98)]
  [-maxseg max_sample_segs(def=2500)] 
  [-res res(def=0.05)] 
  [-conf conf_level(def=0.75)]
  [-genegistic do_gene_gistic(def=0)] 
  [-smalldisk save_disk_space(def=0)]
  [-smallmem use_segarray(def=1)] 
  [-savegene write_gene_files(def=0)]
  [-arb do_arbitration(def=1)] 
  [-twosides use_two_sided(def=0)] 
  [-peaktype peak_types(def=robust)]
  [-saveseg save_seg_data(def=1)] 
  [-savedata write_data_files(def=1)]
  [-armpeel armpeel(def=1)] 
  [-gcm gene_collapse_method(def=mean)]
  [-scent sample_center(def=median)] 
  [-maxspace max_marker_spacing]
  [-logdat islog(def=auto-detect)]



Example commandLines, to demonstrate how to run from a non-containerized environment ...

#
# <run-with-env> -u matlab-mcr/2014a
#   customization via <env-custom>
#   works with dotkit
#   can work with docker and singularity
#
commandLine=<run-with-env> -u matlab-mcr/2014a <libdir>gp_gistic2_from_seg -b ...

#
# <gp_gistic2_from_seg>
#   customization via substitution parameter
#   very flexible, but requires manual config to install and to run
#
commandLine=<gp_gistic2_from_seg> -b ...

#
# <run-with-env> -e LD_LIBRARY_PATH= ...
#   the run-with-env wrapper script sets required environment variables
#   inside the container
#
commandLine=<run-with-env> \
  -e LD_LIBRARY_PATH=/usr/local/MATLAB/MATLAB_Compiler_Runtime/v83/runtime/glnxa64\
                   :/usr/local/MATLAB/MATLAB_Compiler_Runtime/v83/bin/glnxa64\
                   :/usr/local/MATLAB/MATLAB_Compiler_Runtime/v83/sys/os/glnxa64 \
  -e XAPPLRESDIR=/usr/local/MATLAB/MATLAB_Compiler_Runtime/v83/X11/app-defaults \
  gp_gistic2_from_seg -b ...


#
# GpUnit notes
#
maxspace, not relevant when 'markers.file' is set
logdat, not set, use default
  "",  (not set,autodetect)
  "0", (linear)
  "1", (log2)

Example diffCmd:
            # custom diff, strip logging lines from stdout.txt
            #   sed -e '/--- DONE setting up environment variables ---/d'
            #diffCmd: [ "./diff-skip-lines.sh", "/--- DONE setting up environment variables ---/d"]
