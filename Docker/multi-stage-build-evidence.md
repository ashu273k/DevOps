# Docker Multi-Stage Build Homework

**Name:** `Aashu Kumar`

**Enrollment number:** `10172`

## Task 1: Multi-Stage Dockerfile

The repository was cloned and opened at the repository root:

```sh
git clone https://github.com/ashu273k/DevOps.git
cd DevOps
```

Build the multi-stage image:

```sh
docker build -t hello-multi-stage:homework Docker/multi-stage-hello
```

The Dockerfile uses `node:22-alpine AS build` to generate the HTML page, then copies the generated page into an Nginx runtime image. The runtime Nginx server listens on container port `8080`.

Run the container:

```sh
docker run -d --name hello-multi-stage-homework -p 18087:8080 hello-multi-stage:homework
```

Access and verify the application:

```sh
curl -fsS http://localhost:18087 | grep -F 'Hello World from Docker multi-stage build'
```

Output:

```text
<!doctype html><html lang="en"><head><meta charset="utf-8"><title>Docker Multi-Stage Build</title></head><body><h1>Hello World from Docker multi-stage build</h1></body></html>
```

Verify the running container and port:

```sh
docker ps --filter name=hello-multi-stage-homework --format '{{.Names}} | {{.Ports}} | {{.Status}}'
```

Output:

```text
hello-multi-stage-homework | 0.0.0.0:18087->8080/tcp, [::]:18087->8080/tcp | Up About a minute
```

The application is available at http://localhost:18087 and runs on container port `8080`.

## Task 2: Docker Application Deployment

The repository includes and successfully runs three different application types:

| Application | Image | Verification output |
| --- | --- | --- |
| Node.js | `hello-node:homework` | `Hello World from Node.js` |
| Python | `hello-python:homework` | `Hello World from Python` |
| Java | `hello-java:homework` | `Hello World from Java` |

Commands used to run them:

```sh
docker run -d --name hello-node-evidence -p 18181:8080 hello-node:homework
docker run -d --name hello-python-evidence -p 18182:8080 hello-python:homework
docker run -d --name hello-java-evidence -p 18183:8080 hello-java:homework
```

Verification output:

```text
<!doctype html><html><body><h1>Hello World from Node.js</h1></body></html>
<!doctype html><html><body><h1>Hello World from Python</h1></body></html>
<!doctype html><html><body><h1>Hello World from Java</h1></body></html>
```

`docker ps` output showing all four running containers and port `8080`:

```text
hello-java-evidence | 0.0.0.0:18183->8080/tcp, [::]:18183->8080/tcp | Up
hello-python-evidence | 0.0.0.0:18182->8080/tcp, [::]:18182->8080/tcp | Up
hello-node-evidence | 0.0.0.0:18181->8080/tcp, [::]:18181->8080/tcp | Up
hello-multi-stage-homework | 0.0.0.0:18087->8080/tcp, [::]:18087->8080/tcp | Up
```

## Cleanup

```sh
docker rm -f hello-multi-stage-homework hello-node-evidence hello-python-evidence hello-java-evidence
```
