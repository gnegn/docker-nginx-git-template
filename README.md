# DevOps Infrastructure Example

## Overview
This repository demonstrates a sample infrastructure for a web application with a frontend (Vite + Nginx) and a backend (Flask API).  
The main focus is on containerization, CI/CD pipelines, and automated deployment on AWS EC2.

## Architecture
- **Frontend**  
  - Built with Vite.  
  - Static assets served via Nginx.  
  - Nginx configured for HTTPS using Let’s Encrypt Certbot.  

- **Backend (API)**  
  - Flask service running in a Docker container.  
  - Exposed through Nginx reverse proxy under `/api/`.  

- **Console**  
  - Additional container providing CLI access to the API.  

- **Infrastructure**  
  - Local development: `docker-compose.override.yml` + `Makefile`.  
  - Production deployment: `docker-compose.yml` with volumes (database, static assets, certificates).  
  - Certbot for SSL certificate issuance and renewal.  
  - Terraform to provision EC2 and networking resources.  

- **CI/CD (GitHub Actions)**  
  - `build.yml` — builds and pushes Docker images to DockerHub.  
  - `deploy.yml` — deploys containers to EC2 via SSH and Docker Compose.  
  - `terraform.yml` — provisions AWS infrastructure using Terraform.  
  - `https.yml` — updates Nginx configuration for HTTPS using generated certificates.  

## Repository Structure

- **api/** — Flask API (Dockerfile)
- **frontend/** — Vite frontend + Nginx (Dockerfile, nginx.conf)
- **console/** — CLI container
- **infra/** — Terraform configuration
- **docker-compose.yml** — Production Docker Compose
- **docker-compose.override.yml** — Local development Docker Compose
- **.github/workflows/**
  - `build.yml` — Build and push Docker images
  - `deploy.yml` — Deploy containers to EC2
  - `terraform.yml` — Apply Terraform infrastructure
  - `https.yml` — Update Nginx configuration to enable HTTPS
- **Makefile** — Helper commands for local build and up
- **.env** — Environment variables (DOCKERHUB_USERNAME, etc., not committed)

## Local Development
```bash
make build   # Build local Docker images
make up      # Start containers with docker-compose.override.yml
````

Access points:

* Frontend: [http://localhost](http://localhost)
* API: [http://localhost/api](http://localhost/api)

## Production Deployment on EC2

1. Build and push images:

   ```bash
   gh workflow run build.yml
   ```
2. Provision infrastructure:

   ```bash
   gh workflow run terraform.yml
   ```
3. Deploy containers:

   ```bash
   gh workflow run deploy.yml
   ```
4. Update Nginx for HTTPS:

   ```bash
   gh workflow run https.yml
   ```

## Technologies Used

* **Containerization:** Docker, Docker Compose
* **CI/CD:** GitHub Actions
* **Infrastructure:** Terraform, AWS EC2
* **Web server:** Nginx + Certbot
* **Backend:** Flask
* **Frontend:** Vite (React/Vue/Svelte depending on the stack)

## Notes

* Replace image names or set `DOCKERHUB_USERNAME` in `.env` for production.
* Sensitive data like secrets, private Docker images, and SSH keys are excluded from this repo.


