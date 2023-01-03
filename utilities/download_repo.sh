#!/bin/bash

function download_repo {
  git clone git@github.com:antmordel/ckad-exercises-guide.git
  cd ckad-exercises-guide
}

download_repo