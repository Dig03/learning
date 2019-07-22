#include <stdio.h>

void increment(int *n) {
    /* Increment (++) the value-of (*) n. */
    (*n)++;
}

int main() {
    int a = 1;
    /* 
        This defines a pointer pa.
        A pointer stores the address of a particular object.
        Therefore the pointer must be initialised with the address-of (&) that object.
    */
    int *pa = &a;
    /* Both will return the same address, (e.g. 0060FF08). */
    printf("pa has value: %p\n", pa);
    printf("Address of a: %p\n", &a);
    /* Pointers can access the variable they point to. */
    printf("a: %i = pa: %i\n", a, *pa);
    a += 1;
    printf("After `a += 1;`, a = %i\n", a);
    /* 
        The `*` operator both describes a pointer and the value-of operation.
        Therefore when we have a pointer to access what it "points" to, we must use `*`.
    */
    *pa -= 1;
    printf("After `*pa -= 1;`, a = %i\n", a);
    /* 
        Pointers can also be used to optimise functions.
        Usually when a function f(x, y) is called, the variables x and y will be copied
        across to the function, wasting memory.
        If we instead pass a pointer to that function, then the function can simply
        "dereference" or find the value-of (*) that pointer, and modify it dynamically.

        Because such a function must take a pointer as input, we must pass the address-of (&)
        the variable we wish to work with.
    */
    increment(&a);
    printf("After `increment(&a);`, a = %i\n", a);
    return 0;
}