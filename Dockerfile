FROM alpine as builder
WORKDIR /src

RUN apk add --no-cache build-base git \
    && git clone https://github.com/emikulic/darkhttpd.git \
    && cd /src/darkhttpd \
    && make darkhttpd-static \
    && strip darkhttpd-static

# Just the static binary
FROM scratch
# set label
LABEL maintainer="NG6"
WORKDIR /wwww
COPY --from=builder /src/darkhttpd/darkhttpd-static /darkhttpd
EXPOSE 80
VOLUME [ "/wwww" ]
ENTRYPOINT ["/darkhttpd"]
CMD [ "/www" ]
