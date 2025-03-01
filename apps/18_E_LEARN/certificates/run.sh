#!/bin/bash

openssl req -x509 -nodes -newkey rsa:2048 \
    -keyout mssql.key \
    -out mssql.pem \
    -days 365 \
    -config mssql-cert.conf \
    -extensions v3_req