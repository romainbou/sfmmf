# sfmmf
Warping Structure from Motion pipeline in one command line


## USAGE:

Put all the binaries in the `bin` directory to your `$PATH`

First arguement give a path to a folder containing:
* `images/` folder where the images are stored
* `points/` folder where could points will be stored
* `mesh/` folder where mesh will be stored

`sh meshFromPicture.sh imageInputFolder outputsPrefix`

## Using docker:
`docker run -v hostImageFolder:/opt/workdir /opt/photo-to-mesh.sh /opt/workdir outputsPrefix`
