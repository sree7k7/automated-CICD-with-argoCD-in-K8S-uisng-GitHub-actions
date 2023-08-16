FROM --platform=linux/x86_64/v8 httpd:2.4
COPY web-app.html /usr/local/apache2/htdocs/index.html
EXPOSE 8080
# ENTRYPOINT ["/usr/local/apache2/htdocs/index.html"]

