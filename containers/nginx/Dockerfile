FROM nginx:1.13.5
RUN rm -f /etc/nginx/conf.d/*
ADD app.conf /etc/nginx/conf.d/app.conf
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
