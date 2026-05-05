#!/bin/bash

yum update -y
yum install -y  nginx

cat <<HTML > /usr/share/nginx/html/index.html
${html_content}
HTML

systemctl enable nginx
systemctl start nginx