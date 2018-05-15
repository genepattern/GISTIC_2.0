# copyright 2017-2018 Regents of the University of California and the Broad Institute. All rights reserved.
FROM ubuntu:14.04
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    zip \
    unzip \
    xorg \
 && rm -rf /var/lib/apt/lists/*

# Install Matlab Component Runtime
#   -u matlab-mcr/2014a
# MATLAB Release: R2014a (8.3)
# MATLAB Component Runtime (MCR): 8.3
# MATLAB Compiler Version: 5.1
#

ENV mcr_base=/opt/matlab-mcr
ENV mcr_install_dir=${mcr_base}_install
ENV mcr_ver=v83
ENV mcr_root=${mcr_base}/${mcr_ver}

RUN mkdir -p ${mcr_base}
RUN mkdir -p ${mcr_install_dir}

WORKDIR ${mcr_install_dir}
RUN cd ${mcr_install_dir} && \
  wget https://www.mathworks.com/supportfiles/downloads/R2014a/deployment_files/R2014a/installers/glnxa64/MCR_R2014a_glnxa64_installer.zip && \
  unzip MCR_R2014a_glnxa64_installer.zip

RUN ${mcr_install_dir}/install -mode silent -agreeToLicense yes -destinationFolder ${mcr_base}

#
# Install GISTIC 2.0.23
#
ENV GISTIC_HOME=/opt/gistic/2.0.23
RUN mkdir -p ${GISTIC_HOME}
WORKDIR ${GISTIC_HOME}

RUN wget -qO- ftp://ftp.broadinstitute.org/pub/GISTIC2.0/GISTIC_2_0_23.tar.gz \
  | tar xvz -C /opt/gistic/2.0.23

# Configure environment variables for MCR

ENV PATH=${GISTIC_HOME}:${PATH}
ENV LD_LIBRARY_PATH=/opt/matlab-mcr/v83/runtime/glnxa64:/opt/matlab-mcr/v83/bin/glnxa64:/opt/matlab-mcr/v83/sys/os/glnxa64
ENV XAPPLRESDIR /opt/mcr/v90/X11/app-defaults

RUN rm -rf ${matlab-mcr_install}

CMD ["${GISTIC_HOME}/gp_gistic2_from_seg"]
