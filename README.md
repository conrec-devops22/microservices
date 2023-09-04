# Microservices Basic Lab

Mission: Make two microservices, make them communicate privately and open up one for host access (http://localhost:5002)

## Add a User-Defined Bridge Network:

```
docker network create my_network
```

## Build and run Service 1

```
$ cd service1
```
Build it and name it `service1`:
```
$ docker image build -t service1 .
```
Run it:
```
$ docker container run --rm --detach --name service1_container --network my_network service1
```

Parameter explanations:
```
--rm        Remove container when stopped or finished running
--detach    Detach from terminal but keep running inside Docker
--name      Specify a custom name for the container
--network   Attach the container to a network
```

## Build and run Service 2

```
$ cd service2
```
Build it and name it `service2`:
```
$ docker image build -t service2 .
```
Run it:
```
$ docker container run --rm -d --name service2-container --network my_network --publish 5002:5002 service2
```

Parameter explanations:
```
--publish   Which ports to expose to Host network
```

## Try it out

Go visit http://localhost:5002 and see if it works!
