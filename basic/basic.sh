PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#添加www用户组
egrep "^$default_web_user" /etc/group >& /dev/null  
if [ $? -ne 0  ]  
then  
    groupadd $default_web_user
fi  

#添加www用户
egrep "^$default_web_user" /etc/passwd >& /dev/null  
if [ $? -ne 0  ]  
then  
    useradd -M -g $default_web_user -c 'Web User' -s /sbin/nologin $default_web_user
fi

#添加mysql用户组
egrep "^$default_mysql_user" /etc/group >& /dev/null  
if [ $? -ne 0  ]  
then  
    groupadd $default_mysql_user
fi  

#添加mysql用户
egrep "^$default_mysql_user" /etc/passwd >& /dev/null  
if [ $? -ne 0  ]  
then  
    useradd -M -g $default_mysql_user -c 'Mysql User' -s /sbin/nologin $default_mysql_user
fi
yum -y install gcc gcc-c++ ntp make openssl openssl-devel cmake pcre pcre-devel libpng libpng-devel libjpeg-6b libjpeg-devel-6b freetype freetype-devel gd gd-devel zlib zlib-devel  gcc-c++ libXpm libXpm-devel ncurses ncurses-devel libmcrypt libmcrypt-devel libxml2 libxml2-devel imake autoconf automake screen sysstat compat-libstdc++-33 curl curl-devel perl bzip2 bzip2-devel bzip2-libs python python-setuptools bison bison-devel bison-runtime libtool libevent dos2unix rsync ImageMagick ImageMagick-perl ImageMagick-devel icu libicu libicu-devel readline-devel  libaio-devel

# Check if user is root
#if [ $(id -u) != "0" ]; then
    #echo "Error: You must be root to run this script, please use root to install lnmp"
    #exit 1
#fi
