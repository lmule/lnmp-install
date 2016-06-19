#!/bin/bash

cd temp
#wget -c --progress=bar:force ${nginx_wget_url}
echo $nginx_tgz_name
tar xzvf ${nginx_tgz_name} -C ${nginx_prefix}
cd ${nginx_prefix}
./configure 
    --user=${default_web_user} \
    --group=${default_web_user} \
    --prefix=${nginx_install_dir} \
    --conf-path=${nginx_install_dir}conf/nginx.conf \
    --pid-path=${nginx_install_dir}nginx.pid \
    --http-log-path=${default_log_dir}${nginx_prefix}/access.log \
    --error-log-path=${default_log_dir}${nginx_prefix}/error.log \
    --with-http_ssl_module \
    --with-http_realip_module 
    --with-http_gzip_static_module \
make
make install

ln -sf ${nginx_install_dir}${nginx_prefix}/sbin/nginx /usr/bin/nginx
cd ${current_dir}/${nginx_prefix}
cp nginx.d /etc/init.d/nginxd
chmod +x /etc/init.d/nginxd
cp -r ./conf ${nginx_install_dir}conf/
chkconfig --add nginxd
chkconfig --level 345 nginxd on

mkdir -p ${default_web_dir}
chown -R ${default_web_user}:${default_web_user} ${default_web_dir}

cd ${current_dir}
