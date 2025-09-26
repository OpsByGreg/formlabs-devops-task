# Formlabs DevOps home assignment

This repository contains a home assignment code for DevOps applicants for Formlabs.

See all open jobs at https://careers.formlabs.com/


## Task

0. Fork this repo.
1. Create a deployable docker image for the application.
    - Feel free to switch up technologies. For example you can use `buildah` instead of Docker.
2. Create a Kubernetes deployment and service for the application.
    - Just aim for the simplest setup, no ingress deployment is needed. Feel free to use Helm.
    - You can use [Minikube](https://minikube.sigs.k8s.io/docs/start/) or [k3s](https://k3s.io/) or any other Kubernetes distribution you are familiar with.
3. Create automation to build, test and deploy the application when a change happens in git.
    - Feel free to switch up technologies. For example you can use an Ansible playbook or a Jenkins pipeline.
4. Send us the fork where you did your work.

### Notes

- Explain as much as possible in the commit message(s) and/or comments if needed. See more on commit messages [here](https://chris.beams.io/posts/git-commit/).
- It would be great if you'd also write about why you choose a certain technology if there are alternatives to consider.

## Solution

### Pre-requisites

- Docker installed and running locally https://docs.docker.com/engine/install/
- Minikube installed and running https://minikube.sigs.k8s.io/docs/start/?arch=%2Fwindows%2Fx86-64%2Fstable%2F.exe+download

### General notes

Please find the following 3 branches in the repository:

- TASK-01
- TASK-02
- TASK-03

They build on each other for each task with TASK-03 containing the full solution. So checkout TASK-03 to play with the code.
Please see `git log` for a detailed commit messages, 1 for each task.

For the automation, I decided to implement workflows via GitHub Actions to run tests and push the tagged image to an ECR repository in my personal AWS account.

I look forward to working through the code with you!

