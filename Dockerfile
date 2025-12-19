FROM mediawiki:latest

USER root

RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    make \
    && rm -rf /var/lib/apt/lists/*

RUN cd /usr/local/etc/php && \
    docker-php-ext-configure pgsql --with-pgsql=/usr && \
    docker-php-ext-install -j$(nproc) pgsql pdo_pgsql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN chmod 664 composer.json
RUN chmod 775 .
RUN composer require mediawiki/semantic-media-wiki "~6.0.1" --update-no-dev

#在 LocalSettings.php 末尾追加两行（顺序不能反）：
#wfLoadExtension( 'SemanticMediaWiki' );
#enableSemantics( 'http://wiki.feg.cn' );   // 与 $wgServer 保持一致
# 屏蔽所有 E_USER_DEPRECATED
#error_reporting( E_ALL & ~E_USER_DEPRECATED );
#ini_set( 'display_errors', 0 );

USER www-data

# root
# php maintenance/update.php --quick

