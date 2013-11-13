FROM ubuntu:precise

# REDIS
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install redis-server

# NGINX / OPEN RESTY
RUN apt-get install -y libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make nano wget
RUN wget -O /tmp/openresty.tar.gz http://openresty.org/download/ngx_openresty-1.4.2.8.tar.gz
RUN cd /tmp && tar xzvf openresty.tar.gz
RUN cd /tmp/ngx_openresty-1.4.2.8 && ./configure --with-luajit && make && make install

ENV PATH /usr/local/openresty/nginx/sbin:$PATH

EXPOSE 80
ADD . /app

RUN chown -R root:root /app

CMD /etc/init.d/redis-server start && nginx -p /app/ -c conf/nginx.conf -g "daemon off;"
