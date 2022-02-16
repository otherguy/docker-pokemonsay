FROM perl:5.34-slim

# Required to prevent warnings
ARG DEBIAN_FRONTEND=noninteractive
ARG DEBCONF_NONINTERACTIVE_SEEN=true

WORKDIR /workdir

# Install
RUN apt-get update \
 && apt-get install -y --no-install-recommends --fix-missing \
       ca-certificates git openssl cowsay \
  && git clone git://github.com/possatti/pokemonsay \
  && cd pokemonsay \
  && sh install.sh \
  && apt-get purge -y \
       ca-certificates git openssl \
  && rm -rf /var/lib/apt/lists/*

# Set path to /usr/games/
ENV PATH /usr/games:$PATH

# Build arguments
ARG VCS_REF=master
ARG BUILD_DATE=""
ARG VERSION="${VCS_REF}"

# http://label-schema.org/rc1/
LABEL org.label-schema.schema-version         '1.0'
LABEL org.label-schema.name                   'pokemonsay'
LABEL org.label-schema.version                '1.0'
LABEL org.label-schema.description            'Pokemonsay is is like "cowsay" but for pokémon.'
LABEL org.label-schema.vcs-url                'https://github.com/otherguy/docker-pokemonsay'
LABEL org.label-schema.version                '${VERSION}'
LABEL org.label-schema.build-date             '${BUILD_DATE}'
LABEL org.label-schema.vcs-ref                '${VCS_REF}'

# Maintainer
LABEL maintainer                              'otherguy <hi@otherguy.io>'

# Whalebrew
LABEL io.whalebrew.name                       'pokemonsay'
LABEL io.whalebrew.config.keep_container_user 'true'

ENTRYPOINT ["/root/bin/pokemonsay"]
