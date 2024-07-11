#!/usr/bin/env bash
#SETUP WEB STATIC

##############################
# Install Nginx If Unavailable
##############################
word='nginx'
if ! dpkg -l | grep -F -q "ii  $word"; then
	apt-get install -y nginx
fi
if ! service --status-all | grep -F -q "[+] ${word}"; then
	service ${word} start
fi

##############################
#Generating static directories
##############################
mkdir -p /data/web_static/releases/test
mkdir -p /data/web_static/shared

#############################
#Generate index.html
#############################
#echo 'Generating index.html...'
cat >  /data/web_static/releases/test/index.html << EOF
<!DOCTYPE html>
<html>
	<head>
	</head>
	<body>
		Helberton School
	</body>
</html>
EOF

#############################
#Generate simulink
#############################
if [[ -L  /data/web_static/current ]]; then
	#echo 'Deleting simulink...'
	rm /data/web_static/current
fi	

#echo 'Creating simulink...'
ln -s  /data/web_static/releases/test /data/web_static/current

#############################
#Set Ownership
#############################
#echo 'Setting User Ownershop...'
chown -R ubuntu:ubuntu /data

#############################
#Modifiy Nginx Configuration
#############################
nginx_conf_path='/etc/nginx/sites-available/default'
#echo 'Modifying Nginx Configuration...'
# sed -i 's#root /var/www/html;#alias /data/web_static/current/#' ${nginx_conf_path}
cat > ${nginx_conf_path} << EOF
#Default Server Configuration
server {
  listen 80 default_server;
  listen [::]:80 default_server;

  root /var/wwww/html;

  index index.html index.htm index.nginx-debian.html;

  add_header X-Served-By \$hostname;

  server_name _;

  location /redirect_me {
    return 301 /redirect_me;
  }

#  error_page 404 /404.html;
# 
#  location = /404.html {
#    internal;
#  }

  location /hbnb_static {
    alias /data/web_static/current/;
  }

  location = / {
    try_files \$uri \$uri/ =404;
  }
}
EOF
service nginx restart
