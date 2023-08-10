# syntax=docker/dockerfile:1
# FROM busybox:latest
# COPY --chmod=755 <<EOF /app/run.sh
# #!/bin/sh
# while true; do
#  echo -ne "The time is now $(date +%T)\\r"
#  sleep 1
# done
# EOF

# ENTRYPOINT /app/run.sh
FROM httpd:2.4
COPY web-app.html /usr/local/apache2/htdocs/index.html
EXPOSE 8080
# ENTRYPOINT ["/usr/local/apache2/htdocs/index.html"]
