#!/bin/bash
#
# A bootstrap script to install all the needed for this project on a fresh Amazon Linux 2 machine

function install_kubectl {
  cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

  sudo yum install -y kubectl
}

function install_docker {
  sudo yum install -y docker

  sudo service docker start
  sudo usermod -a -G docker ec2-user
  newgrp docker
}

function install_kind {
  # Installs and configures kind
  go install sigs.k8s.io/kind@v0.17.0

  export PATH=$PATH:$(go env GOPATH)/bin
}

function bootstrap {
  echo "Update system"
  sudo yum update -y

  echo "Install Git"
  sudo yum install -y git

  install_kubectl
  install_docker

  echo "Install Golang"
  sudo yum install -y golang

  install_kind
}

bootstrap