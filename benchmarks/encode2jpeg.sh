if [ $# -lt 1 ] 
then
	echo "usage: $ ./encode2jpeg {big,small}"
	exit
fi

if [ ! -d ./images_jpeg ]
then
	mkdir ./images_jpeg
fi


rm -rf ./images_jpeg/$1
mkdir ./images_jpeg/$1
cd images_pgm/$1
if [ "$1" == "small" ] 
then
	for f in *; do 
		echo -n Encoding $f...; 
		convert $f ../../images_jpeg/$1/${f%.*}.jpg; 
		echo Done!; 
	done
else
	for f in *; do 
		echo -n Encoding $f...; 
		time(convert $f ../../images_jpeg/$1/${f%.*}.jpg); 
		echo Done!; 
	done
fi

