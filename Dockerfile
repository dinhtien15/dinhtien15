FROM nginx:latest

<<<<<<< HEAD
ADD /web/ /usr/share/nginx/html/
=======
ADD /web/  /usr/share/nginx/html/
>>>>>>> ba8a620a0cc49bde137b047d4dae2c18b08b5e9b
RUN ["rm", "-f", "/etc/localtime"]
RUN ["ln", "-s", "/usr/share/zoneinfo/Asia/Ho_Chi_Minh", "/etc/localtime"]
RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf

EXPOSE 80

