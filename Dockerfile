FROM php:8.1-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
  libfreetype6-dev \ 
  libicu-dev \ 
  libjpeg62-turbo-dev \ 
  libmcrypt-dev \ 
  libpng-dev \ 
  libxslt1-dev \ 
  sendmail-bin \ 
  sendmail \ 
  sudo \ 
  libzip-dev \ 
  libonig-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure \
  gd --with-freetype --with-jpeg
# Install PHP extensions
RUN docker-php-ext-install \
  dom \ 
  gd \ 
  intl \ 
  mbstring \ 
  pdo_mysql \ 
  xsl \ 
  zip \ 
  soap \ 
  bcmath \ 
  pcntl \ 
  sockets
RUN pecl install -o -f xdebug
# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html/magento2