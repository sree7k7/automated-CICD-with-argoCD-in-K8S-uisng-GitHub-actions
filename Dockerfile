FROM nginx
# RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
# RUN service apache2 restart
# COPY web-app.html /usr/local/apache2/htdocs/index.html
COPY web-app.html /usr/share/nginx/html/index.html
# EXPOSE 8080
RUN echo "hello world"
# RUN sed -i -e 's/Listen 80/Listen 80\nServerName localhost/' /etc/apache2/ports.conf

# ENTRYPOINT ["/usr/local/apache2/htdocs/index.html"]
