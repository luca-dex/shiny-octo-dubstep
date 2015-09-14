if [ $# -lt 1 ] 
then
	echo "usage: $ ./decodefiasco {big,small}"
	exit
fi

if [ ! -d ./decoded_fiasco ]
then
	mkdir ./decoded_fiasco
fi


rm -rf ./decoded_fiasco/$1
mkdir ./decoded_fiasco/$1
cd images_fiasco/$1
if [ "$1" == "small" ] 
then
	for f in *; do echo -n Decoding $f...; dfiasco $f -o ../../decoded_fiasco/$1/${f%.*} -V 0; echo Done!; done
else
	for f in *; do echo -n Decoding $f...; time(dfiasco $f -o ../../decoded_fiasco/$1/${f%.*} -V 0); echo Done!; done
fi	
exit


