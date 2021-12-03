#!/bin/bash

for f in day*.rb; do
  echo $f
  ruby $f
done
