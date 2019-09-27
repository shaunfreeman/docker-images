PHP Images
================

Docker container to provide PHP on the command line. Used in PhpStorm for setting up development environment easily and quickly. PHP modules enabled

Exmaple `docker-compose.yaml`

    version: '3'
    
    services:
      php-cli:
        image: shaunfreeman/php:7.3-cli
        tty: true

PHP modules enabled
-------------------
[PHP Modules]
 * calendar
 * Core
 * ctype
 * date
 * dom
 * exif
 * fileinfo
 * filter
 * ftp
 * gettext
 * hash
 * iconv
 * json
 * libxml
 * mysql_xdevapi
 * mysqli
 * mysqlnd
 * openssl
 * pcntl
 * pcre
 * PDO
 * pdo_mysql
 * Phar
 * posix
 * readline
 * Reflection
 * session
 * shmop
 * SimpleXML
 * sockets
 * sodium
 * SPL
 * standard
 * sysvmsg
 * sysvsem
 * sysvshm
 * tokenizer
 * uopz
 * wddx
 * xdebug
 * xml
 * xmlreader
 * xmlwriter
 * xsl
 * Zend OPcache
 * zlib

[Zend Modules]
 * Xdebug
 * Zend OPcache
