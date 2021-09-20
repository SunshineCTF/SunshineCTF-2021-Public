#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    uint8_t buf[16] = {0};
    memset(buf, 0x78, 10);
    long double *d = (long double *)&buf[0];
    printf("%Lf\n", *d);
    for (uint8_t i = 0; i < 16; i++) {
        printf("%02x, ", buf[i]);
    }
    printf("\n");
    printf("\nGive me something close to your desired decimal value: ");
    scanf(" %Lf", d);

    for (uint8_t i = 0; i < 16; i++) {
        buf[i] = buf[i] & 0b11111001; // PREV_INUSE but not IS_MMAPPED | NON_MAIN_ARENA
    }
    printf("Use this value: %Lf\n", *d);
    for (uint8_t i = 0; i < 16; i++) {
        printf("%02x, ", buf[i]);
    }
    printf("\n");
}