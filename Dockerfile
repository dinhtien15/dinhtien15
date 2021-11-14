FROM nginx:latest

ADD /web/ /usr/share/nginx/html/
RUN ["rm", "-f", "/etc/localtime"]
RUN ["ln", "-s", "/usr/share/zoneinfo/Asia/Ho_Chi_Minh", "/etc/localtime"]
RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf

EXPOSE 80

