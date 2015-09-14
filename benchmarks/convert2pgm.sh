if [ ! -d ./images_pgm ]
then
	mkdir ./images_pgm
fi

echo -n "Converting images/* to pgm..."

rm -rf ./images_pgm/small
mkdir ./images_pgm/small
cd images/small
for f in *; do convert $f ../../images_pgm/small/${f%.*}.pgm; done
cd ../..

rm -rf ./images_pgm/big
mkdir ./images_pgm/big
cd images/big
for f in *; do convert $f ../../images_pgm/big/${f%.*}.pgm; done

echo "Done!"