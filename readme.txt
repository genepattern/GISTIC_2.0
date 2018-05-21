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
