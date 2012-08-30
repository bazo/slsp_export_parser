#!/bin/bash

./login.sh

. ./config.sh

curl --insecure -b cookie.tmp 'https://ib.slsp.sk/ebanking/accounts/ibxaccounts.xml'

./logout.sh
