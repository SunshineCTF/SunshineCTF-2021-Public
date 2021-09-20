 for i in $(ls *.png ) ; do zbarimg $i 2>&1 ;done |grep QR  |cut -f 2 -d : |grep -v QR |base64 -d |node
