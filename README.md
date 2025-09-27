генератор отчёта о состоянии нескольких ЛМ ЧеЗов, по хостам в торговых точках в виде странички в формате dokuwiki.

формируется 1 раз в сутки по расписанию в crontab, или так как вам нужно

для парсинга JSON используется jq

результат пишется в директорию веб.сервера где лежат файлы для страниц

    /var/www/html/links/data/pages/lmchez

<img src="https://github.com/ZeleB0BA/lmchez_dokuwiki_report_generator/blob/main/get_LMCHEZ_info_sample.png" height=450>
