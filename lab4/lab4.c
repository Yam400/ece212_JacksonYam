#include <stdio.h>
#include <stdlib.h>
#include "ece212.h"


void part1() {
    ece212_setup();
    while (1) {  // Repeats contents forever!
       writeLEDs(0xF);  
    }
}



int main() {
    // The entry-point of your C Program. Everything
    // that you want to run must be called from here.
    
    return (EXIT_SUCCESS);
}



