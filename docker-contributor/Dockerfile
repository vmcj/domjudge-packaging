ARG ARCH=
FROM "${ARCH}ubuntu:jammy"
LABEL maintainer="DOMjudge team <team@domjudge.org>"

ENV DEBIAN_FRONTEND=noninteractive \
  CONTAINER_TIMEZONE=Europe/Amsterdam \
  UID=1000 \
  GID=1000 \
  MYSQL_HOST=mariadb \
  MYSQL_USER=domjudge \
  MYSQL_DATABASE=domjudge \
  MYSQL_PASSWORD=domjudge \
  MYSQL_ROOT_PASSWORD=domjudge \
  FPM_MAX_CHILDREN=40 \
  DJ_SKIP_MAKE=0 \
  DJ_DB_INSTALL_BARE=0 \
  PHPSUPPORTED="8.0 8.1 8.2 8.3" \
  DEFAULTPHPVERSION="8.3" \
  APTINSTALL="apt install -y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold"

# Install required packages and clean up afterwards to make this image layer smaller
RUN apt update
RUN apt install --no-install-recommends --no-install-suggests -y dumb-init
RUN apt install --no-install-recommends --no-install-suggests -y autoconf
RUN apt install --no-install-recommends --no-install-suggests -y automake
RUN apt install --no-install-recommends --no-install-suggests -y git
RUN apt install --no-install-recommends --no-install-suggests -y acl
RUN apt install --no-install-recommends --no-install-suggests -y gcc
RUN apt install --no-install-recommends --no-install-suggests -y g++
RUN apt install --no-install-recommends --no-install-suggests -y make
RUN apt install --no-install-recommends --no-install-suggests -y zip
RUN apt install --no-install-recommends --no-install-suggests -y unzip
RUN apt install --no-install-recommends --no-install-suggests -y mariadb-client
RUN apt install --no-install-recommends --no-install-suggests -y nginx
RUN apt install --no-install-recommends --no-install-suggests -y php8.1
RUN apt install --no-install-recommends --no-install-suggests -y php8.1-cli
RUN apt install --no-install-recommends --no-install-suggests -y php8.1-fpm
RUN apt install --no-install-recommends --no-install-suggests -y php8.1-zip
RUN apt install --no-install-recommends --no-install-suggests -y php8.1-gd
RUN apt install --no-install-recommends --no-install-suggests -y php8.1-curl
RUN apt install --no-install-recommends --no-install-suggests -y php8.1-mysql
RUN apt install --no-install-recommends --no-install-suggests -y php8.1-intl
RUN apt install --no-install-recommends --no-install-suggests -y php8.1-gmp
RUN apt install --no-install-recommends --no-install-suggests -y php8.1-xml
RUN apt install --no-install-recommends --no-install-suggests -y php8.1-mbstring
RUN apt install --no-install-recommends --no-install-suggests -y php8.1-xdebug
RUN apt install --no-install-recommends --no-install-suggests -y php8.1-pcov
RUN apt install --no-install-recommends --no-install-suggests -y bsdmainutils
RUN apt install --no-install-recommends --no-install-suggests -y ntp
RUN apt install --no-install-recommends --no-install-suggests -y lsof
RUN apt install --no-install-recommends --no-install-suggests -y linuxdoc-tools
RUN apt install --no-install-recommends --no-install-suggests -y linuxdoc-tools-text
RUN apt install --no-install-recommends --no-install-suggests -y groff
RUN apt install --no-install-recommends --no-install-suggests -y python3-sphinx
RUN apt install --no-install-recommends --no-install-suggests -y python3-sphinx-rtd-theme
RUN apt install --no-install-recommends --no-install-suggests -y python3-pip
RUN apt install --no-install-recommends --no-install-suggests -y fontconfig
RUN apt install --no-install-recommends --no-install-suggests -y python3-yaml
RUN apt install --no-install-recommends --no-install-suggests -y texlive-latex-recommended
RUN apt install --no-install-recommends --no-install-suggests -y texlive-latex-extra
RUN apt install --no-install-recommends --no-install-suggests -y texlive-fonts-recommended
RUN apt install --no-install-recommends --no-install-suggests -y texlive-lang-european
RUN apt install --no-install-recommends --no-install-suggests -y latexmk
RUN apt install --no-install-recommends --no-install-suggests -y sudo
RUN apt install --no-install-recommends --no-install-suggests -y debootstrap
RUN apt install --no-install-recommends --no-install-suggests -y libcgroup-dev
RUN apt install --no-install-recommends --no-install-suggests -y procps
RUN apt install --no-install-recommends --no-install-suggests -y default-jre-headless
RUN apt install --no-install-recommends --no-install-suggests -y default-jdk
RUN apt install --no-install-recommends --no-install-suggests -y supervisor
RUN apt install --no-install-recommends --no-install-suggests -y apache2-utils
RUN apt install --no-install-recommends --no-install-suggests -y lsb-release
RUN apt install --no-install-recommends --no-install-suggests -y libcurl4-gnutls-dev
RUN apt install --no-install-recommends --no-install-suggests -y libjsoncpp-dev
RUN apt install --no-install-recommends --no-install-suggests -y libmagic-dev
RUN apt install --no-install-recommends --no-install-suggests -y enscript
RUN apt install --no-install-recommends --no-install-suggests -y lpr
RUN apt install --no-install-recommends --no-install-suggests -y ca-certificates
RUN apt install --no-install-recommends --no-install-suggests -y less
RUN apt install --no-install-recommends --no-install-suggests -y vim
RUN apt install --no-install-recommends --no-install-suggests -y php-pear
RUN apt install --no-install-recommends --no-install-suggests -y php-dev
RUN apt install --no-install-recommends --no-install-suggests -y software-properties-common
RUN apt install --no-install-recommends --no-install-suggests -y python3-pygments
RUN apt install --no-install-recommends --no-install-suggests -y rst2pdf
RUN apt install --no-install-recommends --no-install-suggests -y gpg-agent
RUN apt install --no-install-recommends --no-install-suggests -y tex-gyre

RUN rm -rf /var/lib/apt/lists/*

# Forward nginx request and error logs to standard output/error. Also create directory for PHP-FPM socket
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
  && mkdir -p /run/php

# Set up users
RUN groupadd -g $GID domjudge \
  && useradd -u $UID -g $GID -m domjudge \
  && groupadd domjudge-run \
  && for id in $(seq 0 4); do useradd -d /nonexistent -g nogroup -s /bin/false "domjudge-run-$id"; done

# Install composer
RUN apt update && \
    apt install --no-install-recommends --no-install-suggests -y ca-certificates \
	&& rm -rf /var/lib/apt/lists/* \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php \
    && mv /composer.phar /usr/local/bin/composer

# Install all supported PHP versions
RUN add-apt-repository ppa:ondrej/php -y && apt update
RUN for VERSION in $PHPSUPPORTED; do \
        if [ "${VERSION}" != "8.1" ]; then \
            $APTINSTALL php${VERSION}; \
        fi; \
    done
RUN PACKAGES=$(dpkg-query -f '${binary:Package}\n' -W|grep "^php.*-"); \
    for PACKAGE in $PACKAGES; do \
        PACKAGEALLVERSIONS="" && \
        for VERSION in $PHPSUPPORTED; do \
            if [ "${VERSION}" != "8.1" ]; then \
                PACKAGEALLVERSIONS="$PACKAGEALLVERSIONS php${VERSION}-${PACKAGE#php*-}"; \
            fi; \
        done; \
        $APTINSTALL $PACKAGEALLVERSIONS; \
    done
RUN update-alternatives --set php /usr/bin/php${DEFAULTPHPVERSION}

# Set up alternatives for PHP-FPM
RUN for VERSION in $PHPSUPPORTED; do \
        PRIORTIY=$(echo ${VERSION} | tr -d '.'); \
        update-alternatives --install /usr/sbin/php-fpm php-fpm /usr/sbin/php-fpm${VERSION} ${PRIORTIY}; \
    done
RUN update-alternatives --set php-fpm /usr/sbin/php-fpm${DEFAULTPHPVERSION}

# Add PHP configuration
RUN mkdir /php-config
COPY ["php-config", "/php-config"]
RUN for VERSION in $PHPSUPPORTED; do \
        cp -Rf /php-config/* /etc/php/${VERSION}/cli/conf.d; \
        cp -Rf /php-config/* /etc/php/${VERSION}/fpm/conf.d; \
    done; \ 
    rm -Rf /php-config

# Disable Xdebug by default
RUN phpdismod xdebug

# Add scripts
COPY ["scripts", "/scripts/"]
RUN chmod 755 /scripts/start.sh \
  && chmod 755 /scripts/bin/* \
  && ln -s /scripts/bin/* /usr/bin/
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/scripts/start.sh"]

# Copy supervisor files
COPY ["supervisord.conf", "/etc/supervisor/"]
COPY ["supervisor", "/etc/supervisor/conf.d/"]
COPY ["sudoers-domjudge", "/etc/sudoers.d/domjudge"]
RUN chmod 440 /etc/sudoers.d/domjudge

USER domjudge

# Expose HTTP port
EXPOSE 80
