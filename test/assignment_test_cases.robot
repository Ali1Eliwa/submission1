*** Settings ***
Documentation       Keyword-driven test plan for the SignalBox project.
...                 Validates UART command handling and button reporting.

Suite Setup         Perform Initial Setup

*** Keywords ***
Perform Initial Setup
    Log To Console    \n--- HARDWARE SETUP ---
    Log    1. Ensure firmware is flashed to the microcontroller.
    Log    2. Connect an LED to Pin 13.
    Log    3. Connect a push-button to Pin 2.
    Log    4. Open a Serial Monitor at 9600 baud.
    Log To Console    --- SETUP COMPLETE ---

Send Serial Command
    [Arguments]    ${command}
    Log    Action: In the Serial Monitor, type "${command}" and press Enter.

Verify LED State Is
    [Arguments]    ${expected_state}
    Log    Expected: The LED should be ${expected_state}.

Press And Hold The Button
    Log    Action: Press and hold the button.

Release The Button
    Log    Action: Release the button.

Verify Serial Monitor Shows
    [Arguments]    ${expected_message}
    Log    Expected: The message "${expected_message}" should appear in the Serial Monitor.

Verify System Does Not Crash
    Log    Expected: The board should not crash or reset. The LED state should not change.

Verify Single Clean Press Is Registered
    Log    Expected: See exactly one "Button Pressed" and one "Button Released" message.

Verify "Pressed" Message Appears Only Once
    Log    Action: Press the button and hold it for 5 seconds.
    Log    Expected: The "Button Pressed" message should appear only once at the start.

*** Test Cases ***
Test 01: Turn The LED On
    [Tags]    LED
    Send Serial Command    Turn On
    Verify LED State Is    ON

Test 02: Turn The LED Off
    [Tags]    LED
    [Setup]    Send Serial Command    Turn On
    Send Serial Command    Turn Off
    Verify LED State Is    OFF

Test 03: Check For Case-Sensitivity
    [Tags]    LED    Edge Case
    Send Serial Command    turn on
    Verify LED State Is    OFF

Test 04: Use An Unknown Command
    [Tags]    LED    Edge Case
    Send Serial Command    Blink LED
    Verify System Does Not Crash

Test 05: Use A Long Command To Test Buffer
    [Tags]    LED    Robustness
    Send Serial Command    This is a very long command designed to test the buffer limits
    Verify System Does Not Crash

Test 06: Report A Button Press
    [Tags]    Button
    Press And Hold The Button
    Verify Serial Monitor Shows    Button Pressed

Test 07: Report A Button Release
    [Tags]    Button
    [Setup]    Press And Hold The Button
    Release The Button
    Verify Serial Monitor Shows    Button Released

Test 08: Check Button Debounce
    [Tags]    Button    Robustness
    Log    Action: Tap the button quickly just once.
    Verify Single Clean Press Is Registered

Test 09: Check That Holding Button Does Not Spam
    [Tags]    Button    Edge Case
    Verify "Pressed" Message Appears Only Once

Test 10: Integration of Button and Command
    [Tags]    Integration
    Press And Hold The Button
    Verify Serial Monitor Shows    Button Pressed
    Send Serial Command    Turn On
    Verify LED State Is    ON
