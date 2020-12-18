#!/usr/bin/env bash

set -euf -o pipefail

if [ "${BACKEND_URL:-}" = "" ] ; then
	echo "You must set BACKEND_URL."
	exit 1
fi

cat > /etc/nginx/nginx.conf <<-EOCONF
events {
	worker_connections  1024;
	use epoll;
}

http {
	include mime.types;
	default_type application/octet-stream;

	server {
		listen 80;
		listen [::]:80;
		server_name _ default_server;

		location / {
			proxy_http_version 1.1;
			proxy_set_header Host \$host;
			proxy_set_header X-Real-IP \$remote_addr;
			proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
			proxy_read_timeout 30;

			proxy_pass ${BACKEND_URL};
		}
	}
}
EOCONF

/usr/sbin/nginx -g 'daemon off;'
