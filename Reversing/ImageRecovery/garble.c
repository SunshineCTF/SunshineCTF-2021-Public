#include <stdio.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <setjmp.h>
#include <png.h>

#define ABS(x) ({ \
	__typeof__(x) _x = (x); \
	_x >= 0 ? _x : -_x; \
})
#define CMP(op, a, b) ({ \
	__typeof__(a) _a = (a); \
	__typeof__(_a) _b = (b); \
	(_a op _b) ? _a : _b; \
})
#define MIN(a, b) CMP(<=, a, b)
#define MAX(a, b) CMP(>, a, b)

#define GRB_MAX_CHUNK_WIDTH 16
#define GRB_MAX_CHUNK_HEIGHT 16

uint8_t g_chunk_width;
uint8_t g_chunk_height;


typedef struct {
	uint8_t** rows;
	uint16_t width, height;
} image_data;

typedef struct {
	uint8_t r, g, b;
} rgb_pixel;

void get_rgb(image_data* image, uint16_t r, uint16_t c, rgb_pixel* px) {
	if(r >= image->height || c >= image->width) {
		px->r = px->g = px->b = 0;
		return;
	}
	
	uint8_t* px_data = &image->rows[r][c*3];
	px->r = px_data[0];
	px->g = px_data[1];
	px->b = px_data[2];
}

uint8_t compress_pixel(rgb_pixel* px) {
	return (px->g & 0xe0) | ((px->r & 0xe0) >> 3) | ((px->b & 0xc0) >> 6);
}

void garble_chunk(image_data* image, uint8_t chunk_row, uint8_t chunk_col, FILE* out_fp) {
	uint8_t i, j;
	rgb_pixel px = {0};
	
	for(i = 0; i < g_chunk_height; i++) {
		for(j = 0; j < g_chunk_width; j++) {
			get_rgb(image, chunk_row * g_chunk_height + i, chunk_col * g_chunk_width + j, &px);
			if(fputc(compress_pixel(&px), out_fp) == EOF) {
				fprintf(stderr, "Failed to write output data\n");
				abort();
			}
		}
	}
}

void garble_image(image_data* image, FILE* out_fp) {
	uint8_t chunk_dims_byte;
	uint8_t num_rows, num_cols;
	uint8_t i, j;
	
	// Write GRB magic
	fputs("GRB8", out_fp);
	
	// Pack chunk width and height into a single byte and emit it
	chunk_dims_byte = ((g_chunk_width - 1) << 4) | (g_chunk_height - 1);
	fputc(chunk_dims_byte, out_fp);
	
	// Write header metadata (width and height)
	num_rows = (image->height + g_chunk_height - 1) / g_chunk_height;
	num_cols = (image->width + g_chunk_width - 1) / g_chunk_width;
	fputc(num_rows, out_fp);
	fputc(num_cols, out_fp);
	
	// Write image data chunks
	for(i = 0; i < num_rows; i++) {
		for(j = 0; j < num_cols; j++) {
			garble_chunk(image, i, j, out_fp);
		}
	}
	
	// Write GRB end sentinel
	fputc('.', out_fp);
}


int main(int argc, char** argv) {
	int ret = EXIT_FAILURE;
	FILE* fp = NULL;
	uint8_t png_magic[8] = {0};
	png_structp png_ptr = NULL;
	png_infop info_ptr = NULL;
	png_uint_32 image_width = 0, image_height = 0;
	png_bytepp row_pointers = NULL;
	image_data image = {0};
	unsigned cur, absdiff, best;
	
	if(argc != 2) {
		fprintf(stderr, "Usage: %s input.png\n", argv[0]);
		goto out;
	}
	
	fp = fopen(argv[1], "rb");
	if(fp == NULL) {
		perror(argv[1]);
		goto out;
	}
	
	if(fread(png_magic, 8, 1, fp) != 1) {
		fprintf(stderr, "Failed to read PNG header\n");
		goto out;
	}
	
	if(png_sig_cmp(png_magic, 0, 8)) {
		fprintf(stderr, "Input file is not a PNG\n");
		goto out;
	}
	
	png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
	if(png_ptr == NULL) {
		fprintf(stderr, "Failed to initialize PNG struct\n");
		goto out;
	}
	
	info_ptr = png_create_info_struct(png_ptr);
	if(info_ptr == NULL) {
		fprintf(stderr, "Failed to initialize PNG info struct\n");
		goto out;
	}
	
	if(setjmp(png_jmpbuf(png_ptr))) {
		fprintf(stderr, "Error encountered while parsing intput PNG file\n");
		goto out;
	}
	
	// Setup input file pointer for further PNG operations and skip the 8 header bytes
	png_init_io(png_ptr, fp);
	png_set_sig_bytes(png_ptr, 8);
	
	// Read the entire PNG contents into memory as 8-bit R,G,B,R,G,B, ...
	png_read_png(png_ptr, info_ptr, PNG_TRANSFORM_SCALE_16 | PNG_TRANSFORM_EXPAND | PNG_TRANSFORM_STRIP_ALPHA, NULL);
	
	// Get the image dimensions and access to pixel data
	image_width = png_get_image_width(png_ptr, info_ptr);
	image_height = png_get_image_height(png_ptr, info_ptr);
	row_pointers = png_get_rows(png_ptr, info_ptr);
	
	// Image dimension checks
	if(image_width / GRB_MAX_CHUNK_WIDTH > UINT8_MAX) {
		fprintf(stderr, "Image is too wide\n");
		goto out;
	}
	
	if(image_height / GRB_MAX_CHUNK_HEIGHT > UINT8_MAX) {
		fprintf(stderr, "Image is too tall\n");
		goto out;
	}
	
	// Calculate chunk dimensions to use
	best = 999999999;
	for(cur = GRB_MAX_CHUNK_WIDTH; cur >= 1; cur--) {
		if(image_width % cur == 0 && cur * UINT8_MAX >= image_width) {
			g_chunk_width = cur;
			break;
		}
		
		absdiff = ABS(image_width - cur * MIN(image_width / cur, UINT8_MAX));
		if(absdiff < best) {
			best = absdiff;
			g_chunk_width = cur;
		}
	}
	
	best = 999999999;
	for(cur = GRB_MAX_CHUNK_HEIGHT; cur * UINT8_MAX >= image_height; cur--) {
		if(image_height % cur == 0 && cur * UINT8_MAX >= image_height) {
			g_chunk_height = cur;
			break;
		}
		
		absdiff = ABS(image_height - cur * MIN(image_height / cur, UINT8_MAX));
		if(absdiff < best) {
			best = absdiff;
			g_chunk_height = cur;
		}
	}
	
	// Convert the image data to a garbled image and write the result to stdout
	image.width = image_width;
	image.height = image_height;
	image.rows = row_pointers;
	garble_image(&image, stdout);
	
	ret = EXIT_SUCCESS;
	
out:
	if(png_ptr != NULL) {
		png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
	}
	
	if(fp != NULL) {
		fclose(fp);
	}
	
	return ret;
}
