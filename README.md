# HollyNetes project
### Description

HollyNetes is a project we made to show our skills in Kubernetes and Terraform.

The project is a fork of [HollyFilms](https://github.com/Loic-Vanden-Bossche/HollyFilms), a project i have created to provide a simple way to manage the movies and process large video files. 

### Warning

This project do not implement all the features of HollyFilms.

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
