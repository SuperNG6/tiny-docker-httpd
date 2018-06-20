FROM busybox
RUN mkdir /file && echo "hello" > /file/index.html

FROM scratch
COPY --from=build /file/index.html /file/index.html
ADD ./darkhttpd /darkhttpd
ENTRYPOINT ["/darkhttpd"]
CMD ["/file"]
