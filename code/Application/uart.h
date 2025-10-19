//this is a safety check to make sure the computer doesnt get confused
//by loading this file more than once
#ifndef __UART_H__
#define __UART_H__

//this file lists all the commands for serial communication
//so other parts of the program know whats available

//gets the serial communication ready to use
void uart(void);

//sets the speed for the serial 'talking'
void baudrate(unsigned short baudRate);

//sends just one letter
void char_send(unsigned char char_to_send);

//check if a new message has arrived
unsigned char ckeckData(void);

//reads the letter that was sent to us
unsigned char read_data();

//sends word or sentence
void send(char str[], unsigned char size);

#endif //this ends the safety check

