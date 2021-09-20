#ifndef CHOMP_QUIZ_H
#define CHOMP_QUIZ_H

#include <stdint.h>
#include <stdbool.h>

#define QUIZ_NUM_QUESTIONS 4

typedef uint16_t GatorMask;
typedef enum GatorType GatorType;
enum GatorType {
	GATOR_IGUANA    = 1 << 0,
	GATOR_LIZARD    = 1 << 1,
	GATOR_SKINK     = 1 << 2,
	GATOR_CROCODILE = 1 << 3,
	GATOR_DINOSAUR  = 1 << 4,
	GATOR_NOTOMPY   = 1 << 5,
	GATOR_TURTLE    = 1 << 6,
#define LILCHOMPY_SHIFT 7
	GATOR_LILCHOMPY = 1 << LILCHOMPY_SHIFT,
	GATOR_PYTHON    = 1 << 8,
	GATOR_KOMODO    = 1 << 9,
	GATOR_DRAGON    = 1 << 10,
	GATOR_GECKO     = 1 << 11,
	GATOR_CHAMELEON = 1 << 12,
	GATOR_COBRA     = 1 << 13,
	GATOR_ANACONDA  = 1 << 14,
	GATOR_VIPER     = 1 << 15,
	GATOR_MAX       = GATOR_VIPER,
	GATOR_ALL       = 0xffff,
};

#define NUM_GATORS 16

typedef GatorMask QuizFunc(void);

extern bool g_debug;
extern QuizFunc* g_questions[QUIZ_NUM_QUESTIONS];

void Quiz_showResults(GatorMask answers[QUIZ_NUM_QUESTIONS]);

#endif /* CHOMP_QUIZ_H */
