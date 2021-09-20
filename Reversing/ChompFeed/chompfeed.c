#include <stdio.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include "quiz.h"


int main(void) {
	const char* var = getenv("CHOMPFEED_SECRET");
	if(var && strcmp(var, "chompAllDay") == 0) {
		g_debug = true;
	}
	
	printf("+--------------------------------------+\n");
	printf("| Find Out What Kind of Gator You Are! |\n");
	printf("+--------------------------------------+\n");
	printf("Are you a Chompy or a Notompy?\n");
	printf("by Real Chompy Quizzes\n");
	printf("Approved and edited by\n");
	printf("ChompFeed Community Team\n");
	
	GatorMask answers[QUIZ_NUM_QUESTIONS] = {0};
	size_t i;
	for(i = 0; i < QUIZ_NUM_QUESTIONS; i++) {
		printf("\n%zu. ", i + 1);
		answers[i] = g_questions[i]();
	}
	
	Quiz_showResults(answers);
	
	return 0;
}
