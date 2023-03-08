FROM nginx
COPY index.html /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d
EXPOSE 80
ENV NGINX_PORT=80
CMD ["nginx-debug", "-g", "daemon off;"]