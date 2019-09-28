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
* bcmath
* Core
* ctype
* curl
* date
* dom
* exif
* fileinfo
* filter
* gd
* hash
* iconv
* intl
* json
* libxml
* mbstring
* mysql_xdevapi
* mysqli
* mysqlnd
* openssl
* pcre
* PDO
* pdo_mysql
* pdo_sqlite
* Phar
* posix
* Reflection
* session
* SimpleXML
* SPL
* sqlite3
* standard
* tokenizer
* uopz
* xdebug
* xml
* xmlreader
* xmlwriter
* Zend OPcache
* zlib

[Zend Modules]
 * Xdebug
 * Zend OPcache
