# sfmmf
Warping Structure from Motion pipeline in one command line

## Usage:

Put all the binaries in the `bin` directory to your `$PATH`  
First arguement give a path to a folder containing:
* `images/` folder where the images are stored
* `points/` folder where could points will be stored
* `mesh/` folder where mesh will be stored

`sh photo-to-mesh.sh imageInputFolder outputsPrefix`

## Using docker:
`docker run -v pathToHostImageFolder:/opt/workdir /opt/photo-to-mesh.sh /opt/workdir outputsPrefix`

### or with the wrapper scripts:
To launch photo-to-mesh script with your host folder mounted at container's /opt/workdir  
`./run.sh pathToHostImageFolder/`

To lauch bash (docker -it) with your host folder mounted at container's /opt/workdrir  
`./it.sh pathToHostImageFolder/`
