#!/bin/bash

PHP_VERSION=5.6.40
XDEBUG_VERSION=XDEBUG_2_5_5
PHP_CONFIG=/usr/local/etc

wget https://www.php.net/distributions/php-${PHP_VERSION}.tar.gz
tar xvzf php-${PHP_VERSION}.tar.gz
cd /php-${PHP_VERSION} || exit
mkdir -v ${PHP_CONFIG}/conf.d

./buildconf --force
./configure \
  --build="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
  --with-config-file-path=${PHP_CONFIG} \
  --with-config-file-scan-dir=${PHP_CONFIG}/conf.d \
  --disable-cgi \
  --disable-fpm \
  --disable-phpdbg \
  --disable-opcache \
  --without-pear \
  --enable-bcmath \
  --with-curl \
  --enable-exif \
  --with-gd \
  --with-freetype-dir \
  --with-jpeg-dir \
  --with-png-dir \
  --enable-intl \
  --enable-mbstring \
  --enable-mysql \
  --with-mysqli \
  --with-pdo-mysql \
  --with-openssl \
  --with-zlib \
  --with-zlib-dir \
  --enable-zip \
  --with-libzip

make -j"$(nproc)"
make install
make clean

mv php.ini-development ${PHP_CONFIG}/php.ini

# xdebug
git clone https://github.com/xdebug/xdebug.git /php-${PHP_VERSION}/ext/xdebug
cd /php-${PHP_VERSION}/ext/xdebug || exit
git checkout ${XDEBUG_VERSION}
phpize
./configure \
  --enable-xdebug
make -j"$(nproc)"
make install
make clean

cd /
rm -fr /php-${PHP_VERSION}
rm /php-${PHP_VERSION}.tar.gz

{
  echo "zend_extension=xdebug.so"
  echo "xdebug.remote_host=host.docker.internal"
  echo "xdebug.remote_port=9009"
  echo "xdebug.remote_enable=1"
  echo "xdebug.remote_autostart=0"
} >> ${PHP_CONFIG}/conf.d/xdebug.ini

# install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"
