# Docker Lifecycle Snapshots for Konclude

Based on https://github.com/MatrixManAtYrService/lifecycle-snapshots, these (sub-)directories contain scripts and dockerfiles that allow for building Konclude (within docker containers) and the docker image for excecuting the built version of Konclude.
The build proceeds in four lifecycle snapshots:
- Run
- Develop
- Build
- Deploy

Ultimately, an image is created for each of these and a copy of the statically linked Konclude binary will be added into the `../Release` directory.
In addition, the `konclude` docker image is created that contains Konclude and can directly be executed, e.g., with the following commands:

```
docker run -v /path/to/ontologies:/data --rm konclude classify -i /data/ontology.owl.xml -o /data/classification-result.xml

docker run -v /path/to/owllink-request-files:/data --rm konclude owllinkfile -i /data/owllink-request.xml -o /data/owllink-response.xml

docker run -p 8080:8080 --rm konclude sparqlserver

docker run -p 8080:8080 --rm konclude owllinkserver
```


## Lifecycle Snapshots

### Run
This encapsulates anything that must be installed on the user's machine to run Konclude (since Konclude is linked statically, we only require a basic (ubuntu) linux).

### Develop 
This houses the code and any tools for development, i.e., Qt, Redland RDF Libraries, and the (prepared) Konclude source code. The image is based on the run snapshot image [run/Dockerfile](run/Dockerfile).
The Konclude source code is taken from the folder `../Konclude`.

### Build
Starting the image [build/Dockerfile](build/Dockerfile) as a container will executes the build/compilation of Konclude. The image is based on the one of the develop snapshot [develop/Dockerfile](develop/Dockerfile).

### Deploy
This contains the compiled version of Konclude and is suitable for pushing to dockerhub. The image of this snapshot is based on the image of the run snapshot.


# Snapshot Scripts

Make sure docker is installed, then try the following commands:

``` ./run/snap.sh
    ./develop/snap.sh
    ./build/snap.sh
    ./deploy/snap.sh
```

Note that each snapshot script automatically calls the dependent snapshot scripts such that the required/dependent images are created, i.e., you can simply call `./deploy/snap.sh` to build all images and to obtain the binary of Konclude in the `../Release` directory.

## Reruns are fast

Note that docker looks at the inputs to a build to determine wheter it needs to update the image.  So just because 'run' takes a while the first time (it's downloading and installing stuff) doesn't mean it will take that long later.  Unless you change something about the runtime environment.

