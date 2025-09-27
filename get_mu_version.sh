#!/bin/bash

cur_date=`date +%d.%m.%Y`
cur_day=`date +%d`
cur_month=`date +%m`
cur_year=`date +%Y`
cur_time=`date +%H:%M`

save_dir=/var/www/html/links/data/pages/lmchez
report_name=lmchez_versions.txt
out_file=$save_dir/$report_name
lmchez_site=https://честныйзнак.рф/local-module/
lmchez_from_site=`lynx -dump $lmchez_site |grep ".msi" |head -1 | awk '{print $2$3}' | cut -c 53-61`

heading='Информация по ЛМ ЧЗ в магазинах'
Host=lmchez
Port=5995
PathInit=/api/v1/init
PathStatus=/api/v1/status
Domain=tdsterh.local

get_temp=./temp_lmchz_json.txt
repl_status_temp=./temp_repl_stat.txt

if [ -f $out_file ] 
then 
    rm $out_file 
fi
touch $out_file
    echo "===="$heading "на "$cur_date, $cur_time "====" >$out_file
    echo "Версия ЛМ ЧЗ на сайте: [[$lmchez_site | $lmchez_from_site]]" >>$out_file
    echo "^  № маг  ^  версия ЛМЧЗ  ^  статус  ^  нужно скачивать  ^  режим работы  ^  обновление  ^  синхронизация  ^" >>$out_file

# Full LMCHEZ list
for i in 01 02 03 04 05 07 08 09 10 11 13 14 16 21 22 24 25 26 27 28 29 31 32 33 66 68 86
#for i in 01
 do 
    Num=$i
    echo "--- $Num ------------------------------------------------------------------------"
    echo -n "^  [[http://$Host$Num.$Domain:8000/ |  $Num]]  |  " >>$out_file


    curl -X GET "http://$Host$Num:$Port$PathStatus" -H "accept: application/json" > $get_temp
    echo -e ""  >> $get_temp



    echo -e "" >> $get_temp

    version=$(jq -r '.version' $get_temp)

    status=$(jq -r '.status' $get_temp)

    requiresDownload=$(jq -r '.requiresDownload' $get_temp)

    operationMode=$(jq -r '.operationMode' $get_temp)
    lastUpdate=$(jq -r '.lastUpdate' $get_temp)
    lastSync=$(jq -r '.lastSync' $get_temp)
fixme=""
    if [[ $version != "$lmchez_from_site" ]]
    then
      fixme=":!:"
    fi
    echo $version $fixme"  |  " $status "  |   " $requiresDownload "  |  " $operationMode "  |  " $(date -d @$(cut -c 1-10 <<<"$lastUpdate")) "  |  " $(date -d @$(cut -c 1-10 <<<"$lastSync")) "  |  " $dbVersion "  |  " >>$out_file
 done
