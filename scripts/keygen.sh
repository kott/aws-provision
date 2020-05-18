#!/usr/bin/env bash

# This file generates a public/private keypair and stores these values in the location provided.
#
# e.g.
# >> ./keygen.sh /path/to/keys/ my_key_name 2048
# >> /path/to/keys/my_key_name.pub /path/to/keys/my_key_name.pem

function testReturn() {
    if [[ $1 != 0 ]]; then
        echo $2
        exit $1
    fi
}

function usage() {
    BNAME=$(basename "$0")
    echo "Usage:"
    echo "$BNAME <key_path> <key_name> <key_size>"
    echo "E.g. >> ./keygen.sh /path/to/keys/ my_key_name 2048"
}

function checkInput() {
    if [[ $1 != 3 ]]; then
        echo "Wrong number of inputs..."
        usage
        exit 1
    fi
}

function printKeyInfo() {
    echo "Following keys were generated:"
    echo "Public: $1"
    echo "Private: $2"
    echo "Key size: $3"
}


checkInput $#

KEYPATH=$1
KEYNAME=$2
KEYSIZE=$3

PUBLIC_KEY="$KEYPATH/$KEYNAME.pub"
PRIVATE_KEY="$KEYPATH/$KEYNAME.pem"

openssl version > /dev/null 2>&1
testReturn $? "openssl required"

openssl genrsa -out "$PRIVATE_KEY" "$KEYSIZE"
testReturn $? "openssl generate private key error"

openssl rsa -in "$PRIVATE_KEY" -pubout > "$PUBLIC_KEY"
testReturn $? "openssl generate public key error"

chmod 400 "$PRIVATE_KEY"

printKeyInfo "$PUBLIC_KEY" "$PRIVATE_KEY" "$KEYSIZE"
exit 0
