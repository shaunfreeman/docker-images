PHP Docker Files
================

Docker containers to provide PHP. Used in PhpStorm for setting up development environment easily and quickly. 

Exmaple `docker-compose.yaml`

    version: '3'
    
    services:
      php-cli:
        image: shaunfreeman/php:7.3-cli
        tty: true
        volumes:
          - .:/home/shaun
 
