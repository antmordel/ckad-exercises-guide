#!/bin/bash

if ! command -v kind &> /dev/null
then
    echo "Kind could not be found"
    echo "Please install it..."
fi

kind_get_clusters=$(kind get clusters)

if [[ $kind_get_clusters != "local" ]]; then
  echo "There is no kind cluster called <local>."
  kind create cluster --name local --config config_kind.yaml
else
  echo "Cluster already running 🚀"
fi
