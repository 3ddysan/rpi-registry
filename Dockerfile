FROM scratch

COPY ./bin/registry /bin/registry
COPY ./etc/config-example.yml /etc/config.yml

VOLUME ["/data"]
EXPOSE 5000
ENTRYPOINT ["/bin/registry"]
CMD ["serve", "/etc/config.yml"]
