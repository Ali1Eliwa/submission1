//define the microcontroller clock speed of  "16MHz" for delay functions
#define F_CPU 16000000UL
//the avr libraries
#include <avr/io.h>
#include <string.h>
#include <util/delay.h>
//contain the uart header
#include "uart.h"

//the main functions
void led(void);
void ledOn(void);
void ledOff(void);
void button(void);
unsigned char button_pressed(void);

//main program starting point
int main(void) {
//set up the hardware components
    led();
    button();
    uart();

//temporary storage for incoming characters to form a command
    char buffCommand[20];
//index for command buffer
    unsigned char indxBuffer = 0;
//save the button starting state to detect changes
    unsigned char button_before = button_pressed();

//infinity loop to iterate continuously
    while (1) {
//check for incoming serial data
        if (ckeckData()) {
//read the character received 
            char recieve = read_data();

//process the buffer when a command terminator is found
            if (recieve == '\r' || recieve == '\n') {
                //null terminate the string
                buffCommand[indxBuffer] = '\0';     
                if (strcmp(buffCommand, "Turn On") == 0) {ledOn();} 
                //reset buffer for the next command
                else if (strcmp(buffCommand, "Turn Off") == 0) {ledOff();}
                indxBuffer = 0;}   

                else {
                //keep collecting the letters of the command
                if (indxBuffer < (sizeof(buffCommand) - 1)) {
                    buffCommand[indxBuffer++] = recieve;}}}

//check for button state change
        unsigned char button_now = button_pressed();
        if (button_now != button_before) {
            _delay_ms(50); //make sure its a real press
            button_now = button_pressed();

//if the press is real, send the text
            if (button_now != button_before) {
                if (button_now) {
                    send("Button Pressed\r\n", 0);} 
                else {
                    send("Button Released\r\n", 0);}
                button_before = button_now;}}}
    return 0;}

//configure the led pin "PB5" as output
void led(void) {DDRB |= (1 << DDB5);}

//turns the led on by setting the pin high
void ledOn(void) {PORTB |= (1 << PORTB5);}

//turns the led off by setting the pin low
void ledOff(void) {PORTB &= ~(1 << PORTB5);}

//configures the button pin "PD2" as an input with an internal pull up resistor
void button(void) {DDRD &= ~(1 << DDD2); PORTD |= (1 << PORTD2);}

//returns 1 if the button is pressed "pin is low", and 0 if its not`
unsigned char button_pressed(void) {return !(PIND & (1 << PIND2));}

