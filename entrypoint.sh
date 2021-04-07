#!/bin/bash

set -e

hugo --gc --minify --cleanDestinationDir

if [ -z "$INPUT_ARGS" ]; then
  echo '::error::Required Args parameter'
  exit 1
fi

if [ -z "$INPUT_SECRET_ID" ]; then
  echo '::error::Required SecretId parameter'
  exit 1
fi

if [ -z "$INPUT_SECRET_KEY" ]; then
  echo '::error::Required SecretKey parameter'
  exit 1
fi

if [ -z "$INPUT_BUCKET" ]; then
  echo '::error::Required Bucket parameter'
  exit 1
fi

if [ -z "$INPUT_REGION" ]; then
  echo '::error::Required Region parameter'
  exit 1
fi

coscmd config -a $INPUT_SECRET_ID -s $INPUT_SECRET_KEY -b $INPUT_BUCKET -r $INPUT_REGION -m 30
coscmd upload -rs --delete -f public/ /

echo "COS deploy successfully"
