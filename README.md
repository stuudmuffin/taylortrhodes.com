# taylortrhodes.com

open repo that displays my resume website

I've got a server at home for personal education that's running [K3S](https://k3s.io/) while I learn Kubernetes better. I also have a gitlab runner on this machine to reduce the free-minutes I use in Gitlab.

## Getting started

I currently have two deployment methods:
1) Docker with Nginx Proxy
2) AWS S3 and CloudFront


### 1 Docker with Nginx Proxy
CI Job builds the docker image, and uploads it to the gitlab repositories container registry.

A second job logs into the cloud server via ssh and attempts to pull and startup the docker image

My cloud server is running nginx, which just proxies the traffic to the docker contianer. This way I can also handle SSL with the host system across multiple containers, and don't have to worry about SSL inside the container.

### 2 AWS S3 and CloudFront
First you have to create your bucket. It's okat to make the bucket NOT public.
Second you create a CloudFront distribution, and use an OAI (Origin Access Identity). This allows the specific cloudfront distribution permissions to access the S3 Bucket objects.
Now you can use AWS Access Key Credentials in the CI to push updates to the bucket.