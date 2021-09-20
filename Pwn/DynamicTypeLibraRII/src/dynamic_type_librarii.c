#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define BUFSZ 0x10 * sizeof(double)

enum type {
    U32,
    U64,
    DOUBLE,
    LDOUBLE
};

typedef struct number {
    enum type t;
    const char *fmt_spec;
    uint8_t elem_sz;
    uint8_t cur_sz;
    uint8_t max_sz;
    uint8_t pad[7];
    uint8_t buf[BUFSZ];
    struct number *self;
    void (*del)(struct number *);
} __attribute__((packed)) number;

void init_chal(void) {
    alarm(60);
    setvbuf(stdin, 0, 2, 0);
    setvbuf(stdout, 0, 2, 0);
    system("echo '==========WELCOME========='");
}

uint8_t type_to_sz(enum type t) {
    switch (t) {
        case U32:
            return sizeof(uint32_t);
        case U64:
            return sizeof(uint64_t);
        case DOUBLE:
            return sizeof(double);
        case LDOUBLE:
            return sizeof(long double);
        default:
            exit(1);
            break;
    };
}

const char *type_to_fmt_spec(enum type t) {
    switch (t) {
        case U32:
            return "%u";
        case U64:
            return "%lu";
        case DOUBLE:
            return "%f";
        case LDOUBLE:
            return "%Lf";
        default:
            exit(1);
            break;
    };
}

void consume(void) {
    int c;
    while ((c = getc(stdin)) != '\n') {
        if(c == EOF) {
            exit(EXIT_FAILURE);
        }
    }
}

size_t read_int(void) {
    size_t i;
    if(1 != scanf(" %zu", &i)) {
        exit(EXIT_FAILURE);
    }
    consume();
    return i;
}

size_t get_numsz(void) {
    while (1) {
        printf("What size of numbers do you need to crunch?\n[0]: 32-Bit Integer\n[1]: 64-Bit\n[2]: 64-Bit Floating Point\n> ");
        size_t choice = read_int();
        if (choice < 0) {
            printf("\nInvalid.\n");
        } else {
            return choice;
        }
    }
}

number *new_number(size_t choice) {
    number *n = (number *)malloc(sizeof(number));
    n->t = choice;
    n->fmt_spec = type_to_fmt_spec(choice);
    n->elem_sz = type_to_sz(choice);
    n->cur_sz = 0;
    n->max_sz = BUFSZ / (n->elem_sz > 8 ? 8 : n->elem_sz);
    memset(n->buf, 0, BUFSZ);
    n->self = n;
    n->del = (void (*)(number *))free;
    return n;
}

size_t get_menuopt(void) {
    while (1) {
        printf("What would you like to do?\n[0]: Add all numbers\n[1]: Insert a number\n[2]: Remove a number\n[3]: Print numbers\n[4]: Exit\n> ");
        size_t menu_opt = read_int();
        if (menu_opt < 0 || menu_opt > 4) {
            printf("\nInvalid.\n");
        } else {
            return menu_opt;
        }
    }
}

void do_add(number *n) {
    switch (n->t) {
        case U32: {
            uint32_t accum = 0;
            for (uint8_t i = 0; i < n->cur_sz; i++, accum += *(uint32_t *)&n->buf[i * n->elem_sz])
                ;
            printf(n->fmt_spec, accum);
            printf("\n");
            break;
        }
        case U64: {
            uint64_t accum = 0;
            for (uint8_t i = 0; i < n->cur_sz; i++, accum += *(uint64_t *)&n->buf[i * n->elem_sz])
                ;
            printf(n->fmt_spec, accum);
            printf("\n");
            break;
        }
        case DOUBLE: {
            double accum = 0;
            for (uint8_t i = 0; i < n->cur_sz; i++, accum += *(double *)&n->buf[i * n->elem_sz])
                ;
            printf(n->fmt_spec, accum);
            printf("\n");
            break;
        }
        case LDOUBLE: {
            long double accum = 0.0;
            for (uint8_t i = 0; i < n->cur_sz; i++, accum += *(long double *)&n->buf[i * n->elem_sz])
                ;
            printf(n->fmt_spec, accum);
            printf("\n");
            break;
        }
        default:
            break;
    }
}

void do_ins(number *n) {
    if (n->cur_sz >= n->max_sz) {
        printf("Full!\n");
        return;
    }
    printf("What value?\n> ");
    switch (n->t) {
        case U32: {
            scanf(n->fmt_spec, (uint32_t *)&n->buf[n->cur_sz * n->elem_sz]);
            break;
        }
        case U64: {
            scanf(n->fmt_spec, (uint64_t *)&n->buf[n->cur_sz * n->elem_sz]);
            break;
        }
        case DOUBLE: {
            scanf(n->fmt_spec, (double *)&n->buf[n->cur_sz * n->elem_sz]);
            break;
        }
        case LDOUBLE: {
            scanf(n->fmt_spec, (long double *)&n->buf[n->cur_sz * n->elem_sz]);
            break;
        }
        default: {
            return;
        }
    }
    consume();
    n->cur_sz++;
}

void do_rem(number *n) {
    n->cur_sz--;
}

void do_prn(number *n) {
    printf("{\n");
    for (uint8_t i = 0; i < n->cur_sz; i++) {
        printf("    [%02zu]: ", i);
        switch (n->t) {
            case U32: {
                printf(n->fmt_spec, *(uint32_t *)&n->buf[i * n->elem_sz]);
                break;
            }
            case U64: {
                printf(n->fmt_spec, *(uint64_t *)&n->buf[i * n->elem_sz]);
                break;
            }
            case DOUBLE: {
                printf(n->fmt_spec, *(double *)&n->buf[i * n->elem_sz]);
                break;
            }
            case LDOUBLE: {
                printf(n->fmt_spec, *(long double *)&n->buf[i * n->elem_sz]);
                break;
            }
            default: {
                goto skip;
            }
        }
        printf(" ");
        for (uint8_t j = 0; j < n->elem_sz; j++) {
            printf("%02x", *(uint8_t *)&n->buf[(i * n->elem_sz) + j]);
        }
    skip:
        printf(";\n");
    }
    printf("};\n");
}

void do_opt(number *n, size_t menu_opt) {
    switch (menu_opt) {
        case 0:
            printf("Adding all numbers...\n");
            do_add(n);
            break;
        case 1:
            printf("Inserting a number...\n");
            do_ins(n);
            break;
        case 2:
            printf("Removing a number...\n");
            do_rem(n);
            break;
        case 3:
            printf("Printing...\n");
            do_prn(n);
            break;
        default:
            printf("\nInvalid.\n");
            break;
    }
}

int main(void) {
    init_chal();
    printf("Hi! I'm Big Byte, the Number Crunching Robot!\n");
    printf("Let's crunch some numbers!\n");
    size_t choice = get_numsz();
    number *n = new_number(choice);
    while (1) {
        size_t opt = get_menuopt();
        if (opt < 4) {
            do_opt(n, opt);
        } else {
            break;
        }
    }
    printf("Before you go, I want YOU to do some math!\n");
    printf("How big of a notebook do you need?\n> ");
    size_t nb_sz = read_int();
    uint8_t *notebook = (uint8_t *)malloc(nb_sz);
    printf("Finally, what's your name?");
    char *name = (char *)calloc(1, 0x30);
    read(0, name, 0x2f);
    puts("Ok, bye!");
    free(name);
}
