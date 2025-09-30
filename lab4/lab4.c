#include <stdio.h>
#include <stdlib.h>
#include "ece212.h"


void part1() {
    ece212_setup();
    while (1) {  // Repeats contents forever!
       writeLEDs(0xF);  
    }
}

void part2(){
    ece212_setup();
    while(1){
        writeLEDs(0x1);
        delayms(200);
        writeLEDs(0x2);
        delayms(200);
        writeLEDs(0x4);
        delayms(200);
        writeLEDs(0x8);
        delayms(200);
    }
    
}

void part3(){
    ece212_lafbot_setup();
    while(1){
        RFORWARD = 0x7FFF;
        LFORWARD = 0x7FFF;
        RBACK = 0x0000;
        LBACK = 0x0000;
        delayms(500);
        RBACK = 0x7FFF;
        LBACK = 0x7FFF;
        RFORWARD = 0x0000;
        LFORWARD = 0x0000;
        delayms(500);
    }
}

void part4() {
    ece212_lafbot_setup();
    while (1){
        int Leftval = analogRead(LEFT_SENSOR);
        int Rightval = analogRead(RIGHT_SENSOR);
        if(Leftval < 0x180 && Rightval < 0x180){
            RFORWARD = 0x7FFF;
            LFORWARD = 0x7FFF;
            RBACK = 0x0000;
            LBACK = 0x0000;
            writeLEDs(0x1);
            delayms(20);
        } else if(Leftval > 0x180 && Rightval < 0x180){
            RFORWARD = 0x7FFF;
            LFORWARD = 0x0000;
            RBACK = 0x0000;
            LBACK = 0x0000;
            writeLEDs(0x2);
            delayms(20);
        } else if (Leftval < 0x180 && Rightval > 0x180){
            RFORWARD = 0x0000;
            LFORWARD = 0x7FFF;
            RBACK = 0x0000;
            LBACK = 0x0000;
            writeLEDs(0x4);
            delayms(20);
        }
    }
}

int main() {
    // The entry-point of your C Program. Everything
    // that you want to run must be called from here.
    
    part4();
    
    
    return (EXIT_SUCCESS);
}



