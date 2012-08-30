#!/bin/bash

./login.sh

. ./config.sh

curl -s --insecure -b cookie.tmp ${DEFAULT_ACCOUNT} > /dev/null
echo "--- vybral som ucet a cakam na zoznam obratov ---"

curl -o ../data/obraty.xml --insecure -b cookie.tmp 'https://ib.slsp.sk/ebanking/accto/ibxtofilter.xml?no_f_no_do=&no_f_no_od=01.1.2010&no_s_how_much=show10&no_f_predcislo=&no_f_cislo=&no_f_banka=&no_f_vs=&no_f_ks=&no_f_ss=&no_f_amount1=&no_f_amount2=&no_c_poplatky=1&no_direction=&no_s_amounts=amntnone&no_c_karty=1&no_c_ebprik=1&no_c_ostatne=1&no_c_kreditne=1&no_c_debetne=1&no_c_zps=1&no_c_tps=1&no_c_prior=1&currency=all'
echo
echo "--- koniec, robim logout ---"

./logout.sh
