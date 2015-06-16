###############################
# System Analyser Load Script #
# Dave Collier @ 04/04/2015   #
###############################

# Set variables
set_variables()
{
  file_name=$(basename $1)
  server=`echo $file_name| awk -F '_' '{print$1}'`
  type=`echo $file_name| awk -F '_' '{print$2}'`
  rec_count="1"
}

set_variables $1

while read line
do
  rec_date=`echo $line | awk -F ',' '{print$1}'`

  if [ $rec_count -eq 1 ]
  then
    start_date=$rec_date
    rec_count=2
  fi

  if [ $rec_date = $start_date ]
  then
    rec_time=`echo $line| awk -F ',' '{print$2}'`
    temp=$rec_date" "$rec_time
    date=`date --date "$temp" +%s000`
    cpu=$cpu"["$date","`echo $line | awk -F ',' '{print$3}'`"],"
    mem=$mem"["$date","`echo $line | awk -F ',' '{print$5}'`"],"
    disk=$disk"["$date","`echo $line | awk -F ',' '{print$4}'`"],"
    netIn=$netIn"["$date","`echo $line | awk -F ',' '{print$6}'`"],"
    netOut=$netOut"["$date","`echo $line | awk -F ',' '{print$7}'`"],"
  else
    rec_count=1
    line_date=`echo $start_date| sed 's/\///g'`
    key=$server-$line_date
    cpu=`echo $cpu| sed '$s/,$//'`
    mem=`echo $mem| sed '$s/,$//'`
    disk=`echo $disk| sed '$s/,$//'`
    netIn=`echo $netIn| sed '$s/,$//'`
    netOut=`echo $netOut| sed '$s/,$//'`
    output='{"_id":"'$key'","server":"'$server'","date":"'$line_date'","server_metrics":[{"cpu":['$cpu']},{"mem":['$mem']},{"disk":['$disk']},{"netIn":['$netIn']},{"netOut":['$netOut']}]}'
    echo $output >> metrics.json
    rec_time=`echo $line| awk -F ',' '{print$2}'`
    temp=$rec_date" "$rec_time
    date=`date --date "$temp" +%s000`
    cpu="["$date","`echo $line | awk -F ',' '{print$3}'`"],"
    mem="["$date","`echo $line | awk -F ',' '{print$5}'`"],"
    disk="["$date","`echo $line | awk -F ',' '{print$4}'`"],"
    netIn="["$date","`echo $line | awk -F ',' '{print$6}'`"],"
    netOut="["$date","`echo $line | awk -F ',' '{print$7}'`"],"
  fi
done < $1

line_date=`echo $rec_date| sed 's/\///g'`
key=$server-$line_date
cpu=`echo $cpu| sed '$s/,$//'`
mem=`echo $mem| sed '$s/,$//'`
disk=`echo $disk| sed '$s/,$//'`
netIn=`echo $netIn| sed '$s/,$//'`
netOut=`echo $netOut| sed '$s/,$//'`
output='{"_id":"'$key'","server":"'$server'","date":"'$line_date'","server_metrics":[{"cpu":['$cpu']},{"mem":['$mem']},{"disk":['$disk']},{"netIn":['$netIn']},{"netOut":['$netOut']}]}'
echo $output >> metrics.json