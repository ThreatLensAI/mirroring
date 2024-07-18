#!/bin/bash

# This script is used to mirror a website to a local directory.

# Check for the correct number of parameters.
if [ $# -ne 2 ]; then
  echo "Usage: $0 <filepath-to-images-list> <registry-repository-name>"
  exit 1
fi

if [ ! -f "$1" ]; then
  echo "File $1 not found!"
  exit 1
fi

# Install crane if not already installed
if ! command -v crane &> /dev/null
then
    echo "crane could not be found, installing crane"
    VERSION=$(curl -s "https://api.github.com/repos/google/go-containerregistry/releases/latest" | jq -r '.tag_name')
    OS=Linux
    ARCH=x86_64
    curl -sL "https://github.com/google/go-containerregistry/releases/download/${VERSION}/go-containerregistry_${OS}_${ARCH}.tar.gz" > go-containerregistry.tar.gz
    tar -zxvf go-containerregistry.tar.gz -C /usr/local/bin/ crane
fi

# Read the file line by line
while IFS= read -r line
do
  # Check if the line is a comment
  if [[ $line == \#* ]]; then
    continue
  fi

  # Check if the line is empty
  if [ -z "$line" ]; then
    continue
  fi

  # Extract the repo and image name
  image=$(echo "$line" | rev | cut -d/ -f1 | rev)

  # Crane copy the image to the private repository
  echo "Copying $line to $2/$image"
  crane copy "$line" "$2"/"$image"
  echo "Done copying $line to $2/$image"

done < "$1"

