#!/bin/bash

function makecrt() {
    openssl req -subj "/CN=example.org/C=DE/" -nodes -new -newkey rsa:2048 \
     -reqexts SAN -config <(cat /etc/ssl/openssl.cnf <(printf "\n[SAN]\nsubjectAltName=DNS:fun.example")) \
     -keyout $1.key -outform DER -out $1.der
    echo "convert (work around openssl bug in respecting -inform DER)"
    openssl req -inform der -in $1.der -out $1.csr
    echo "self sign"
    openssl x509 \
     -extensions SAN -extfile <(cat /etc/ssl/openssl.cnf <(printf "\n[SAN]\nsubjectKeyIdentifier=hash\nsubjectAltName=DNS:fun.example")) \
     -req -days 5 -in $1.csr -signkey $1.key -outform der -out $1.crt
}

makecrt 1
makecrt 2
