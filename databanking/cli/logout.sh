#!/bin/bash

curl -s --insecure -b cookie.tmp 'https://ib.slsp.sk/ebanking/logout/ibxlogoutyes.xml' > /dev/null
rm cookie.tmp
echo "--- koniec ---"
