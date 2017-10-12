# Docker-PyHRF

Docker image for PyhRF.


## Examples

### Upload image to Docker Hub

The following commands allows to build and upload the pyhrf Docker image to the cloud.

1. Go to the docker-pyhrf repository: `cd docker-pyhrf`
2. Build the image: `docker build -t pyhrf/pyhrf .`
3. Log in to Docker Cloud: `docker login`
4. Push the image: `docker push pyhrf/pyhrf`

### Run tests
The following command allows to run the tests of PyHRF.

```bash
docker run --rm \
    -v <folder to save the .coverage file>:/output:rw \
    -e LOCAL_USER_ID=`id -u $USER` \
    pyhrf/pyhrf \
    bash -c "nosetests --with-doctest --with-coverage --cover-package=pyhrf -v -s pyhrf; cp .coverage /output"
```

### Run JDE VEM analysis

The following command runs a PyHRF analysis using a canonical HRF (`--no-estimate-hrf`). For more examples, please refer
to the PyhRF documentation.

```bash
docker run --rm \
    -v <folder to save the outputs>:/output:rw \
    -v <folder to inputs>:/inputs:ro \
    -e LOCAL_USER_ID=`id -u $USER` \
    pyhrf/pyhrf \
    pyhrf_jde_vem_analysis --output /output --beta <beta value> --no-estimate-hrf --zero-constraint --drifts-type cos --parallel --log-level WARNING <dt value> /inputs/<mask file> /inputs/<paradigm file> /inputs/<bold image>
```

 
