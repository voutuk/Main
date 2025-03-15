kubectl create secret tls cloudflare-origin-cert -n olx-app\
  --cert=./origin-certificate.pem \
  --key=./private-key.pem
