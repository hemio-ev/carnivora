#!/bin/bash

openssl req -subj "/CN=example.org/C=DE/" -nodes -new -newkey rsa:2048 \
 -reqexts SAN -config <(cat /etc/ssl/openssl.cnf <(printf "\n[SAN]\nsubjectAltName=DNS:example.org,DNS:www.example.com")) \
 -keyout 1.key -outform DER -out 1.der
