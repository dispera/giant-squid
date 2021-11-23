# Technical exercises

## ex1
I found the ` uphold/docker-litecoin-core` docker image on Docker Hub.  
I had to build it, as the debian images have Critical vulnerabilities - and I wanted to play with it a bit.  
I used ubuntu 20.04 (LTS) image instead which has newer versions of the packages which fail the scan for the debian one - anchore/grype scans pass :)

For testing the image security with anchore, I first ran `anchore/inline-scan`:
`sudo docker build -t lite-squid:latest -f Dockerfile .`
`curl -s https://ci-tools.anchore.io/inline_scan-latest | sudo bash -s -- -f -d Dockerfile lite-squid:latest`

At this point I found `anchore inline scan` was being deprecated in a Jan 2022, and `grype` was the suggested alternative, so the `grype` approach would be, on mac:
```
brew tap anchore/grype
brew install grype
grype lite-squid:latest
```
`grype` scan shows no critical vulnerabilities:
```
grype lite-squid:latest
 ✔ Vulnerability DB        [updated]
 ✔ Loaded image
 ✔ Parsed image
 ✔ Cataloged packages      [140 packages]
 ✔ Scanned image           [50 vulnerabilities]

NAME                  INSTALLED                 FIXED-IN  VULNERABILITY     SEVERITY
bash                  5.0-6ubuntu1.1                      CVE-2019-18276    Low
coreutils             8.30-3ubuntu2                       CVE-2016-2781     Low
krb5-locales          1.17-6ubuntu4.1                     CVE-2021-36222    Medium
krb5-locales          1.17-6ubuntu4.1                     CVE-2018-5709     Negligible
libasn1-8-heimdal     7.7.0+dfsg-1ubuntu1                 CVE-2021-3671     Low
libc-bin              2.31-0ubuntu9.2                     CVE-2020-6096     Low
libc-bin              2.31-0ubuntu9.2                     CVE-2021-3326     Low
libc-bin              2.31-0ubuntu9.2                     CVE-2016-10228    Negligible
libc-bin              2.31-0ubuntu9.2                     CVE-2021-35942    Medium
libc-bin              2.31-0ubuntu9.2                     CVE-2021-33574    Low
libc-bin              2.31-0ubuntu9.2                     CVE-2021-38604    Medium
libc-bin              2.31-0ubuntu9.2                     CVE-2020-27618    Low
libc-bin              2.31-0ubuntu9.2                     CVE-2021-27645    Low
libc-bin              2.31-0ubuntu9.2                     CVE-2020-29562    Low
libc-bin              2.31-0ubuntu9.2                     CVE-2019-25013    Low
libc6                 2.31-0ubuntu9.2                     CVE-2020-6096     Low
libc6                 2.31-0ubuntu9.2                     CVE-2021-3326     Low
libc6                 2.31-0ubuntu9.2                     CVE-2016-10228    Negligible
libc6                 2.31-0ubuntu9.2                     CVE-2021-35942    Medium
libc6                 2.31-0ubuntu9.2                     CVE-2021-33574    Low
libc6                 2.31-0ubuntu9.2                     CVE-2021-38604    Medium
libc6                 2.31-0ubuntu9.2                     CVE-2020-27618    Low
libc6                 2.31-0ubuntu9.2                     CVE-2021-27645    Low
libc6                 2.31-0ubuntu9.2                     CVE-2020-29562    Low
libc6                 2.31-0ubuntu9.2                     CVE-2019-25013    Low
libgssapi-krb5-2      1.17-6ubuntu4.1                     CVE-2021-36222    Medium
libgssapi-krb5-2      1.17-6ubuntu4.1                     CVE-2018-5709     Negligible
libgssapi3-heimdal    7.7.0+dfsg-1ubuntu1                 CVE-2021-3671     Low
libhcrypto4-heimdal   7.7.0+dfsg-1ubuntu1                 CVE-2021-3671     Low
libheimbase1-heimdal  7.7.0+dfsg-1ubuntu1                 CVE-2021-3671     Low
libheimntlm0-heimdal  7.7.0+dfsg-1ubuntu1                 CVE-2021-3671     Low
libhx509-5-heimdal    7.7.0+dfsg-1ubuntu1                 CVE-2021-3671     Low
libk5crypto3          1.17-6ubuntu4.1                     CVE-2021-36222    Medium
libk5crypto3          1.17-6ubuntu4.1                     CVE-2018-5709     Negligible
libkrb5-26-heimdal    7.7.0+dfsg-1ubuntu1                 CVE-2021-3671     Low
libkrb5-3             1.17-6ubuntu4.1                     CVE-2021-36222    Medium
libkrb5-3             1.17-6ubuntu4.1                     CVE-2018-5709     Negligible
libkrb5support0       1.17-6ubuntu4.1                     CVE-2021-36222    Medium
libkrb5support0       1.17-6ubuntu4.1                     CVE-2018-5709     Negligible
libpcre3              2:8.39-12build1                     CVE-2020-14155    Negligible
libpcre3              2:8.39-12build1                     CVE-2017-11164    Negligible
libpcre3              2:8.39-12build1                     CVE-2019-20838    Low
libroken18-heimdal    7.7.0+dfsg-1ubuntu1                 CVE-2021-3671     Low
libsqlite3-0          3.31.1-4ubuntu0.2                   CVE-2020-9991     Low
libsqlite3-0          3.31.1-4ubuntu0.2                   CVE-2020-9849     Low
libsqlite3-0          3.31.1-4ubuntu0.2                   CVE-2020-9794     Medium
libtasn1-6            4.16.0-2                            CVE-2018-1000654  Negligible
libwind0-heimdal      7.7.0+dfsg-1ubuntu1                 CVE-2021-3671     Low
login                 1:4.8.1-1ubuntu5.20.04.1            CVE-2013-4235     Low
passwd                1:4.8.1-1ubuntu5.20.04.1            CVE-2013-4235     Low
```
## ex2
Check `ex2-k8s` folder.  
I added a service as it is required to define a StatefulSet, though we don't need it.
I was not aware of this constraint but seems like even a placeholder service needs to be defined which is what I did:
ref: https://github.com/kubernetes/kubernetes/issues/69608

## ex3
I picked Gitlab Sunday night and was liking it until.. they blocked my account for no reason and still could not get it unblocked -.-
Got "Your account has been blocked. Please contact your GitLab administrator if you think this is an error."
And that's on my Gitlab Ultimate trial. 
Support ticket = no response. 
Sales reached out to ask about my trial, I shared what happened = no respose. lol

I switched to Travis and found a good example for an inline scan on the official docs:
https://docs.anchore.com/current/docs/using/integration/ci_cd/inline_scanning/

The travis CI build passes OK (exit code 0). Anchore scan only shows a `warn` status.

I left the output of a Travis Build on `travis-build.out`

## ex4
Check `ex4-text-manupulation` folder.  
I found a page with the original poem about our favourite octopus, and had to filter that page for it.
I quickly used grep, sed, cut for that. 

## ex5
Check `ex5-text-manupulation` folder.  
Did the same, this time with python. Nothing fancy, using requests and BeautifulSoup from official docs.


## ex6
Check `ex6-text-manupulation` folder.  
I did the configuration, module, and added a README for the root and for the module.

---

## Notes/Issues:
* Gitlab blocked my account for no reason while just pushing code, which made me waste time switching CI solution -.-
(I left the .gitlab-ci.yml to show what I was doing. On the includes part, the only one needed was Security/Container-Scanning.gitlab-ci.yml, the rest were what I was testing just for fun as I had just found the templates, and sparked my interest)
It was my chance to finally test Travis CI, compared with Jenkins I like how clean Travis syntax looks (and not a fan of json) :P

* Two of the pgp keyservers stopped being resolvable for me so I had to remove them (from the original Dockerfile):
```
    # gpg --no-tty --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
    # gpg --no-tty --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \
```

* I separated the key fetch commands onto it's own layer as the updates take a while to test, and key servers timeouts meant doing that all over (image is bigger but saves time)

* I don't think the litecoin-core image can pass the anchore scans as even updating packages, it has libc6 ones with critical vulnerabilities,
so I think the compromise instead of re-building from the Dockerfile would have been to mention that and configure anchore to ignore those.
