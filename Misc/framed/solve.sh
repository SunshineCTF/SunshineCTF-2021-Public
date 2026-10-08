#!/bin/bash
mkdir postcompressionblowup
ffmpeg -i attachments/framed.mkv -r 30 postcompressionblowup/image-%3d.bmp
cd postcompressionblowup
mkdir /tmp/flagfolder
for i in $(ls ./) ; do steghide extract -sf $i -xf /tmp/flagfolder/$i -p "" ;done
