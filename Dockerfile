
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y \
make libperl-dev libpcre3 libpcre3-dev zlib1g \
zlib1g-dev openssl libssl-dev libxml2-dev libxslt1-dev \
libgd-dev libgeoip-dev google-perftools libgoogle-perftools-dev gcc g++ wget

WORKDIR /root

RUN wget https://nginx.org/download/nginx-1.20.0.tar.gz
RUN tar -xvzf nginx-1.20.0.tar.gz

RUN wget -P /tmp https://github.com/vkholodkov/nginx-upload-module/archive/2.3.0.tar.gz
RUN tar -zxvf /tmp/2.3.0.tar.gz -C /tmp

RUN mkdir /root/data

WORKDIR /root/nginx-1.20.0
# RUN cd nginx-1.20.0

RUN ./configure \
--sbin-path=/usr/local/sbin/nginx \
--conf-path=/usr/local/nginx/nginx.conf \
--pid-path=/var/run/nginx.pid \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_xslt_module \
--with-http_image_filter_module \
--with-http_geoip_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_auth_request_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_slice_module \
--with-http_degradation_module \
--with-http_stub_status_module \
--with-http_perl_module \
--with-mail \
--with-mail_ssl_module \
--with-stream \
--with-stream_ssl_module \
--with-google_perftools_module \
--with-cpp_test_module \
--with-debug \
--add-module=/tmp/nginx-upload-module-2.3.0

RUN make
RUN make install

RUN cat 

CMD ["/usr/local/sbin/nginx", "-g", "daemon off;"]


