#!/bin/bash

function welcome()
{

echo "TAG GENERATOR v0.1"
echo " ____|    \ "
echo "(____|     \`._____ "
echo " ____|       _|___ "
echo "(____|     .\' "
echo "     |____/ "

}

workdir="/home/caseta/scripts"
db="/home/caseta/db/tag-db/ultimo.csv"

function get_csv()
{
  rm *.txt
  rm *.tmp
  file="export?format=csv"

  if [ -f $file ]; then
    echo "Ya he descargado una lista antes.."
    rm $file
    wget https://docs.google.com/spreadsheets/d/1ST5P5isQg-wdEdv-C1PuJeUHA-6PnTDnxdvybPeNHMg/export?format=csv
  else
    wget https://docs.google.com/spreadsheets/d/1ST5P5isQg-wdEdv-C1PuJeUHA-6PnTDnxdvybPeNHMg/export?format=csv
    echo "Hemos descargado... ¡Renombrando!"
    mv $file lista.txt
    sleep 2
    echo "Convirtiendo a formato UNIX"
    dos2unix lista.txt
    sleep 2
    echo "Aplicando Uniq en caso de que existan duplicados"
    cp lista.txt lista.txt.tmp
    cat lista.txt.tmp | uniq > lista.txt
    sleep 3
  fi
}

function tag()
{

  echo "Personnel ID,First Name,Last Name,Card Number,Department Number,Department Name,Gender,10.0 FP Qty,9.0 FP Qty,Vein Quantity,Face Qty" >> activar.txt
  echo "Estos son todos los que han pagado y vamos a activar :)"
  echo "------------------------------------------------------"
  while read tag; do
    if [ -z "$tag" ]; then
      echo "------------------------------------------------------"
      echo "vacio!"
      break
    fi
    echo $tag
    cat $db | grep "$tag" >> activar.txt
  done < lista.txt
}

cd $workdir
clear;
welcome
get_csv
clear;
tag
sleep 4
echo "Preparando tu lista de activación .. "
clear
echo "Tu lista de activación es:"
cat activar.txt
sed -i 's/á/a/g' "activar.txt"
sed -i 's/é/e/g' "activar.txt"
sed -i 's/í/i/g' "activar.txt"
sed -i 's/ó/ó/g' "activar.txt"
sed -i 's/ú/u/g' "activar.txt"
sed -i 's/ñ/n/g' "activar.txt"

cp activar.txt /home/caseta/db/tag-db/
echo "Si deseas verificar revisa: "
echo "http://bit.ly/2iA2Rik"
