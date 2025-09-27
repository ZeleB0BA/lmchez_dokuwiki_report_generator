#!/bin/bash

cur_date=`date +%d.%m.%Y`
cur_day=`date +%d`
cur_month=`date +%m`
cur_year=`date +%Y`

save_dir=/var/www/html/links/data/pages/mu
report_name=mu_versions.txt
out_file=$save_dir/$report_name
heading='Информация по Фронтол МаркЮнит в магазинах'
Domain=tdsterh.local


get_temp=./temp_json.txt


if [ -f $out_file ] 
then 
    rm $out_file 
fi
touch $out_file
    echo "===="$heading "на "$cur_date "====" >$out_file
    echo "Версия ФМЮ на сайте: [[$utm_site | $utm_from_site]]" >>$out_file
    echo "^  № маг  ^  версия   ^  статус закрытия смены  ^  лицензия  ^" >>$out_file
Host=mu

# Full MU list
for i in 01 02 03 04 05 07 08 09 10 11 12 13 14 15
 do 
    Num=$i
    echo "--- $Num ------------------------------------------------------------------------"
    echo -n "^  [[http://$Host$Num.$Domain:8000/ |  $Num]]  |  " >>$out_file

# Get_Info of MU
    curl -X POST "http://$Host$Num.$Domain:8000/api4/system/get_info" > $get_temp

#cat $get_temp
echo -e

# split values
    version=$(jq -r '.version' $get_temp)
    platform=$(jq -r '.platform' $get_temp)
    database=$(jq -r '.database' $get_temp)
    config=$(jq -r '.config' $get_temp)
    log=$(jq -r '.log' $get_temp)
    frontend=$(jq -r '.frontend' $get_temp)
    state=$(jq -r '.state' $get_temp)
    license=$(jq -r '.license' $get_temp)

# fill table
    echo $version "  |  " $state "  |  " $license "  |  ">>$out_file

 done
