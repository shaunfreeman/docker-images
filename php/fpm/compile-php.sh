#!/bin/bash

PHP_VERSION=7.3.10
MYSQL_XDEVAPI_VERSION=8.0.17
PHP_CONFIG=/usr/local/etc

export CFLAGS="-fstack-protector-strong -fpic -fpie -O2" \
    CPPFLAGS="$CFLAGS" \
    LDFLAGS="-Wl,-O1 -Wl,--hash-style=both -pie"

wget https://www.php.net/distributions/php-${PHP_VERSION}.tar.gz
tar xvzf php-${PHP_VERSION}.tar.gz
mkdir -v ${PHP_CONFIG}/conf.d
mkdir -v ${PHP_CONFIG}/php-fpm.d

cd /php-${PHP_VERSION}

./buildconf --force
./configure \
    --build=$(dpkg-architecture --query DEB_BUILD_GNU_TYPE) \
    --with-config-file-path=${PHP_CONFIG} \
	--with-config-file-scan-dir=${PHP_CONFIG}/conf.d \
    --disable-cgi \
    --enable-fpm \
    --with-fpm-user=www-data \
    --with-fpm-group=www-data \
    --without-pear \
    --disable-phpdbg \
    --enable-bcmath \
    --with-curl \
    --enable-exif \
    --with-gd \
    --with-freetype-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --enable-intl \
    --enable-mbstring \
    --enable-mysqlnd \
    --with-mysqli \
    --with-pdo-mysql \
    --with-openssl \
    --with-zlib \
    --with-zlib-dir
make -j"$(nproc)"
make install
make clean

mv php.ini-development ${PHP_CONFIG}/php.ini

# mysql_xdevapi
git clone https://github.com/php/pecl-database-mysql_xdevapi.git /php-${PHP_VERSION}/ext/mysql_xdevapi
cd /php-${PHP_VERSION}/ext/mysql_xdevapi
git checkout ${MYSQL_XDEVAPI_VERSION}
phpize
./configure \
    --enable-mysql-xdevapi \
    --with-boost \
    --with-protobuf
make -j"$(nproc)"
make install
make clean

cd /
rm -fr /php-${PHP_VERSION}
rm /php-${PHP_VERSION}.tar.gz

mv ${PHP_CONFIG}/php-fpm.d/www.conf.default ${PHP_CONFIG}/php-fpm.d/00default.conf
mv /tmp/fpm-pool.conf ${PHP_CONFIG}/php-fpm.d/www.conf

sed 's!=NONE/!=!g' ${PHP_CONFIG}/php-fpm.conf.default | tee ${PHP_CONFIG}/php-fpm.conf > /dev/null

echo "extension=mysql_xdevapi.so" > ${PHP_CONFIG}/conf.d/mysql_xdevapi.ini
echo "zend_extension=opcache.so" > ${PHP_CONFIG}/conf.d/opcache.ini