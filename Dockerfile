FROM ubuntu:15.10

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  wget \
  unzip \
  imagemagick \
  git \
  libglew-dev \
  libdevil-dev \
  libgtk2.0-dev \
  xvfb

RUN apt-get install -y mesa-utils xserver-xorg-video-all libqtgui4 libqt4-opengl

RUN mkdir /opt/bin
# Copy binares from host
ADD ./bin /opt/bin

# Add PoissonRecon, VisualSFM and meshlab bin folder to PATH.
ENV PATH $PATH:/opt/bin/poissonrecon
ENV PATH $PATH:/opt/bin/meshlab
ENV PATH $PATH:/opt/bin/vsfm
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/bin/vsfm
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/bin/meshlab

RUN ln -s /opt/bin/meshlab/ /usr/lib/

RUN Xvfb :100 &
ENV DISPLAY :100

# copy sequence script
ADD ./photo-to-mesh.sh /opt/
ADD ./meshlab-script.mlx /opt/
RUN chmod +x /opt/photo-to-mesh.sh && mkdir /opt/workdir
