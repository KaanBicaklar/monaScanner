#/bin/bash
with_nessus=$1
username=$2
password=$3
  
for url in $(cat deneme.txt);do
mkdir bb/$url
subfinder -silent -d $url >> bb/$url/subdomainsof.$url
cat bb/$url/subdomainsof.$url|httprobe >> bb/$url/alive.$url
if [ $with_nesus="nessus" ]; then
cat bb/$url/alive.$url| cut -d '/' -f 3 > bb/$url/nessusfile.$url
a=$(pwd)
echo $username
echo $password
python3 sel.py -u $username -p $password -sn $url  -sf $a/bb/$url/nessusfile.$url
fi

nuclei -l bb/$url/alive.$url  -o bb/$url/nuclei.$url

done
