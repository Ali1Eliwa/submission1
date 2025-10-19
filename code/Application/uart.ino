//the avr libraries
#include <avr/io.h>
//this line is added just in case to make sure the code works with the atmega328p
#if !defined(__AVR_ATmega328P__)
#include <avr/iom328p.h>
#endif
//contain the uart header
#include "uart.h"

//define the microcontroller clock speed of  "16MHz" for delay functions
#define F_CPU 16000000UL
//define the desired baud rate for serial communication "9600 bits per second"
#define BAUD 9600

//configure the settings for serial communication
void uart(void) {
    baudrate(BAUD);
    UCSR0B = (1 << TXEN0) | (1 << RXEN0);
    UCSR0C = (1 << UCSZ01) | (1 << UCSZ00);}

//this function configures the baud rate by calculating the correct setting
void baudrate(unsigned short baudRate) {
    unsigned short ubrrValue = ((F_CPU / 16) / baudRate) - 1;
    UBRR0L = (unsigned char)(ubrrValue & 0xFF);
    UBRR0H = (unsigned char)((ubrrValue >> 8) & 0xFF);}

//makes sure the previous character is gone before putting the next one
void char_send(unsigned char char_to_send) {while (!(UCSR0A & (1 << UDRE0))); UDR0 = char_to_send;}

//sends a full message by sending each letter individually
void send(char str[], unsigned char size) {for (int i = 0; str[i] != '\0'; i++) {char_send(str[i]);}}

//checks if a new character is ready to be read
unsigned char ckeckData(void) {return (UCSR0A & (1 << RXC0));}

//waiting data to be received then reads and returns the character from the buffer
unsigned char read_data(void) {while (!(UCSR0A & (1 << RXC0))); return UDR0;}

