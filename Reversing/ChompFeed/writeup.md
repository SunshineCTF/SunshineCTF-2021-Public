# [Live Reversing] ChompFeed

This challenge presents itself as a Buzzfeed-esque quiz with four questions.
After answering all four questions, the quiz picks one of 16 possible "gator types"
(actually types of reptiles). Your goal is for it to pick the "Lil' Chompy" gator
type. There is exactly one possible sequence of answers that will produce this
result, however. To solve this challenge, each of the four questions must be solved
individually.

## Helpful trick

At the beginning of `main`, the program checks if the environment variable
`CHOMPFEED_SECRET` is set to `chompAllDay`. If so, this turns on the global debug
flag which results in some extra debug info being printed. This debug info hints
that the return value from each of the quiz functions is a bitmask and also gives
away some useful variable names.

## Question 1: Which are better, alligators or crocodiles?

This one is easy, there are only two valid answers: `*gator*` and `*croc*`. Looking
at the values returned when each answer is provided shows that only `*gator*` will
set the `GATOR_LILCHOMPY` bit in the result.

## Question 2: Which Hogwarts house is your favorite?

This one is a bit more tricky. The user's input is compared to 4 strings that have
been XOR encrypted using the static key `lilchompy!`. These 4 strings are simply
"gryffindor", "hufflepuff", "ravenclaw", and "slytherin". Each one has a different
mask that it will return. Only the mask for "slytherin" contains the
`GATOR_LILCHOMPY` bit.

## Question 3: What's your favorite music artist?

This one compares the entered string against a jumbled version of the correct answer.
The jumbled string is "OMsra n ne defotsnM", which is formed by taking every third
character from the correct answer "Of Monsters and Men" and wrapping at the end.

## Question 4: What's your favorite number?

This one is fairly straightforward. It takes the user's provided number and compares
it in two parts. The low part is formed by computing the user's number modulo 0xfeed,
and the high part is formed by dividing the user's number with 0xfeed.

## Putting it all together

When all four correct answers are provided, the mask values returned from each of them
are combined together as the XOR key used to decrypt the flag and print it out.

```
$ ./chompfeed
+--------------------------------------+
| Find Out What Kind of Gator You Are! |
+--------------------------------------+
Are you a Chompy or a Notompy?
by Real Chompy Quizzes
Approved and edited by
ChompFeed Community Team

1. Which are better, alligators or crocodiles?
gators

2. Which Hogwarts house is your favorite?
slytherin

3. What's your favorite music artist?
Of Monsters and Men

4. What's your favorite number?
0xcafef00d

============================

Your ChompFeed Quiz Results:
THE ONE AND ONLY LIL' CHOMPY
Flag: sun{l1l_ch0mpys_s3lf_es7eem_i5_restor3d}
```
