# docker-geonetwork

Dockerfile running a generic geonetwork 3.2.1 that can be have INSPIRE easely implemented

### Docker image

The docker image is based on geonetwork 3.2.1, which is in the offical [repository](https://hub.docker.com/_/geonetwork/).

### Install INSPIRE complient

To build the image:
```
docker build -t geonetwork:3.2.1 .	
```

Then the image needs to be started/run
```
docker run --name geonetwork -d -p8080:8080 geonetwork:3.2.1
```
Run the setup inspire rescript
From outside run the INSPIRE setup script. 
```
docker exec -it geonetwork /setup_inspire.sh
```
Then restart the container
```
docker restart geonetwork
```


Thesaurus, views, schematron should now be INSPIRE complient
