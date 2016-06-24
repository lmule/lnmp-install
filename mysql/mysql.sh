#!/bin/bash

cd temp
wget -c --no-check-certificate --progress=bar:force ${php_wget_url}
mkdir ${php_prefix}
tar xzvf ${php_tgz_name} -C ${php_prefix} --strip-components 1
cd ${php_prefix}
./configure --prefix=${php_install_dir} --with-config-file-path=${php_install_dir}/etc --with-config-file-scan-dir=${php_install_dir}/etc --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-zlib --with-xmlrpc --enable-xml --enable-mbstring --with-gd --with-jpeg-dir --with-png-dir --with-pear --enable-sockets --enable-gd-native-ttf --enable-sysvsem --enable-sysvshm --enable-shmop --enable-zip --enable-fpm --with-mhash --enable-bcmath --enable-inline-optimization --with-curl --enable-mbregex --with-openssl --with-bz2 --enable-ftp --with-mcrypt --with-pdo-mysql --with-freetype-dir --enable-intl
make
make install

ln -sf ${php_install_dir}${php_prefix}/bin/php /usr/bin/php
ln -sf ${php_install_dir}${php_prefix}/bin/phpize /usr/bin/phpize
ln -sf ${php_install_dir}${php_prefix}/bin/pear /usr/bin/pear
ln -sf ${php_install_dir}${php_prefix}/bin/pecl /usr/bin/pecl

cd ${current_dir}/${php_prefix}
mkdir -p ${php_install_dir}etc/
cp -r ./etc/php.ini ${php_install_dir}etc/
cp -r ./etc/php-fpm.conf ${php_install_dir}etc/

cp php-fpm.d /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
chkconfig --add php-fpm
chkconfig --level 345 php-fpm on

service php-fpm start

#curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

cd ${current_dir}
