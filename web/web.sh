#!/bin/bash

web_conf=${nginx_install_dir}/conf/vhost/${server_name}.conf
cp web/conf/yii.conf $web_conf
sed -i "s#{root_path}#${default_web_dir}${server_name}#" $web_conf
sed -i "s#{log_path}#${default_log_dir}${nginx_prefix}#" $web_conf
sed -i "s#{server_name}#${server_name}#" $web_conf
sed -i "s#{server_frontend_port}#${server_frontend_port}#" $web_conf
sed -i "s#{server_backend_port}#${server_backend_port}#" $web_conf
service nginx restart

cd ${current_dir}
