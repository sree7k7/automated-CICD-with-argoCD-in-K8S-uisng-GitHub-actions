FROM --platform=linux/amd64 nginx
# COPY web-app.html /usr/local/apache2/htdocs/index.html
# EXPOSE 8080
# ENTRYPOINT ["/usr/local/apache2/htdocs/index.html"]

RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"