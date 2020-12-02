FROM nginx

# Use Reverse Proxy Config
COPY nginx.conf /etc/nginx/nginx.conf

## Configure Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD run.sh /run.sh
RUN RUN apt-get update && apt-get -y install pwgen supervisor && chmod +x "/run.sh"

CMD ["/run.sh"]

EXPOSE 9050
