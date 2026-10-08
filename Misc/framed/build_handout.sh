#!/bin/bash
# Rebuilds attachments/framed.mkv: one character of flag.txt is hidden (steghide,
# empty passphrase) in each frame of the 109-frame source video, then the frames
# are re-encoded losslessly (FFV1) so the hidden data survives. The original 2021
# handout was lost, so this regenerates it the same way embed.sh did.
# Runs in a throwaway container so ffmpeg/steghide don't need to be installed.
set -e
cd "$(dirname "$0")"
mkdir -p attachments
docker run --rm -v "$PWD:/src:ro" -v "$PWD/attachments:/out" ubuntu:22.04 bash -c '
set -e
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq >/dev/null && apt-get install -y -qq ffmpeg steghide >/dev/null
cd /tmp && mkdir -p photoblowup photoblowup-steghidden && cp /src/flag.txt .
N=$(tr -d "\n" < flag.txt | wc -c)
ffmpeg -v error -i /src/VID_20210916_081036.mp4 -r 30 -frames:v "$N" photoblowup/image-%03d.bmp
cd photoblowup
for i in $(seq -f "%03g" 1 "$N"); do
	C=$(tr -d "\n" < ../flag.txt | cut -c$((10#$i)))
	echo "$C" | steghide embed -q -cf image-$i.bmp -ef - -sf ../photoblowup-steghidden/image-$i.bmp -p ""
done
cd ..
ffmpeg -v error -y -framerate 30 -i photoblowup-steghidden/image-%03d.bmp -c:v ffv1 -level 3 -pix_fmt bgr0 /out/framed.mkv
chown '"$(id -u):$(id -g)"' /out/framed.mkv
'
