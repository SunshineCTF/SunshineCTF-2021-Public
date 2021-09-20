// toolbox.h: 
//
// === NOTES ===
// * This is a _small_ set of typedefs, #defines and inlines that can 
//   be found in tonclib, and might not represent the 
//   final forms.
// From https://www.coranac.com/tonc/text/first.htm

#ifndef TOOLBOX_H
#define TOOLBOX_H

#include <libheart.h>
#include <hrt_video.h>
#include <hrt_oam.h>
#include <hrt_interrupt.h>
#include <hrt_bios.h>

// === (from tonc_types.h) ============================================

// Already defined.
// typedef unsigned char   u8;
// typedef unsigned short  u16;
// typedef unsigned int    u32;

typedef u16 COLOR;

#define INLINE static inline

// === (from tonc_memmap.h) ===========================================

#define MEM_IO      0x04000000
#define MEM_VRAM    0x06000000

// #define REG_DISPCNT     *((volatile u32*)(MEM_IO+0x0000))

// === (from tonc_memdef.h) ===========================================

// --- REG_DISPCNT defines ---
#define DCNT_MODE0     0x0000
#define DCNT_MODE1      0x0001
#define DCNT_MODE2      0x0002
#define DCNT_MODE3      0x0003
#define DCNT_MODE4      0x0004
#define DCNT_MODE5      0x0005
// layers
#define DCNT_BG0        0x0100
#define DCNT_BG1        0x0200
#define DCNT_BG2        0x0400
#define DCNT_BG3        0x0800
#define DCNT_OBJ        0x1000


// === (from tonc_video.h) ============================================

#define SCREEN_WIDTH   240
#define SCREEN_HEIGHT  160
#define SCREEN_TOTAL   SCREEN_WIDTH * SCREEN_HEIGHT

#define vid_mem     ((u16*)MEM_VRAM)

INLINE void m3_plot(int x, int y, COLOR clr)
{   vid_mem[y*SCREEN_WIDTH+x]= clr;    }

#define CLR_BLACK   0x0000
#define CLR_RED     0x001F
#define CLR_LIME    0x03E0
#define CLR_YELLOW  0x03FF
#define CLR_BLUE    0x7C00
#define CLR_MAG     0x7C1F
#define CLR_CYAN    0x7FE0
#define CLR_WHITE   0x7FFF


INLINE COLOR RGB15(u32 red, u32 green, u32 blue)
{   return red | (green<<5) | (blue<<10);   }


// extra stuff, also in tonc_video.h
#define M3_WIDTH    SCREEN_WIDTH
// typedef for a whole mode3 line
typedef COLOR       M3LINE[M3_WIDTH];
// m3_mem is a matrix; m3_mem[y][x] is pixel (x,y)
#define m3_mem    ((M3LINE*)MEM_VRAM)

// custom stuffs
void disableText(u8 bg);
void hrt_FillScreen(u16 color);

#endif // TOOLBOX_H