#!/bin/sh
name=`kubectl get service | grep storm-ui | awk '{print $3}'`
cat > reverse-proxy.conf <<EOF
server {
        listen 8081;
        location / {
                proxy_pass http://${name}:8081;
        }
}
EOF
#nginx -t
#systemctl restart nginx
#curl localhost:8081
sudo docker run -d --name nginx-base -p 80:80 -p 8081:8081 nginx:latest
sudo docker cp reverse-proxy.conf nginx-base:/etc/nginx/conf.d/
sudo docker exec nginx-base nginx -t
sudo docker exec nginx-base nginx -s reload

