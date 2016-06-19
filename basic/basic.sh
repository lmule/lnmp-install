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

# Check if user is root
#if [ $(id -u) != "0" ]; then
    #echo "Error: You must be root to run this script, please use root to install lnmp"
    #exit 1
#fi
