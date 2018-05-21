# copyright 2017-2018 Regents of the University of California and the Broad Institute. All rights reserved.
FROM ubuntu:14.04

RUN \
     apt-get update \
  && apt-get install -y \
    wget \
    curl \
    zip \
    unzip \
    xorg \
  && rm -rf /var/lib/apt/lists/*

# Install Matlab Component Runtime
#   <run-with-env> -u matlab-mcr/2014a ...
#   MATLAB Release: R2014a (8.3)
#   MATLAB Component Runtime (MCR): 8.3
#   MATLAB Compiler Version: 5.1
#

ENV MCR_BASE="/opt/matlab-mcr"
ENV MCR_VERSION="v83"
ENV MCR_HOME="${MCR_BASE}/${MCR_VERSION}"

RUN mkdir -p ${MCR_BASE} \
  && mcr_install_dir=${mcr_base}_install \
  && mkdir -p ${mcr_install_dir} \
  && cd ${mcr_install_dir} \
  && wget https://www.mathworks.com/supportfiles/downloads/R2014a/deployment_files/R2014a/installers/glnxa64/MCR_R2014a_glnxa64_installer.zip \
  && unzip -q MCR_R2014a_glnxa64_installer.zip \
  && ./install -mode silent -agreeToLicense yes -destinationFolder ${MCR_BASE} \
  && cd / \
  && rm -rf ${mcr_install_dir}

ENV LD_LIBRARY_PATH="${MCR_HOME}/runtime/glnxa64:${MCR_HOME}/bin/glnxa64:${MCR_HOME}/sys/os/glnxa64"
ENV XAPPLRESDIR="${MCR_HOME}/X11/app-defaults"

#
# Do we need java?
#   apt-get install openjdk-7-jre
#

#
# Install GISTIC 2.0.23
#
ENV GISTIC_HOME=/opt/gistic/2.0.23
RUN mkdir -p ${GISTIC_HOME}
WORKDIR ${GISTIC_HOME}

RUN wget -qO- ftp://ftp.broadinstitute.org/pub/GISTIC2.0/GISTIC_2_0_23.tar.gz \
  | tar xvz -C /opt/gistic/2.0.23

ENV PATH=${GISTIC_HOME}:${PATH}

CMD ["${GISTIC_HOME}/gp_gistic2_from_seg"]
