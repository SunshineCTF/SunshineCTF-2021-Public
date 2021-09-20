mkdir postcompressionblowup
ffmpeg -i av1out.mkv -r 30 postcompressionblowup/image-%3d.bmp
cd postcompressionblowup
mkdir /tmp/flagfolder
for i in $(ls ./) ; do steghide extract -sf $i -xf /tmp/flagfolder/$i -p "" ;done
