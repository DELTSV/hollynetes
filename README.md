# HollyNetes project
### Description

HollyNetes is a project we made to show our skills in Kubernetes and Terraform.

The project is a fork of [HollyFilms](https://github.com/Loic-Vanden-Bossche/HollyFilms), a project i have created to provide a simple way to manage the movies and process large video files. 

### Warning

This project do not implement all the features of HollyFilms.

## Features
### Mandatory layer
- ~~The app you're deploying MUST be dockerized (i.e. available as a container
  image). It's a k8s requirement.~~
- ~~The container image MUST be available on the internet in a docker-compatible
  image registry. It COULD be in a public image registry (i.e. without
  authentication)~~
- ~~The app you're deploying MUST use a database of some sort (postgresql, mysql,
  mongo, etc.)~~
- ~~The database MUST be deployed either inside kubernetes OR as a managed
  scaleway service provisionned through terraform.~~
- ~~The kubernetes cluster MUST be provisioned on scaleway using terraform~~
- ~~The app MUST be deployed as a Pod using terraform via the kubernetes provider~~
- ~~The cluster and the app provisioning code must be organized in dedicated
  terraform modules, and used from the main program~~
- ~~The terraform state of your main program MUST be stored in a remote (i.e.
  non-local) backend. Stating it more explicitly, use `backend "s3" {}`~~
- ~~It MUST be possible to deploy your app using only 3 commands,~~
    - ~~One to build and push the docker container (`docker build --push [...]`)~~
    - ~~One to provision the state bucket using tf.~~
    - ~~A last one to provision the terraform cluster and all the kubernetes
      resources required to deploy your app in the cluster. There MUST be no other
      manual actions required. It means there must be 2 terraform programs.~~
- ~~Your app MUST be available publicly on the Internet (you can use a
  LoadBalancer, or a NodePort. The latter is cheaper)~~

### Bonus layer
- ~~The app is deployed as a Deployment (and not a single Pod), using terraform
  via the kubernetes provider. (1)~~
- ~~The app you're deploying is also using an alternate datastore, like an object
  storage (example: an S3 compatible store), or Redis, in addition to the main
  datastore (2)~~
- The app you're deploying has an additional container running a different, but
  related process, for example a background job processor. (1)
- ~~The app has automated scaling based on CPU usage of the container (HorizontalPodAutoscaling). (1.5)~~
- ~~The app container image is stored in a private container registry with the
  credentials injected as a kubernetes secret via terraform (1.5)~~
- ~~The private container registry is also created via terraform (1)~~
- ~~Your app is exposed to the internet through a kubernetes ingress controller
  (like traefik, the nginx ingress controller, etc.) (2)~~
- ~~The app is exposed through https, using the ingress controller of the previous
  point and tls certificate managed using the `cert-manager` tool (+3)~~
- Your app is deployed through a custom (i.e. that you wrote yourselves) helm
  chart. The helm chart is installed via terraform (+3)
- ~~Your kubernetes cluster has centralized logging using loki and grafana, aka
  the loki-stack. Helm is recommended here :) (+3).~~
- ~~You have a CI/CD pipeline automating the build and deployment of your app when
  new commits are pushed on a certain branch of your app code repository (+4)~~

## Getting Started

### Installation

Install dependencies:
```console
pnpm install -g
pnpm install
```

Start NestJS API

```
pnpm run start:back
```

Start Angular frontend
```
pnpm run start:front
```

### Frontend

The frontend is an Angular application with tailwindCSS.

### API

The REST API is a NestJS application using my own nestjs-env-config library.  
NPM Package [nestjs-env-config](https://www.npmjs.com/package/nestjs-env-config).

### Terraform & Kubernetes

The Kubernetes cluster is deployed using Terraform using scaleway provider.

#### You need to put the nesseray variable in a file named terraform.tfvars located in the packages/infrastructure directory.

To init the projet, you need to run the init backend.
This will create the tfstate file in the scaleway bucket and create the namespace necessary to push/pull images from the scaleway registry.

```bash
cd init_backend
terraform init -var-file="../terraform.tfvars"
terraform apply -var-file="../terraform.tfvars"
```

To deploy the cluster, you need to run the main terraform project.

```bash
cd project
terraform init -var-file="../terraform.tfvars"
terraform apply -var-file="../terraform.tfvars"
```

### CI/CD

The CI/CD is made using Github Actions.

#### Frontend

The frontend is built using Github Actions and pushed to the scaleway registry.

#### API

The API is built using Github Actions and pushed to the scaleway registry.

#### Terraform

Terraform is planned & checked & validated in a pull request on main. Terraform is planned & checked & validated & applied in a push to main.

## HollyFilms Contributors

* Loïc Vanden Bossche

## HollyNetes Contributors

* Loïc Vanden Bossche
* Enzo Soares
* Turbiez Denis
