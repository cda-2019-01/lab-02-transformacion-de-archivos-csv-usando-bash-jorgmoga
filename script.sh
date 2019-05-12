sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion1;\1\/\2\/\3/' estacion1.csv  > estacion01.csv # Agrego la etiqueta estacione1
sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion2;\1\/\2\/\3/' estacion2.csv  > estacion02.csv # Agrego la etiqueta estacione2
sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion3;\1\/\2\/\3/' estacion3.csv  > estacion03.csv # Agrego la etiqueta estacione3
sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion4;\1\/\2\/\3/' estacion4.csv  > estacion04.csv # Agrego la etiqueta estacione4
csvstack estacion01.csv estacion02.csv estacion03.csv estacion04.csv > estaciones0.csv # Agrupo todo los archivos
sudo apt-get install -y csvkit #Instalacion de SQL
sed 's/FECHA;/ESTACION;FECHA;AÑO;MES;HORA;/' estaciones0.csv > out.2 ## agregoSe agregan nuevos nombre a las columnas
sed 's/\([0-9]\),\([0-9]\)/\1.\2/' out.2 > out.5 # Cambio , por .
sed 's/;/,/g' out.5 > out.6 # Cambio ; por ,
sed 's/,\([0-9]\)\/\([0-9][0-9]\)\/\([0-9][0-9]\),/,0\1\/\2\/\3,/' out.6 > out.7 # ajusto el dia 1/01/01 a 01/01/01
sed 's/,\([0-9]\):\([0-9][0-9]\):\([0-9][0-9]\),/,0\1:\2:\3,/' out.7 > out.8 # ajusto la hora 1:01:01 a 01:01:01
sed 's/\/\([0-9][0-9]\)\/\([0-9][0-9]\),\([0-9][0-9]\)/\/\1\/\2,\2,\1,\3,\3/' out.8 > data.csv #Creo las variables de Año Mes Hora
csvsql --query 'select ESTACION, MES, avg(VEL) from data GROUP BY ESTACION, MES' data.csv > velocidad-por-mes.csv #
cat velocidad-por-mes.csv #
csvsql --query 'select ESTACION, AÑO, avg(VEL) from data GROUP BY ESTACION, AÑO' data.csv > velocidad-por-ano.csv #
cat velocidad-por-ano.csv #
csvsql --query 'select ESTACION, HORA, avg(VEL) from data GROUP BY ESTACION, HORA' data.csv > velocidad-por-hora.csv #
cat velocidad-por-hora.csv #
rm data*
rm estacion0*
rm out*
