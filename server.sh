#!/bin/bash

PUERTO=2022
IP=$(ip a | grep "scope global" |cut -d ' ' -f6 | cut -d '/' -f1)
LINEAS=":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
HeaderFilename="FILENAME"
NextStep=0

clear
#1: El servidor escucha
echo $LINEAS
echo "1--- EL puerto está en "$PUERTO", establecido en " $IP
echo $LINEAS
#2: Esperar envío de paquete
echo "2--- Esperando conexión"
FilenameRec=$(ncat -l -p $PUERTO)
echo "paquete recibido" $FilenameRec
FilenameRecHeader=$(echo $FilenameRec | cut -c 1-9)
echo $LINEAS
echo "Header esperado: "$HeaderFilename
echo "Header recibido: "$FilenameRecHeader
echo $LINEAS
#3: Verificar filename
if [ "$FilenameRecHeader" = "$HeaderFilename" ]; then
echo "3 -- Cabeceras verificadas"
NextStep = 1
fi
#AÑADIR ELSE

echo $LINEAS
#4: Esperar md5sum
echo "4 -- Esperando Hash"
HashRec=$(ncat -l -p $PUERTO)
echo "Hash recibido: " $HashRec
echo $LINEAS
#5 md5sum recibido
echo "5 -- Hash recibido"
echo $LINEAS
#6 Esperar datos del archivo
echo "6 -- Esperando datos del archivo"
DatosRec=$(ncat -l -p $PUERTO)
#7 Recibir los datos, crear un hash y verificarlo
echo $DatosRec
echo "7 -- Verificando datos"
HashCompr=$(echo $DatosRec | md5sum)

