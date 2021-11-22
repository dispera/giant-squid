FROM uphold/litecoin-core:0.18.1@sha256:fb3148b0ca9fb3075ea7670c1690d4fa8bcf323d72a4c7192d8da235d95ee994

RUN sed -i 's/stable\/updates/stable-security/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y upgrade && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoclean && \
    apt-get autoremove

CMD ["litecoind --printtoconsole"]