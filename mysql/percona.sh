#!/bin/bash

mkdir ${default_log_dir}${percona_prefix} 

cd temp
#wget -c --no-check-certificate --progress=bar:force ${percona_wget_url}
#mkdir -p ${percona_prefix}
#tar xzvf percona-server-5.6.30-76.3.tar.gz -C ${percona_prefix} --strip-components 1
cd ${percona_prefix}
mkdir -p ${percona_install_dir}etc
cmake . -DCMAKE_INSTALL_PREFIX=${percona_install_dir} -DMYSQL_DATADIR=${percona_install_dir}data -DSYSCONFDIR=${percona_install_dir}etc -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_PERFSCHEMA_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DMYSQL_UNIX_ADDR=${percona_install_dir}mysqld.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DMYSQL_USER=${default_mysql_user}
make
make install

cd ${current_dir}/${percona_prefix}
cp -r ./etc/my.cnf ${percona_install_dir}etc/
${percona_install_dir}scripts/mysql_install_db --user=${default_mysql_user} --basedir=${percona_install_dir} --datadir=${percona_install_dir}data --defaults-file=${percona_install_dir}etc/my.cnf
${percona_install_dir}bin/mysqld_safe &
#mysqladmin -h 127.0.0.1 -u root password 123456 2>/dev/null
${percona_install_dir}bin/mysqladmin -h 127.0.0.1 -u root password ${percona_default_password} 2>/dev/null
chown -R ${default_mysql_user}:${default_mysql_user} ${percona_install_dir}

cp ${current_dir}/temp/${percona_prefix}/support-files/mysql.server /etc/init.d/mysql
chmod +x /etc/init.d/mysql
chkconfig --add mysql
chkconfig --level 345 mysql on

cd ${current_dir}
