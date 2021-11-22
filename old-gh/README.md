# giant-squid
This is for joining the best crypto exchange in Europe,
with the most secure crypto wallet and coolest design.

## Exercise 1 - Dockerfile
Used image from dockerhub: uphold/litecoin-core, and after checking how the
image is built and that is uses an entrypoint script [0], there was not much
to configure without building the project, other that specifying the command and 
parameters as the entrypoint script is configured to take.

When passing litecoind parameter to start the daemon, it uses litecoin user instead
of root.

The images are created by the litecoin core team and their Dockerfile build
checks images signatures. Personally I would build the images from the Dockerfiles
myself if using for a project, instead of trusting their builds have not been compromised,
securing my own build pipeline.

Tested the image with:
`docker build -t lite-d . && sudo docker run -ti --rm lite-d`

For testing the image security with anchore, I just ran anchore/inline-scan:
`sudo docker build -t lite-new:latest -f Dockerfile .`
`curl -s https://ci-tools.anchore.io/inline_scan-latest | sudo bash -s -- -f -d Dockerfile lite-d:latest`

[0]: https://github.com/uphold/docker-litecoin-core/tree/master/0.18

The image failed anchore tests miserably due to outdated packages (latest build from 8 months ago),
so the apt update the dockerfile is configured to do has nothing running the build lately.

I could do the apt update/upgrade but found the /etc/apt/sources.list has an old version of security sources,
had to update it. 

--
## Exercise 2 - 