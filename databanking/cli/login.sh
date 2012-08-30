#!/bin/bash

. ./config.sh

curl -s --insecure -c cookie.tmp 'https://ib.slsp.sk/ebanking/ibxindex.xml' > /dev/null

echo "--- session vytvorena ---"

curl --insecure -b cookie.tmp "https://ib.slsp.sk/ebanking/login/ibxlogin.xml?user_id=${ID}&tap=2&pwd=${PASS}&lng2=en"

echo "--- prihlaseny ---"
