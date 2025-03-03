#!/usr/bin/bash

# create dir
echo "__create dir"
uniqid=$(date +'%Y%m%d%H%M%S')
mkdir "${uniqid}"
echo "${uniqid}"
cd "${uniqid}" || exit

# create private key
echo "__create private key"
private_key="private_${uniqid}.key"
openssl genrsa 2048 > "$private_key"

# craete csr
echo "__craete csr"
server_csr="server_${uniqid}.csr"
openssl req -new -key "$private_key" > "$server_csr"

echo "__craete crt"
server_crt="server_${uniqid}_.crt"
openssl x509 -req -days 398 -signkey "$private_key" < "$server_csr" > "$server_crt"

