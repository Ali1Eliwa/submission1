## Embedded Systems Project Report: ControlPoint

## 1. Introduction
This project is a solution for Element 1 of the KH5023FTE Embedded System Design & Development module. It demonstrates a fundamental embedded system for data acquisition and control using an AVR ATmega328P microcontroller.

The system performs two primary functions:
1.  It monitors the state of a digital push button and transmits status messages ("Button Pressed," "Button Released") to a PC via UART.
2.  It receives string commands ("Turn On," "Turn Off") from the PC to control a digital LED.

## 2. Project Code

**GitHub Repository:**
[submission_repo](https://github.com/Ali1Eliwa/submission1/tree/main/code/Application)

**Local Root Directory**
[link_to_local_root_directory](code/Application)

## 3. Test Cases

Test Cases are developed in **[Robot Framework](https://robotframework.org/)** Test steps
[robot_tests](test/assignment_test_cases.robot)

## 4. Bill of Materials (BOM)

**BOM**
[bom_file](bom/bom.csv)

**Optimized BOM**
[optimized_bom_file](bom/optimized_bom.csv)

## 5. Video Demonstration

[recorded_video](video/Test.mp4)


## 6. Design
[design_document](design/project_design_tpl.md)