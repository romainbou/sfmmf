#!/bin/sh

inputFolder=$1

if [ -n "$inputFolder" ]; then
  # remove trailing slash
  inputFolder=${inputFolder%/}

  if [ -d "$inputFolder/images/" ]; then
    mv $inputFolder/images/*.jpg $inputFolder/ 2> /dev/null
    mv $inputFolder/images/*.JPG $inputFolder/ 2> /dev/null
    mv $inputFolder/images/*.png $inputFolder/ 2> /dev/null
    mv $inputFolder/images/*.PNG $inputFolder/ 2> /dev/null
    rm -R $inputFolder/images/
  fi
  if [ -d "$inputFolder/points/" ]; then
    rm -R $inputFolder/points/ > /dev/null
  fi
  if [ -d "$inputFolder/resized-images/" ]; then
    rm -R $inputFolder/resized-images/ > /dev/null
  fi

  rm $inputFolder/*.txt 2> /dev/null

else
    echo "argument error"
fi
