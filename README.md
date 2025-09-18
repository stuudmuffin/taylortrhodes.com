# taylortrhodes.com

open repo that displays my resume website

I've got a homelab running Proxmox. I'm running gitlab runner, and a dev vm for developing deployments. CI/CD will create new continers for feature branch commits. The system limits a maximum of featuer containers at one time, and they all are removed at 2am local time regardless. Re-running the pipeline can always bring that feature back online again. 

### 1 Docker Deployments
CI Job builds the docker image, and uploads it to the gitlab repositories container registry.

Next job logs into the destination server via ssh and attempts to pull and startup the docker image

Deployments URLs are proxied to their respective host locations.

### 2 Digital Ocean Deploy
Using shared gitlab runners, the deploy job can use Digital Oceans (DO) Rest Api to open an ssh port for deployment. The job will remove the port when finished. Since I'm also running a gitlab-runner in my homelab, this port opening is no longer needed, as my home has other access to the cloud host environment.

### AWS S3 and CloudFront (Currently Unused)
First you have to create your bucket. It's okay to make the bucket NOT public.
Second you create a CloudFront distribution, and use an OAI (Origin Access Identity). This allows the specific cloudfront distribution permissions to access the S3 Bucket objects.
Now you can use AWS Access Key Credentials in the CI to push updates to the bucket.