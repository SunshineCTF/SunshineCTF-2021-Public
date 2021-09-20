import sys
import struct
from PIL import Image

def parse_chunk(cw, ch, nc, r, c, data, rows):
	for i in range(ch):
		for j in range(cw):
			dst_row = ch * r + i
			dst_col = cw * c + j
			
			bytes_per_chunk = ch * cw
			bytes_per_row_of_chunks = bytes_per_chunk * nc
			offset_to_chunk_row = bytes_per_row_of_chunks * r
			offset_to_chunk_in_row = bytes_per_chunk * c
			offset_to_chunk = offset_to_chunk_row + offset_to_chunk_in_row
			offset_within_chunk = i * cw + j
			pixel_offset = offset_to_chunk + offset_within_chunk
			
			rows[dst_row][dst_col] = data[pixel_offset]

def parse_grb(fp):
	# Read magic header and check it
	magic = fp.read(4)
	if magic != b"GRB8":
		raise ValueError("Input file is not a GRB image")
	
	# Read chunk dimensions, row count, and column count
	cdims, r, c = struct.unpack("BBB", fp.read(3))
	
	# Unpack chunk width and height
	cw, ch = ((cdims >> 4) & 0xf) + 1, (cdims & 0xf) + 1
	
	# Read all pixel data
	data = list(fp.read(ch * cw * r * c))
	
	# Check that the image file ends with the terminator character
	end = fp.read(1)
	if end != b'.':
		raise ValueError("Input file is not a GRB image: %#x" % end[0])
	
	# Build blank array of pixels and fill it with the image's chunk data
	rows = []
	for i in range(ch * r):
		rows.append([0] * (cw * c))
	for i in range(r):
		for j in range(c):
			parse_chunk(cw, ch, c, i, j, data, rows)
	
	return rows

def uncompress_pixel(px):
	g = px & 0xe0
	r = (px & 0x1c) << 3
	b = (px & 0x03) << 6
	
	return r, g, b

def main(argc, argv):
	if argc != 2:
		print("Usage: %s input.grb > output.png" % argv[0])
		sys.exit(1)
	
	fp = open(argv[1], "rb")
	
	rows = parse_grb(fp)
	img = Image.new("RGB", (len(rows[0]), len(rows)))
	
	for i, row in enumerate(rows):
		for j, px in enumerate(row):
			img.putpixel((j, i), uncompress_pixel(px))
	
	img.show()

if __name__ == "__main__":
	main(len(sys.argv), sys.argv)
