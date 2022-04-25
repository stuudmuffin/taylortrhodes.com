# taylortrhodes.com

open repo that displays my resume website

## Getting started

I've got a server at home for fun test builds, high power processing, and file storage. I'm running [K3S](https://k3s.io/) while I learn Kubernetes better. To keep usage on my cloud server lower (it's not a big machine, keeps cost cheap), I have gitlab-runner on my home server to save on processing and memory constrains in the cloud.

The real trick was getting this K3S cluster to properly build docker images. But alas, it's working!

### Step 1
Kubernetes builds the docker image, and uploads it to gitlab.

### Step 2
Kubernetes logs into the cloud server via ssh and attempts to startup the docker image

My cloud server is running nginx, which just proxies the traffic to the docker contianer. This way I can also handle SSL with the host system, and don't have to worry about it inside the container.

And that's pretty much it. I'll get more details guides here in future updates as time goes on.