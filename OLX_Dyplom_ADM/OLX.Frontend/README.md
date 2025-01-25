# React + TypeScript + Vite

```nginx options /etc/nginx/sites-available/default
server {
    server_name   gosell.itstep.click *.gosell.itstep.click;
    location / {
       proxy_pass         http://localhost:5092;
       proxy_http_version 1.1;
       proxy_set_header   Upgrade $http_upgrade;
       proxy_set_header   Connection keep-alive;
       proxy_set_header   Host $host;
       proxy_cache_bypass $http_upgrade;
       proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header   X-Forwarded-Proto $scheme;
    }
}


sudo systemctl restart nginx
certbot
```
