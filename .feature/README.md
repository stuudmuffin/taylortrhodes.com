### Feature branch setup
You'll need a cert on your proxy server
```
sudo apt install certbot python3-certbot-dns-cloudflare
certbot certonly --dns-cloudflare --dns-cloudflare-credentials ~/.secrets/cloudflare.ini --preferred-challenges dns -d '*.feat.taylortrhodes.com' -d feat.taylortrhodes.com

# cronjob to reload nginx every now and then in case the cert renews
1 1 * * 1 /bin/bash /root/scripts/renew_certbot.sh > /root/scripts/log/certbot.log; # my bash file only contains the nginx reload command
```
I currently am double proxying my feature branches. The first proxy is handling the domain pointer, the second proxy is running on the same vm as the other feature containers. It uses a docker network to route the request to the correct feature container if available.

```
# on first proxy
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name *.feat.taylortrhodes.com;
    include /etc/nginx/snippets/feat.taylortrhodes.com;

    # Forwarded headers
    location / {
        proxy_pass http://feature_vm_ip:8083;
        proxy_set_header Host              $host;
        proxy_set_header X-Real-IP         $remote_addr;
        proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

On the feature vm, the feature proxy should try to configure itself automatically as needed via ci/cd. As long as the first proxy is pointing here correctly, the feature containers should load.
