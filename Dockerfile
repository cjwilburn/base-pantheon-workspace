#
#--------------------------------------------------------------------------
# Pantheon Workspace Base Image Setup
#--------------------------------------------------------------------------
#

FROM phusion/baseimage:latest

MAINTAINER Courtney Wilburn <courtney@cjwilburn.com>

RUN DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

# Add the "PHP 7" ppa
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ondrej/php

#
#--------------------------------------------------------------------------
# Software's Installation
#--------------------------------------------------------------------------
#

# Install "PHP Extentions", "libraries", "Software's"
RUN apt-get update && \
    apt-get install -y --allow-downgrades --allow-remove-essential \
        --allow-change-held-packages \
        php5.6-cli \
        php5.6-common \
        php5.6-curl \
        php5.6-json \
        php5.6-xml \
        php5.6-mbstring \
        php5.6-mcrypt \
        php5.6-mysql \
        php5.6-pgsql \
        php5.6-sqlite \
        php5.6-sqlite3 \
        php5.6-zip \
        php5.6-bcmath \
        php5.6-memcached \
        php5.6-gd \
        php5.6-dev \
        pkg-config \
        libcurl4-openssl-dev \
        libedit-dev \
        libssl-dev \
        libxml2-dev \
        xz-utils \
        libsqlite3-dev \
        sqlite3 \
        git \
        curl \
        wget \
        vim \
        nano \
        postgresql-client \
    && apt-get clean

#####################################
# Composer:
#####################################

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer

#####################################
# Drush:
#####################################

# Install Drush and add its bin to the PATH.
RUN curl -O http://files.drush.org/drush.phar && \
    php drush.phar core-status \
    chmod +x drush.phar \
    mv drush.phar /usr/local/bin/drush \
    drush init

#####################################
# Terminus:
#####################################

# Install Terminus and add its bin to the PATH.
RUN curl -O https://raw.githubusercontent.com/pantheon-systems/terminus-installer/master/builds/installer.phar && php installer.phar install
#    echo "export PATH=${PATH}:/usr/local/bin/terminus/bin" >> ~/.bashrc

# Source the bash
RUN . ~/.bashrc
