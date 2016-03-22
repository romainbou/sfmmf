FROM ubuntu:15.10

RUN apt-get update && apt-get install -y \
  wget \
  imagemagick libmagick++-dev \
  unzip \
  git \
  build-essential \
  cmake \
  libglew-dev \
  libgtk2.0-dev \
  libboost-dev \
  libdevil-dev \
  freeglut3-dev \
  qt4-default \
  locate \
  jhead \
  lib3ds-dev \
  xvfb \
  m4

# Download and build VisualSFM.
RUN cd /opt && \
  mkdir visualSFM && cd visualSFM && \
  wget http://ccwu.me/vsfm/download/VisualSFM_linux_64bit.zip && \
  unzip VisualSFM_linux_64bit.zip && \
  cd vsfm && \
  make

# Download and build cmvs & pmvs2
RUN cd /opt && \
  git clone https://github.com/pmoulon/CMVS-PMVS && \
  cd CMVS-PMVS/program && mkdir linux-build && \
  cmake linux-build . && \
  make && \
  cd main && cp cmvs genOption pmvs2 /opt/visualSFM/vsfm/bin/

# Download and build siftGPU
RUN cd /opt && \
  wget http://wwwx.cs.unc.edu/~ccwu/cgi-bin/siftgpu.cgi && \
  mv siftgpu.cgi siftgpu.zip && \
  unzip siftgpu.zip && \
  cd SiftGPU && \
  make && \
  cp bin/libsiftgpu.so /opt/visualSFM/vsfm/bin/

# Install MPIR a meshlab dependency
RUN cd /opt && \
  wget http://mpir.org/mpir-2.7.2.zip && \
  unzip mpir-2.7.2.zip

RUN cd /opt/mpir-2.7.2/ &&\
  /opt/mpir-2.7.2/configure;\
  cd /opt/mpir-2.7.2/ &&\
  ls &&\
  make; make install

# Download and build Meshlab
RUN cd /opt && \
  wget http://downloads.sourceforge.net/project/meshlab/meshlab/MeshLab%20v1.3.3/MeshLabSrc_AllInc_v133.tgz && \
  tar zxvf MeshLabSrc_AllInc_v133.tgz && \
  sed -i '15,15 s/#//' /opt/meshlab/src/meshlabserver/meshlabserver.pro && \
  echo "linux-g++-64:INCLUDEPATH += ../../external/inc/linux-g++/mpir-2.4.0" >> /opt/meshlab/src/meshlabplugins/filter_csg/filter_csg.pro && \
  echo "linux-g++-64:INCLUDEPATH += ../../external/inc/linux-g++/mpir-2.4.0" >> /opt/meshlab/src/meshlabplugins/filter_csg/filter_csg.pro && \
  sed -i '/#include <io.h>/a #else\n#include <unistd.h>' /opt/vcglib/wrap/ply/plystuff.h

ENV QMAKESPEC /usr/share/qt4/mkspecs/linux-g++-64

RUN cd /opt/meshlab/src/external && \
  qmake -recursive external.pro && \
  make

RUN cd /opt/meshlab/src && \
  qmake -recursive meshlab_full.pro && \
  make

# Download and build PoissonRecon
RUN cd /opt && \
  git clone https://github.com/mkazhdan/PoissonRecon && \
  cd PoissonRecon && \
  make

# Download and build libpba (no_gpu for now)
RUN cd /opt && \
  wget http://grail.cs.washington.edu/projects/mcba/pba_v1.0.5.zip && \
  unzip pba_v1.0.5.zip

RUN cd /opt/pba && \
  mv makefile makefile_gpu && \
  mv makefile_no_gpu makefile && \
  make && \
  cp bin/libpba_no_gpu.so /opt/visualSFM/vsfm/bin/libpba.so

# Add VisualSFM and meshlab bin folder to PATH.
ENV PATH $PATH:/opt/PoissonRecon/Bin/Linux
ENV PATH $PATH:/opt/meshlab/src/distrib

# Add VisualSFM bin folder to PATH.
ENV PATH $PATH:/opt/visualSFM/vsfm/bin

# Copy binares to /opt/bin
RUN mkdir /opt/bin && \
  mkdir /opt/bin/vsfm && \
  cp /opt/visualSFM/vsfm/bin/* /opt/bin/vsfm/
RUN mkdir /opt/bin/meshlab && \
  cp /opt/meshlab/src/distrib/meshlabserver /opt/bin/meshlab/
RUN mkdir /opt/bin/poissonrecon && \
  cp /opt/PoissonRecon/Bin/Linux/PoissonRecon /opt/bin/poissonrecon/ && \
  cp /opt/PoissonRecon/Bin/Linux/SurfaceTrimmer /opt/bin/poissonrecon/
