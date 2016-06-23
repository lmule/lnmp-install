#!/bin/bash

current_dir=$(pwd)
mkdir -p temp

. ./lnmp.conf
. ./basic/basic.sh
. ./nginx/nginx.sh
