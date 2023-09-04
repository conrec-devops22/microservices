# Microservices Lab 2: Docker Compose

Update our microservices to use Docker Compose for building and orchestration.

## Preparation

Ensure no containers are currently running, or it will interfere with Docker Compose:
```sh
$ docker container list
```
The list should be empty. If it's not, let's stop them:
```sh
$ docker container stop <container_id>
```
And optionally remove them as well:
```sh
$ docker container remove <container_id>
```

## Update service2/app.py

Since Docker Compose will create and name containers for us, we need to move from using container names to service names. New `hello_world()` for `service2/app.py`:

```py
@app.route("/")
def hello_world():
    r = requests.get("http://service1:5001")
    return f"Hello from Service 2. Service 1 says: {r.text}!"
```

## Add a docker-compose.yaml

```yaml
version: '3'

networks:
  my_network:
    driver: bridge

services:
  service1:
    build: ./service1
    networks:
      - my_network

  service2:
    build: ./service2
    networks:
      - my_network
    ports:
      - "5002:5002"
```

This instructs Docker Compose how to build our images and how to deploy them later on.

## Build and run 

```sh
$ docker compose up --build --remove-orphans --detach
```

This will build and run it all and then detach to leave it running in the background.

Parameter explanations:
```
--build            Build images before starting
--remove-orphans   Remove any container not part of this compose file
--detach           Detach from terminal but keep running in the background
```

***NOTE:*** *Containers not _started_ by Docker Compose will _not_ be removed by `--remove-orphans`!*

## Try it out

Go visit http://localhost:5002 and see if it works!

## Docker Compose commands to try out

```sh
$ docker compose ps              # List running containers
$ docker compose logs            # Show logs from running containers
$ docker compose logs -f         # Show logs and keep follow the log in realtime
$ docker compose log <service>   # Show logs from <service> only
$ docker compose --help          # List all commands available - feel free to try out some!
```
