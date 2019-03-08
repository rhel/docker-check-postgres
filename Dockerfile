FROM alpine:3.9 AS build
LABEL MAINTAINER="Artyom Nosov <chip@unixstyle.ru>"

RUN mkdir /src
WORKDIR /src

RUN wget -q -O check_postgres.tar.gz http://bucardo.org/downloads/check_postgres.tar.gz \
 && tar -xzf check_postgres.tar.gz --strip 1


FROM alpine:3.9
LABEL MAINTAINER="Artyom Nosov <chip@unixstyle.ru>"

RUN apk add --no-cache \
        perl \
        postgresql-client
COPY --from=build /src/check_postgres.pl /usr/local/bin/check_postgres
ENTRYPOINT [ "check_postgres" ]
