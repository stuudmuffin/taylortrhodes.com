# serves /srv at :8080, logs to stdout/stderr
FROM caddy:2-alpine
COPY Caddyfile /etc/caddy/Caddyfile
COPY src/ /srv
EXPOSE 8080
