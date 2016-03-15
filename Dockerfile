FROM ubuntu:15.10

RUN apt-get update && apt-get install -y \
  wget \
  unzip \
  imagemagick \
  git \
  libglew-dev \
  libdevil-dev \
  libgtk2.0-dev \
  xvfb

RUN mkdir /opt/bin
# Copy binares from host
ADD ./bin /opt/bin

# Add PoissonRecon, VisualSFM and meshlab bin folder to PATH.
ENV PATH $PATH:/opt/bin/poissonrecon
ENV PATH $PATH:/opt/bin/meshlab
ENV PATH $PATH:/opt/bin/vsfm

RUN Xvfb :100 &
ENV DISPLAY :100

# copy sequence script
ADD ./photo-to-mesh.sh /opt/
RUN chmod +x /opt/photo-to-mesh.sh && mkdir /opt/workdir
