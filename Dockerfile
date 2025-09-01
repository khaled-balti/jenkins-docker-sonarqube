FROM nginx:alpin
COPY src/ /usr/share/nginx/html
EXPOSE 80
