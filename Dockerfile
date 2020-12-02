FROM nginx

# Use Reverse Proxy Config
COPY nginx.conf /etc/nginx/nginx.conf

## Configure Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD run.sh /run.sh
RUN chmod +x run.sh

CMD ["/run.sh"]

EXPOSE 9050
