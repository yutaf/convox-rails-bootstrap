upstream app_server {
  # for UNIX domain socket setups:
  server unix:/share/unicorn.sock fail_timeout=0;

  # for TCP setups, point these to your backend servers
  # server 192.168.0.7:8080 fail_timeout=0;
  # server rails:3000 fail_timeout=0;
}

server {
    listen       80 default_server;
    server_name  localhost;

    root /srv/myapp/public;

    location / {
      try_files $uri @app;
    }
    location @app {
      proxy_set_header Host $host;

      proxy_set_header X-Forwarded-Host $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto $scheme;

      proxy_pass http://app_server;
    }

    location ~ \.php$ {
        proxy_set_header  X-Real-IP  $remote_addr;
        proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header  Host $http_host;
        proxy_redirect    off;

        if (!-f $request_filename) {
            proxy_pass http://php;
            break;
        }
    }
}

server {
    listen       80;
    server_name   ~^www\.(?<domain>.+)$;
    return       301 http://$domain$request_uri;
}
