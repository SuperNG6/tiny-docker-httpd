FROM debian as builder
# compiling static darkhttpd
RUN apt-get -y update \
&& apt-get -y install build-essential make curl wget unzip git \
&& cd /tmp \
&& git clone https://github.com/SuperNG6/tiny-docker-httpd.git \
&& cd /tmp/tiny-docker-httpd \
&& make

# install darkhttpd
FROM scratch
# set label
LABEL maintainer="NG6"
# copy AriaNg
COPY --from=builder /tmp/tiny-docker-httpd/darkhttpd /darkhttpd
# darkhttpd port
EXPOSE 80
# html
VOLUME [ "/www" ]
# start darkhttpd
ENTRYPOINT [ "/darkhttpd" ]
CMD [ "/www" ]
