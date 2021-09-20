#include "toolbox.h"
#include <string.h>
#include <stdlib.h>
#define flag "sun{n1ce_str1ngs_c0mm4nd_but"
#define flag_pt2 "check the map"

// Button presses
u16 keys_pressed;
u16 keys_released;

u8 i;

void run(unsigned char start);

int main()
{
    char *blank = malloc(sizeof(char) * 32);;

	hrt_Init(); //Does some recommended initializations
	
	//Sets up background(s)
	hrt_DSPEnableBG(0);  //Enabled background 0
	hrt_DSPDisableForceBlank(); //Makes the screen whiten't
	// hrt_InitTextEngine(2);
	
	// graphics!
	// hrt_InitIRQ();
	// hrt_EnableIRQ(IRQ_VBLANK);

	hrt_DSPSetBGMode(0);
	hrt_InitTextEngine(0);

    hrt_SetTextColors(CLR_BLACK, RGB15(15, 14, 1));

	hrt_Print(0, 0, "hey.");
	hrt_Print(0, 1, "you like flags?");
    hrt_Print(0, 3, "if so, do you have a gba");
    hrt_Print(0, 4, "emulator that can *haxx*?");

    hrt_Print(0, 18, "click start to continue...");


    blank = strcpy(blank, "hint:");
    blank = strcpy(blank, flag_pt2);
    for (i = 0; i < 13; i++)
    {
        if (blank[i] == ' ')
            blank[i] = '_';
        else if (blank[i] == 'k')
            blank[i] = 'c';
        else if (blank[i] == 'e')
            blank[i] = '3';
        else if (blank[i] == 'a')
            blank[i] = '@';
        else
            blank[i] = flag_pt2[i];
    }

    // End of program.
    while(1)
	{
        hrt_Print(0, -2, flag);


		// hrt_VblankIntrWait();
		hrt_ScanKeys();

		keys_pressed = hrt_KeysDown();

		if (keys_pressed & KEY_START)
		{
			hrt_ClearText();
            hrt_Print(0, 0, "coolio. the buttons work.");
            hrt_Print(0, 1, "now, the flag is somewhere on");
            hrt_Print(0, 2, "this screen.");
            hrt_Print(0, 4, "but where?!");
		}

        hrt_Print(5, -1, "_");
        hrt_Print(6, -1, blank);
        hrt_Print(19, -1, "}");
	}
}