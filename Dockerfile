FROM busybox
RUN mkdir /public && echo "hello" > /public/index.html

FROM scratch
COPY --from=0 /public/index.html /public/index.html
ADD ./darkhttpd /darkhttpd
ENTRYPOINT ["/darkhttpd"]
CMD ["/public"]
