#!/bin/bash

function welcome()
{

echo "TAG GENERATOR v0.1"
echo " ____|    \ "
echo "(____|     \`._____ "
echo " ____|       _|___ "
echo "(____|     .\' "
echo "     |____/ "

#Borra primero
rm /home/canros/Andara/zkeco/activar/activar.txt
rm /home/canros/Andara/zkeco/activar/activar2.txt

touch /home/canros/Andara/zkeco/activar/activar.txt
touch /home/canros/Andara/zkeco/activar/activar2.txt
}

workdir="/home/canros/Andara/zkeco/scripts"
db="/home/canros/Andara/zkeco/db/ultimo.csv"

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
    ls -lrt lista.txt
  fi
}

function get_csv_2()
{
  rm *.txt
  rm *.tmp
  file="export?format=csv"

  if [ -f $file ]; then
    echo "Ya he descargado una lista antes.."
    rm $file
    wget https://docs.google.com/spreadsheets/d/1iS6c6HqWhFRitClORKrrt-15OzIpdtAxkdb8TTVrxZ4/export?format=csv
  else
    wget https://docs.google.com/spreadsheets/d/1iS6c6HqWhFRitClORKrrt-15OzIpdtAxkdb8TTVrxZ4/export?format=csv
    echo "Hemos descargado... ¡Renombrando!"
    mv $file lista2.txt
    sleep 2
    echo "Convirtiendo a formato UNIX"
    dos2unix lista2.txt
    sleep 2
    echo "Aplicando Uniq en caso de que existan duplicados"
    cp lista2.txt lista2.txt.tmp
    cat lista2.txt.tmp | uniq > lista2.txt
  fi
}

function tag()
{

  get_csv
  echo "Personnel ID,First Name,Last Name,Card Number,Department Number,Department Name,Gender,10.0 FP Qty,9.0 FP Qty,Vein Quantity,Face Qty" >> /home/canros/Andara/zkeco/activar/activar.txt
  sleep 2
  echo "Estos son todos los que han pagado y vamos a activar :)"
  echo "------------------------------------------------------"
  while read tag; do
    if [ -z "$tag" ]; then
      echo "------------------------------------------------------"
      echo "vacio!"
      break
    fi
    echo $tag
#    cat $db | grep "$tag" >> activar.txt
     cat $db | grep "$tag" >> /home/canros/Andara/zkeco/activar/activar.txt
  done < lista.txt
  pwd
  sleep 2


  get_csv_2

  #echo "Personnel ID,First Name,Last Name,Card Number,Department Number,Department Name,Gender,10.0 FP Qty,9.0 FP Qty,Vein Quantity,Face Qty" >> /home/canros/Andara/zkeco/activar/activar2.txt

  while read tag; do
    if [ -z "$tag" ]; then
      echo "------------------------------------------------------"
      echo "Añadiendo los que tengan saldos a favor ó su pago este mes*"
      echo "------------------------------------------------------"
      echo "vacio!"
      break
    fi
    echo $tag
#    cat $db | grep "$tag" >> activar2.txt
     cat $db | grep "$tag" >> /home/canros/Andara/zkeco/activar/activar2.txt
  done < lista2.txt
  pwd
  sleep 2

  #unficando las listas
  cat /home/canros/Andara/zkeco/activar/activar2.txt >> /home/canros/Andara/zkeco/activar/activar.txt
  cp /home/canros/Andara/zkeco/activar/activar.txt /home/canros/Andara/zkeco/activar/activar.txt.tmp
  cat /home/canros/Andara/zkeco/activar/activar.txt.tmp | uniq > /home/canros/Andara/zkeco/activar/activar.txt
}

cd $workdir
clear;
welcome
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

echo "Si deseas verificar revisa: "
echo "http://bit.ly/2iA2Rik"
