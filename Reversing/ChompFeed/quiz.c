#include "quiz.h"
#include <stdio.h>
#include <stddef.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>


bool g_debug;

static void readLine(char* buf, size_t size) {
	if(!fgets(buf, size, stdin)) {
		exit(EXIT_FAILURE);
	}
	
	char* newline = strchr(buf, '\n');
	if(newline) {
		*newline = '\0';
	}
}

static void str2lower(char* s) {
	// Convert to lowercase
	while(*s != '\0') {
		char c = *s;
		*s++ = tolower(c);
	}
}

static GatorMask Quiz_askCrocOrGator(void) {
	// Answer: *gator* (duh), mask: 0x18e7
	
	char line[50];
	
	printf("Which are better, alligators or crocodiles?\n");
	readLine(line, sizeof(line));
	str2lower(line);
	
	GatorMask mask = 0;
	if(strstr(line, "gator")) {
		mask = GATOR_CHAMELEON | GATOR_GECKO | GATOR_IGUANA | GATOR_LILCHOMPY | GATOR_LIZARD | GATOR_NOTOMPY | GATOR_SKINK | GATOR_TURTLE;
	}
	else if(strstr(line, "croc")) {
		mask = GATOR_ANACONDA | GATOR_COBRA | GATOR_CROCODILE | GATOR_DINOSAUR | GATOR_DRAGON | GATOR_KOMODO | GATOR_PYTHON | GATOR_VIPER;
	}
	else {
		printf("Come on, this was the easiest question!\n");
		exit(EXIT_FAILURE);
	}
	
	if(g_debug) {
		fprintf(stderr, "Mask is %#hx\n", mask);
	}
	return mask;
}

static GatorMask Quiz_askHogwartsHouse(void) {
	// Answer: slytherin (duh), mask: 0xe180
	
	char line[50];
	
	printf("Which Hogwarts house is your favorite?\n");
	readLine(line, sizeof(line));
	str2lower(line);
	
	// "gryffindor"
	// "hufflepuff"
	// "ravenclaw"
	// "slytherin"
	// xor key is:
	// "lilchompy!"
	
	struct gator_house {
		const char* xored;
		GatorMask mask;
	};
	
	// XOR key is "lilchompy!"
	const static struct gator_house houses[4] = {
		{ // "gryffindor"
			"\x0b\x1b\x15\x05\x0e\x06\x03\x14\x16\x53",
			GATOR_NOTOMPY | GATOR_ANACONDA | GATOR_CHAMELEON | GATOR_CROCODILE | GATOR_DINOSAUR | GATOR_DRAGON | GATOR_IGUANA | GATOR_KOMODO | GATOR_PYTHON | GATOR_SKINK
		},
		{ // "hufflepuff"
			"\x04\x1c\x0a\x05\x04\x0a\x1d\x05\x1f\x47",
			GATOR_NOTOMPY | GATOR_GECKO | GATOR_CHAMELEON | GATOR_IGUANA | GATOR_LIZARD | GATOR_SKINK | GATOR_TURTLE
		},
		{ // "ravenclaw"
			"\x1e\x08\x1a\x06\x06\x0c\x01\x11\x0e",
			GATOR_NOTOMPY | GATOR_CROCODILE | GATOR_DINOSAUR | GATOR_DRAGON | GATOR_KOMODO | GATOR_COBRA | GATOR_VIPER
		},
		{ // "slytherin"
			"\x1f\x05\x15\x17\x00\x0a\x1f\x19\x17",
			GATOR_LILCHOMPY | GATOR_ANACONDA | GATOR_COBRA | GATOR_PYTHON | GATOR_VIPER
		},
	};
	
	// Compare answer against each xored house name
	size_t i;
	for(i = 0; i < 4; i++) {
		const char* p = &line[0];
		const char* xored = houses[i].xored;
		const char* key = "lilchompy!";
		bool fail = false;
		while(*p != '\0' && *key != '\0') {
			uint8_t x = *p++;
			uint8_t y = *xored++;
			uint8_t z = *key++;
			
			// TODO: remove this
			// fprintf(stderr, "House #%zu: %#hhx vs %#hhx ^ %#hhx = %#hhx\n", i + 1, x, y, z, y ^ z);
			if(x != (uint8_t)(y ^ z)) {
				// fprintf(stderr, "House #%zu FAIL\n", i + 1);
				fail = true;
				break;
			}
		}
		if(!fail) {
			break;
		}
	}
	
	if(i > 4) {
		printf("I'm not sure what that is but it's definitely not a Hogwarts house!\n");
		exit(EXIT_FAILURE);
	}
	
	GatorMask mask = houses[i].mask;
	if(g_debug) {
		fprintf(stderr, "Selected house #%zu, mask: %#hx\n", i + 1, mask);
	}
	
	return mask;
}

GatorMask Quiz_askFavoriteBand(void) {
	// Answer: Of Monsters and Men, mask: 0xffff
	
	char line[50];
	printf("What's your favorite music artist?\n");
	readLine(line, sizeof(line));
	
	// "Of Monsters and MenOf Monsters and MenOf Monsters and Men"
	//  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^
	//  O--M--s--r--a-- --n-- --n--e-- --d--e--f--o--t--s--n--M
	// "OMsra n ne defotsnM"
	const size_t stride = 3;
	const char* jumbled_answer = "OMsra n ne defotsnM";
	const size_t answer_len = strlen(jumbled_answer);
	
	if(strlen(line) != answer_len) {
		return GATOR_NOTOMPY;
	}
	
	// By default, all gators are possible.
	// Each time a character is found that doesn't match,
	// a bit is turned off in the mask (starting at bit 0).
	GatorMask mask = (GatorMask)GATOR_ALL;
	size_t i;
	size_t fail_count = 0;
	for(i = 0; i < answer_len; i++) {
		char a = line[(i * stride) % answer_len];
		char b = jumbled_answer[i];
		//TODO: remove this
		// fprintf(stderr, "%zu: %c, %c\n", i, a, b);
		if(a != b) {
			mask &= ~(1 << (fail_count++ % NUM_GATORS));
		}
	}
	
	// The first incorrect character turns off bit 0, so rotate the mask
	// left such that if only that bit is turned off, it just turns off
	// the GATOR_LILCHOMPY bit.
	mask = (mask << LILCHOMPY_SHIFT) | (mask >> (NUM_GATORS - LILCHOMPY_SHIFT));
	
	if(g_debug) {
		fprintf(stderr, "fail_count = %zu, mask: %#hx\n", fail_count, mask);
	}
	return mask;
}

GatorMask Quiz_askFavoriteNumber(void) {
	// Answer: 0xcafef00d, mask: 0xf08d
	
	char line[50];
	printf("What's your favorite number?\n");
	readLine(line, sizeof(line));
	
	char* end = NULL;
	unsigned long number = strtoul(line, &end, 0);
	if(!end || *end != '\0') {
		printf("https://simple.wikipedia.org/wiki/Number\n");
		exit(EXIT_FAILURE);
	}
	
	// For non-matching numbers, use the number as a bitmask to turn
	// off bits in the gator mask
	GatorMask mask = (GatorMask)number;
	
	// Without this, gcc optimizes the division into a subtraction
	// with a magic constant and a less than comparison. Mind blown.
	static volatile unsigned long dividend = 0xfeed;
	
	// Only winning number is 0xcafef00d
	if(number % dividend != 0xea28) {
		mask &= ~GATOR_LILCHOMPY;
	}
	else if(number / dividend != 0xcbd9) {
		mask &= ~GATOR_LILCHOMPY;
	}
	else {
		mask |= GATOR_LILCHOMPY;
	}
	
	if(g_debug) {
		fprintf(stderr, "Mask: %#hx\n", mask);
	}
	return mask;
}

QuizFunc* g_questions[QUIZ_NUM_QUESTIONS] = {
	&Quiz_askCrocOrGator,
	&Quiz_askHogwartsHouse,
	&Quiz_askFavoriteBand,
	&Quiz_askFavoriteNumber,
};


static void Quiz_describeGator(GatorType kind) {
	switch(kind) {
		case GATOR_IGUANA:
			printf("You are the stoic iguana.\n");
			break;
		
		case GATOR_LIZARD:
			printf("You are just an ordinary lizard. How boring.\n");
			break;
		
		case GATOR_SKINK:
			printf("You're the sly and dastardly skink.\n");
			break;
		
		case GATOR_CROCODILE:
			printf("You are a crocodile, who is clearly inferior in every way to alligators!\n");
			break;
		
		case GATOR_DINOSAUR:
			printf("Dinosaurs were thought to be extinct, yet here you are to prove those scientists wrong!\n");
			break;
		
		case GATOR_NOTOMPY:
			printf("You're one of nature's truly magnificent creatures, an alligator!\n");
			printf("What a beautiful specimen you are!\n");
			printf("Ah, if only you were Lil Chompy. Which you aren't. Just to be clear.\n");
			break;
		
		case GATOR_TURTLE:
			printf("You're a turtle. Slow and steady may win the race, but Lil Chompy would still beat you!\n");
			break;
		
		case GATOR_LILCHOMPY:
			printf("You're a cheater :)\n");
			exit(EXIT_FAILURE);
		
		case GATOR_PYTHON:
			printf("Hello Ms. Python! I know how to speak your language! Watch!\n");
			printf("import os\n");
			printf("os.system(\"echo \\\"hisssss\\\"\")\n");
			break;
		
		case GATOR_KOMODO:
			printf("You're a komodo dragon, the most pathetic dragon of all time.\n");
			printf("You don't have wings OR breathe fire.\n");
			printf("Like, why are you even called a dragon?\n");
			break;
		
		case GATOR_DRAGON:
			printf("Dragons are supposedly mythical creatures, yet here you are!\n");
			break;
		
		case GATOR_GECKO:
			printf("Can you help me save money on my car insurance?\n");
			printf("Oh, you say you aren't *that* type of gecko?\n");
			break;
		
		case GATOR_CHAMELEON:
			printf("I almost didn't see you there with your natural camouflage ability!\n");
			printf("You certainly saw me with your swiveling chameleon eyes.\n");
			break;
		
		case GATOR_COBRA:
			printf("You're the type to stand on your tip-toes in photos to appear taller, aren't you?\n");
			printf("Makes sense that you'd be a cobra.\n");
			break;
		
		case GATOR_ANACONDA:
			printf("You're an anaconda. Does this mean you're clingy and suffocating?\n");
			break;
		
		case GATOR_VIPER:
			printf("Your words are venomous. As is your venom dripping from your fangs.\n");
			printf("You're a viper! (No, not the car.)\n");
			break;
		
		default:
			exit(EXIT_FAILURE);
	}
}

void Quiz_showResults(GatorMask answers[QUIZ_NUM_QUESTIONS]) {
	// Count the gator bits from each quiz answer
	int counts[16] = {0};
	unsigned i, gator;
	for(i = 0; i < QUIZ_NUM_QUESTIONS; i++) {
		for(gator = 0; gator < NUM_GATORS; gator++) {
			if(answers[i] & (1 << gator)) {
				counts[gator]++;
			}
		}
	}
	
	// Find the quiz answer with the highest count
	unsigned max_idx = 0;
	int max = -1;
	for(gator = 0; gator < NUM_GATORS; gator++) {
		if(counts[gator] > max) {
			max = counts[gator];
			max_idx = gator;
		}
	}
	
	printf("\n");
	printf("============================\n");
	printf("\n");
	printf("Your ChompFeed Quiz Results:\n");
	
	if((1 << max_idx) == GATOR_LILCHOMPY) {
		if(max < QUIZ_NUM_QUESTIONS) {
			printf("You are an alligator who one day aspires to be like Lil Chompy.\n");
			printf("Sadly, you're not quite there yet. You have only %.0f%% of the greatness of Lil Chompy.\n", (float)max * (100.0f / (float)QUIZ_NUM_QUESTIONS));
		}
		else {
			printf("THE ONE AND ONLY LIL' CHOMPY\n");
			
			// Build an XOR key from the quiz answers, concatenated
			// With correct answers: "\xE7\x18\x80\xE1\xFF\xFF\x8D\xF0"
			char xor_buf[QUIZ_NUM_QUESTIONS * 2];
			for(i = 0; i < QUIZ_NUM_QUESTIONS; i++) {
				xor_buf[i * 2] = answers[i];
				xor_buf[i * 2 + 1] = answers[i] >> 8;
			}
			
			// TODO: remove this
			// fprintf(stderr, "xor_buf = \"");
			// for(i = 0; i < sizeof(xor_buf); i++) {
			// 	fprintf(stderr, "\\x%2hhX", (uint8_t)xor_buf[i]);
			// }
			// fprintf(stderr, "\";\n");
			
			printf("Flag: ");
			
			// Decrypt the flag by xoring it against the quiz answers (cycled)
			const char* flag_enc = "\x94\x6d\xee\x9a\x93\xce\xe1\xaf\x84\x70\xb0\x8c\x8f\x86\xfe\xaf\x94\x2b\xec\x87\xa0\x9a\xfe\xc7\x82\x7d\xed\xbe\x96\xca\xd2\x82\x82\x6b\xf4\x8e\x8d\xcc\xe9\x8d";
			for(i = 0; flag_enc[i] != '\0'; i++) {
				putchar(flag_enc[i] ^ xor_buf[i % (QUIZ_NUM_QUESTIONS * 2)]);
			}
			printf("\n");
		}
	}
	else if(max > 0) {
		Quiz_describeGator((GatorType)(1 << max_idx));
	}
	else {
		printf("How...?\n");
		exit(EXIT_FAILURE);
	}
}
