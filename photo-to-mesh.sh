#!/bin/sh

inputFolder=$1
outputName=$2

createImageList () {
  inputFolder=$1
  outputName=$2
  echo "Creating image list"
  find $inputFolder/images/ -maxdepth 1 | grep '.jpg\|.JPG' > $inputFolder/$outputName-image-list.txt
}

resizeAllimage (){
  inputFolder=$1
  outputName=$2
  # convert $inputFolder/*.jpg[3200x3200] resized%03d.jpg
  if [ ! -d "$inputFolder/resized-images/" ]; then
    mkdir $inputFolder/resized-images/
  fi

  nb_jpg=$(ls -l | grep .jpg | wc -l)
  if [ $nb_jpg -gt 0 ]
  then
    echo "Resizing too large images..."
    convert $inputFolder/images/*.jpg[3200\>x3200\>] $inputFolder/resized-images/resized%03d.jpg
  fi

  nb_jpg=$(ls -l | grep .JPG | wc -l)
  if [ $nb_jpg -gt 0 ]
  then
    echo "Resizing too large images..."
    convert $inputFolder/images/*.JPG[3200\>x3200\>] $inputFolder/resized-images/resized%03d.jpg
  fi
  find $inputFolder/resized-images/ -maxdepth 1 | grep '.jpg' > $inputFolder/resized-$outputName-image-list.txt
}

mergeMeshes () {
  inputFolder=$1
  outputName=$2
  echo "Merging all meshs with meshlab..."
  mkdir $inputFolder/points/
  meshlabserver -i $inputFolder/points/*.ply -o $inputFolder/points/$outputName-points.ply -om vc vq vn fq fn wc wn wt
}

pmvsComputation () {
  inputFolder=$1
  outputName=$2
  echo "Creating the mesh from the point cloud using PoissonRecon..."
  PoissonRecon --in $inputFolder/points/$outputName-points.ply --out $inputFolder/$outputName-mesh.ply --depth 10 --color 16
}

removeImageLists () {
  inputFolder=$1
  outputName=$2
  rm $inputFolder/$outputName-image-list.txt
  rm $inputFolder/resized-$outputName-image-list.txt
}

removeVisualtSFMfiles () {
  inputFolder=$1
  outputName=$2
  # TODO fix
  # rm: impossible de supprimer 'result.cmvs': Aucun fichier ou dossier de ce type
  rm -R $inputFolder/points/result.cmvs
}

computeMesh () {

  #createImageList
  resizeAllimage
  #VisualSFM sfm+pmvs $inputFolder/resized-$outputName-image-list.txt $inputFolder/points/$outputName-visualSFM-results.nvm
  #mergeMeshes
  # TODO avancement des stif files ls -1 | grep .sift | wc -l
  # TODO maybe remove SIFT files in the images folder
  #pmvsComputation
  #removeImageLists
  # removeVisualtSFMfiles
}

if [ -n "$inputFolder" ] && [ -n "$outputName" ]; then
  computeMesh
else
    echo "argument error"
fi
