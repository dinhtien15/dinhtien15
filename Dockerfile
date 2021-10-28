FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html
COPY DockerFileEx.jpg /usr/share/nginx/html/DockerFileEx.jpg
RUN ["rm", "-f", "/etc/localtime"]
RUN ["ln", "-s", "/usr/share/zoneinfo/Asia/Ho_Chi_Minh", "/etc/localtime"]
RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf

EXPOSE 80

