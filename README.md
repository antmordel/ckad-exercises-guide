# CKAD Exercises & Guide

This repository is strongly inspired by [bmunshko/ckad-crash-course](https://github.com/bmuschko/ckad-crash-course). These are the exercises I did to prepare for the CKAD exam. And the exercises I used for a Youtube video in which I solve all the exercises in live.

# CKAD Exam Guide

In order to pass the test, you will be asked 16 questions covering the following topics:


| DOMAIN | WEIGHT |
|--------|--------|
|Application Design and Build	| 20% |
|Application Deployment	| 20%|
|Application Observability and Maintenance | 15%|
|Application Environment, Configuration and Security | 25%|
|Services and Networking | 20%|

## Tips

Anytime you start the test, run the following commands:
  
```bash
alias k=kubectl
```

## Links

- [Certification site & exam](https://www.cncf.io/certification/ckad/)
- [Official Certification tips](https://docs.linuxfoundation.org/tc-docs/certification/tips-cka-and-ckad)
- [Kubernetes The Hard Way - Installing k8s from scratch](https://github.com/kelseyhightower/kubernetes-the-hard-way)

## References

- [bmunshko/ckad-crash-course](https://github.com/bmuschko/ckad-crash-course)
- [Udemy course on CDAK](https://www.udemy.com/course/certified-kubernetes-application-developer/)

## Getting started

**Dependencies/Tools**

1. Unix platform
2. Git
3. Kubectl
4. Docker
5. Kind (for Kind, you probably need Go installed)

**Install dependencies**

If you are using a RHEL linux machine for this purpose, you can use the following command to install all the necessary tools:
  
  ```bash
  curl -LsS https://raw.githubusercontent.com/antmordel/ckad-exercises-guide/v1.5.0/utilities/install_dependencies_amazon_linux.sh | bash /dev/stdin
  ```

**Download repo**

  ```bash
  curl -LsS https://raw.githubusercontent.com/antmordel/ckad-exercises-guide/v1.5.0/utilities/download_repo.sh | bash /dev/stdin
  ```