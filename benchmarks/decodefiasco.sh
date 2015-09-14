rm -rf ./fiasco_decoded
mkdir ./fiasco_decoded
cd images_fiasco
for f in *; 
do 
	echo -n Decoding $f...; dfiasco $f -o ../fiasco_decoded/${f%.*}.pgm; echo Done!; 
done
	