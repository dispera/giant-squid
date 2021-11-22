# Some k8s fun!

I used kind for a local cluster for tests.

I loaded this config for a hostpath mount:  
`kind create cluster --config kind-config.yaml`

To load the image we build  earlier into the local kind cluster:  
`kind load docker-image lite-squid:latest`

-------

## SO FAR SO GOOD, BUT THE ABOVE DOES NOT WORK -.-
I found you need to run also a registry as a container, you cannot load a local docker image from your machine into kind.

I was not able to test my local image with Kind, unless I also created a local registry,
so took the base from https://kind.sigs.k8s.io/docs/user/local-registry/ for that,
and added the hostPath mount configuration for the StorageClass, PV, and PVC.

So just: `./kind-with-registry.sh` to use kind (added comments into the script) to launch the Kind cluster with a local registry.

Then tag the image and push it to the containerized kind registry:
`docker tag lite-squid:latest localhost:5000/lite-squid:latest`
`docker push localhost:5000/lite-squid:latest`

All good. With the cluster up, we could add our resources (but I added that to  the script we run to start the cluster, so all good!)
For reference:
`kubectl apply -f litecoind.yaml`
```
namespace/squid created
storageclass.storage.k8s.io/local-storage created
persistentvolume/data created
service/litecoind created
statefulset.apps/litecoind created
```

Success!
```
kubectl get pods -n squid
NAME          READY   STATUS    RESTARTS   AGE
litecoind-0   1/1     Running   0          62s
```

```
kubectl logs litecoind-0 -n squid
...
2021-11-22T23:46:04Z init message: Done loading
2021-11-22T23:46:05Z 84 addresses found from DNS seeds
2021-11-22T23:46:05Z dnsseed thread exit
2021-11-22T23:46:06Z New outbound peer connected: version: 70015, blocks=2162790, peer=0
2021-11-22T23:46:09Z New outbound peer connected: version: 70015, blocks=2162790, peer=1
```

```
kubectl get all -n squid
NAME              READY   STATUS    RESTARTS   AGE
pod/litecoind-0   1/1     Running   0          4m7s

NAME                TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/litecoind   ClusterIP   None         <none>        80/TCP    4m17s

NAME                         READY   AGE
statefulset.apps/litecoind   1/1     4m18s
```

And on my host, I can see `/tmp/litecoin` (the dir I configured for the hostPath), has been populated after running the container:
```
ls -l /tmp/litecoin
total 2856
-rw-------  1 diego  wheel       37 Nov 23 00:45 banlist.dat
drwx------  4 diego  wheel      128 Nov 23 00:45 blocks
drwx------  6 diego  wheel      192 Nov 23 00:45 chainstate
drwx------  6 diego  wheel      192 Nov 23 00:46 database
-rw-------  1 diego  wheel        0 Nov 23 00:45 db.log
-rw-------  1 diego  wheel     6252 Nov 23 00:50 debug.log
-rw-------  1 diego  wheel        2 Nov 23 00:45 litecoind.pid
-rw-------  1 diego  wheel     4178 Nov 23 00:46 peers.dat
-rw-------  1 diego  wheel  1437696 Nov 23 00:46 wallet.dat
```