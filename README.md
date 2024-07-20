# PDX Hackerspace Exit Poll

Exit Poll is a display that integrates with Home Assistant that lets you know about things that might need attention.

At PDX Hackerspace, the last person out should check on the physical security of the space and turn off some equipment. Member Kenny M had the idea of placing an electronic dashboard next to the door so that departing members could quickly see if anything needed attention.

We use Home Assistant to automate the space. Exit Poll uses Home Assistant data to display counts of open doors, unlocked doors, running water and AV equipment, all of which might need attention from the last person to leave the space.

## Hardware

Exit Poll is a 320x480 SPI TFT display wired to a CPU. It has an optional STEMMA QT/Qwiic that could be used to add sensors or other devices. It has an Adafruit Neopixel strip mounted on top of the case to help give a second visual indication of the space's state (red indicates something important needs attention, amber that something harmless needs attention, blue that it can't connect to Home Assistant).

The PCB is available at [OSHPark](https://oshpark.com/shared_projects/XYhfXWVI).

## Wiring

(this wiring chart is incorrect and needs to be updated)

| Display | TinyPico |
|-------|-------|
| VCC | 3V3 |
| GND | GND |
| CS | D0 |
| RESET | D1 |
| DC/RS | D2 |
| SDI (MOSI) | MOSI |
| SCK | SCK |
| LED | 3V3 |
| SDO (MISO) | NC |
| T_CLK | SCK |
| T_CS | D3 |
| T_DIN | MOSI |
| T_DO | MISO |
| T_IRQ | D4 |

