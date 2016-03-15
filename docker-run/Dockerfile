FROM ubuntu:15.10

RUN apt-get update && apt-get install -y \
  wget \
  unzip \
  imagemagick \
  git \
  libglew-dev \
  libgtk2.0-dev xvfb

# copy sequence script
ADD ../photo-to-mesh.sh /opt/

RUN mkdir /opt/bin
# Copy binares from host
ADD ../bin /opt/bin

  # Add PoissonRecon, VisualSFM and meshlab bin folder to PATH.
ENV PATH $PATH:/opt/bin/poissonrecon
ENV PATH $PATH:/opt/bin/meshlab
ENV PATH $PATH:/opt/bin/vsfm

RUN chmod +x /opt/photo-to-mesh.sh && mkdir /opt/workdir
RUN Xvfb :100 &
ENV DISPLAY :100
