# Best crypto exchange exercise

## ex1
I found the official `litecoin-core` docker image on Docker Hub.
For testing the image security with anchore, I first ran `anchore/inline-scan`:
`sudo docker build -t lite-new:latest -f Dockerfile .`
`curl -s https://ci-tools.anchore.io/inline_scan-latest | sudo bash -s -- -f -d Dockerfile lite-d:latest`

## ex2
At this point I found `anchore inline scan` was being deprecated in a Jan 2022, and `grype` was the suggested alternative, so switched to it for the CI.


## ex3


## ex4


## ex5
I found a page with the original poem about our favourite octopus, and had to filter that page for it.
I quickly used grep, sed, cut for that.

## ex6
Did the same with python

## Issues:
* Gitlab blocked my account for no reason while just pushing code, which made me waste time switching CI solution -.-
(I left the .gitlab-ci.yml to show what I was doing. On the includes part, the only one needed was Security/Container-Scanning.gitlab-ci.yml, the rest were what I was testing just for fun as I had just found the templates, and sparked my interest)
It was my chance to finally test Travis CI, compared with Jenkins I like how clean Travis syntax looks (and not a fan of json) :P

* The litecoin-core image from upbound does not have an arm build, nobody considered by M1 mac -.-

* 