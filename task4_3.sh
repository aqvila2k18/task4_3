#!/bin/bash
if [ "$#" != 2 ]
then
echo 'incorrect parameters'
exit
fi
if ! [ -d $1 ]
then
echo 'incorrect parameters'
exit
fi
if ! [ -d /tmp/backups/ ]; then
mkdir /tmp/backups/
fi
echo $1 > /tmp/backups/path.txt
sed -i 's:/:-:g' /tmp/backups/path.txt
bkp_name=$(cat /tmp/backups/path.txt | cut -c 2-)
rm /tmp/backups/path.txt
timestamp=$(date +"%d%H%M%S")
tar -czf "/tmp/backups/$bkp_name-$timestamp.tar.gz" $1 >> /dev/null 2>&1
col=$(ls -atr /tmp/backups/ | grep "$bkp_name" | grep '.tar.gz' | wc -l)
count=$(($col-$2))
backups=$(ls -atr /tmp/backups/ | grep "$bkp_name" -m "$count"| grep '.tar.gz')
for i in $backups
do
rm "/tmp/backups/"$i
done
