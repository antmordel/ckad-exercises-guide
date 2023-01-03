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

function bootstrap {
  echo "Update system"
  sudo yum update

  echo "Install Git"
  sudo yum install git

  echo "Install Docker"
  sudo yum install

  install_kubectl
}

bootstrap