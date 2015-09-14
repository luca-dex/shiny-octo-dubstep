if [ $# -lt 1 ] 
then
	echo "usage: $ ./encode2fiasco {big,small} [quality]"
	exit
fi

if [ ! -d ./images_fiasco ]
then
	mkdir ./images_fiasco
fi


rm -rf ./images_fiasco/$1
mkdir ./images_fiasco/$1
cd images_pgm/$1
if [ "$2" != "" ] 
then
	for f in *; do echo -n Encoding $f...; time(cfiasco -i $f -o ../../images_fiasco/$1/${f%.*} -q $2 -V 0); echo Done!; done
else
	for f in *; do echo -n Encoding $f...; time(cfiasco -i $f -o ../../images_fiasco/$1/${f%.*} -V 0); echo Done!; done
fi	
exit


