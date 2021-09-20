for i in $(seq -f "%03g" 1 109); 
do ls image-$i.bmp;
Z=$(cat ../flag.txt)
C=$(expr substr $Z $i 1)
echo $C | steghide embed -cf image-$i.bmp -ef - -sf ../photoblowup-steghidden/image-$i.bmp -p ""
done
