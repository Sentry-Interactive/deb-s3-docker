# Deb-s3 Docker Image

This project packages the deb-s3 utility for publishing apt packages to AWS s3
as a Docker image so that it can be used in environments where Ruby isn't 
readily available. 

## Building
```shell
docker build --build-arg VERSION=VERSION_HERE .
```

## Deploying
```shell
./deploy VERSION_HERE
```

## Usage
```shell
docker run --rm -it --volume "$(pwd):/data" \
    --volume "$HOME/.gnupg:/root/.gnupg" \
    --volume "$HOME/.aws:/root/.aws" \
    --env-file <(env | grep AWS) \
    ghcr.io/sentry-interactive/deb-s3:latest --help

# Debug container by overriding the entrypoint
docker run --rm --volume "$(pwd):/data" \
    --volume "$HOME/.gnupg:/root/.gnupg" \
    --volume "$HOME/.aws:/root/.aws" \
    --env-file <(env | grep AWS) \
    --entrypoint /usr/bin/bash \
    -it ghcr.io/sentry-interactive/deb-s3:latest
    
# Deploy something
docker run --rm -it --volume "$(pwd):/data" \
    --volume "$HOME/.gnupg:/root/.gnupg" \
    --volume "$HOME/.aws:/root/.aws" \
    --env-file <(env | grep AWS) ghcr.io/sentry-interactive/deb-s3:latest \
    upload --sign=ABC123 -b apt-bucket --s3-region us-east-1 -v private \
    mypackage.deb
```