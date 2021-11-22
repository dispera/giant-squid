# Best crypto exchange exercise

## ex1
I found the official `litecoin-core` docker image on Docker Hub.
For testing the image security with anchore, I first ran `anchore/inline-scan`:
`sudo docker build -t lite-squid:latest -f Dockerfile .`
`curl -s https://ci-tools.anchore.io/inline_scan-latest | sudo bash -s -- -f -d Dockerfile lite-d:latest`

At this point I found `anchore inline scan` was being deprecated in a Jan 2022, and `grype` was the suggested alternative, so the `grype` approach would be, on mac:
```
brew tap anchore/grype
brew install grype
grype lite-d:latest
```

## ex2
I picked Gitlab Sunday night and was liking it until.. they blocked my account for no reason and still could not get it unblocked -.-
Got "Your account has been blocked. Please contact your GitLab administrator if you think this is an error."
And that's on my Gitlab Ultimate trial. 
Support ticket = no response. 
Sales reached out to ask about my trial, I shared what happened = no respose. lol

I switched to Travis and found a good example for an inline scan on the official docs:
https://docs.anchore.com/current/docs/using/integration/ci_cd/inline_scanning/


## ex3


## ex4


## ex5
I found a page with the original poem about our favourite octopus, and had to filter that page for it.
I quickly used grep, sed, cut for that.

## ex6
Did the same, this time with python. Nothing fancy, using requests and BeautifulSoup from official docs.

---

## Issues:
* Gitlab blocked my account for no reason while just pushing code, which made me waste time switching CI solution -.-
(I left the .gitlab-ci.yml to show what I was doing. On the includes part, the only one needed was Security/Container-Scanning.gitlab-ci.yml, the rest were what I was testing just for fun as I had just found the templates, and sparked my interest)
It was my chance to finally test Travis CI, compared with Jenkins I like how clean Travis syntax looks (and not a fan of json) :P

* The litecoin-core image from upbound does not have an arm build, not good for testing on my M1 mac -.-  
Couple that with no builds in 8 months, no wonder litecoin is not so hot nowadays.

* Two of the pgp keyservers stopped being resolvable for me so I had to remove them (from the original Dockerfile):
    # gpg --no-tty --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
    # gpg --no-tty --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \

* I separated the key fetch commands onto it's own layer as the updates take a while to test, and key servers timeouts meant doing that all over (image is bigger but saves time)

* I don't think the litecoin-core image can pass the anchore scans as even updating packages, it has libc6 ones with critical vulnerabilities,
so I think the compromise instead of re-building from the Dockerfile would have been to mention that and configure anchore to ignore those.