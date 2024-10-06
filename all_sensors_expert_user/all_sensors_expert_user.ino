/*****************************************************************************/
//	Function:    Get the accelemeter of X/Y/Z axis and print out on the
//					serial monitor.
//  Hardware:    3-Axis Digital Accelerometer(��16g)
//	Arduino IDE: Arduino-1.0
//	Author:	 Frankie.Chu
//	Date: 	 Jan 11,2013
//	Version: v1.0
//	by www.seeedstudio.com
//
//  This library is free software; you can redistribute it and/or
//  modify it under the terms of the GNU Lesser General Public
//  License as published by the Free Software Foundation; either
//  version 2.1 of the License, or (at your option) any later version.
//
//  This library is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
//  Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public
//  License along with this library; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
//
/*******************************************************************************/

#include <Wire.h>
#include "MMA7660.h"
MMA7660 accelemeter;
#include <Adafruit_NeoPixel.h>

#define FORCE_SENSOR_PIN A6
#define LED_PIN 6

#define LED_COUNT 1
Adafruit_NeoPixel strip(LED_COUNT, LED_PIN, NEO_GRB + NEO_KHZ800);

int value;
int const potSlider = A2;
int potVal;


const int AD_PIN = A1;
byte previousButton = 0;

void setup() {
    Serial.begin(57600);
    accelemeter.init();

    strip.begin();
    strip.show();
}

void loop() {

     // put your main code here, to run repeatedly:
    int adValue = analogRead(AD_PIN);
    byte button = buttonFromValue(adValue);

    if (button != previousButton) {
        if (button != 0) {
            Serial.print("button_");
            Serial.print(button);
            Serial.print(" ");
            Serial.print(1);
            Serial.println("");
        } else {
            Serial.print("button_");
            Serial.print(previousButton);
            Serial.print(" ");
            Serial.print(0);
            Serial.println("");
        }
        previousButton = button;
    }
  
    int8_t x;
    int8_t y;
    int8_t z;
    float ax, ay, az;
    accelemeter.getXYZ(&x, &y, &z);
    
    Serial.println("");
    Serial.print(" x ");
    Serial.print(x );
    Serial.println("");
    Serial.print(" y ");
    Serial.print(y );
    Serial.println("");
    Serial.print(" z ");
    Serial.print(z );

    accelemeter.getAcceleration(&ax, &ay, &az);
    Serial.println("");
    Serial.print(" xg ");
    Serial.print(ax );
    Serial.println("");
    Serial.print(" yg ");
    Serial.print(ay );
    Serial.println("");
    Serial.print(" zg ");
    Serial.print(az );
    Serial.println("");
    delay(100);


//slider code
  float voltage = potVal * (3.3 / 1023.0);
  potVal = analogRead(potSlider);
  Serial.print("slider ");
  Serial.print(potVal);
  Serial.println("");
  delay(10);



   
  int analogReading = analogRead(FORCE_SENSOR_PIN);

  Serial.print("Force_sensor ");
  Serial.print(analogReading);
  Serial.println(""); // print the raw analog reading

  // if (analogReading < 10)       // from 0 to 9
  //   Serial.println(" -> no pressure");
  // else if (analogReading < 200) // from 10 to 199
  //   Serial.println(" -> light touch");
  // else if (analogReading < 500) // from 200 to 499
  //   Serial.println(" -> light squeeze");
  // else if (analogReading < 800) // from 500 to 799
  //   Serial.println(" -> medium squeeze");
  // else // from 800 to 1023
  //   Serial.println(" -> big squeeze");

  delay(100);

  if(Serial.available() > 0) {

  value = Serial.read();
  // Serial.println(value);

  if(value == 1) {
    strip.setPixelColor(0, strip.Color(255, 0, 0));
    strip.setPixelColor(1, strip.Color(255, 20, 255));
    // colorWipe(strip.Color(255, 0, 0), 500);
    strip.show();
  } 
  else if(value == 0) {

    strip.setPixelColor(0, strip.Color(0, 20, 255));
    strip.setPixelColor(1, strip.Color(0, 20, 255));
    // colorWipe(strip.Color(255, 0, 0), 500);
    strip.show();
         
 }

}

}

//buttons
byte buttonFromValue(int adValue) {
  if(adValue > 300 && adValue < 500) {
    return 1;
  }

  if(adValue > 500 && adValue < 700) {
    return 2;

  }

  if(adValue > 700 && adValue < 900) {
    return 3;
  }

  if(adValue > 900) {
    return 4;
  }

  return 0;
}




