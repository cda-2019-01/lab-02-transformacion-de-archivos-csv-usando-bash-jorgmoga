sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion1;\1\/\2\/\3/' estacion1.csv  > estacion01.csv
sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion2;\1\/\2\/\3/' estacion2.csv  > estacion02.csv
sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion3;\1\/\2\/\3/' estacion3.csv  > estacion03.csv
sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion4;\1\/\2\/\3/' estacion4.csv  > estacion04.csv
csvstack estacion01.csv estacion02.csv estacion03.csv estacion04.csv > estaciones0.csv #
##sed -n '561845,561855p' estaciones0.csv ##
#head estaciones0.csv > estaciones.csv #
##sudo apt-get install -y csvkit #Instalacion de SQL
##head estaciones0.csv > out.1 #
##head out.0 > out.1 #
sed 's/FECHA;/ESTACION;FECHA;AÑO;MES;HORA;/' estaciones.csv > out.2 ## agrego nombre columna
##sed 's/\//-/g' out.2 > out.3 #cambio / por -
##sed 's/\([0-9][0-9]\)-\([0-9][0-9]\)-\([0-9][0-9]\)/estacion1;\1-\2-\3/' out.3 > out.4
#sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion1;\1\/\2\/\3/' out.2 > out.4 #agrego la estacion1 en la fila 1
sed 's/\([0-9]\),\([0-9]\)/\1.\2/' out.4 > out.5 # Cambio , por .
sed 's/;/,/g' out.5 > out.6 # Cambio ; por ,

sed 's/,\([0-9]\)\/\([0-9][0-9]\)\/\([0-9][0-9]\),/,0\1\/\2\/\3,/' out.6 > out.7 # ajusto el dia 1/01/01 a 01/01/01

sed 's/,\([0-9]\):\([0-9][0-9]\):\([0-9][0-9]\),/,0\1:\2:\3,/' out.7 > out.8

sed 's/\/\([0-9][0-9]\)\/\([0-9][0-9]\),\([0-9][0-9]\)/\/\1\/\2,\2,\1,\3,\3/' out.8 > data.csv #Creo las variables de Año Mes Hora
##cut -d',' -f3 data.csv | uniq -c  #Imprime los datos distintos con el conteo especifico de una linea
csvsql --query 'select ESTACION, MES, avg(VEL) from data GROUP BY ESTACION, AÑO' data.csv > velocidad-por-mes.csv #
csvsql --query 'select ESTACION, AÑO, avg(VEL) from data GROUP BY ESTACION, AÑO' data.csv > velocidad-por-ano.csv #
csvsql --query 'select ESTACION, HORA, avg(VEL) from data GROUP BY ESTACION, AÑO' data.csv > velocidad-por-hora.csv #
cat velocidad-por-mes.csv #
cat velocidad-por-ano.csv #
cat velocidad-por-hora.csv #
## sed -n '561840,561850p' estaciones.csv  #Imprime linea especifica
