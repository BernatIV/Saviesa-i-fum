// P_2_3_3_01
//
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * draw tool. shows how to draw with dynamic elements. 
 * 
 * MOUSE
 * drag                : draw with text
 * 
 * KEYS
 * del, backspace      : clear screen
 * arrow up            : angle distortion +
 * arrow down          : angle distortion -
 * s                   : save png

 */

float x = 0, y = 0;
float stepSize = 5.0;
// String letters = "Cada intuicio fugac d'una vida millor ";
String letters = "Pero sempre miren, i el vaixell s’esta aturant, les comportes s’han obert i, en un segon, s’inunda el mar de soldats disparant a l’infinit amb un soldadet al mig, que carrega mentre insulta a l’enemic. I entre bomba i bomba tot li va prou be fins que una cau just al costat. Primer es diu “sort, de que t’ha anat…”, però després sent a l’esquena un dolor estrany i en tocar-se-la li queda tot el braç tacat de sang. Gira el cap a banda i banda. Seu a la sorra i descansa. I mentre arriba el coi de metge, el soldadet es tranquil•litza repetint què farà, on anirà, si sobreviu: “Aniré a ma mare ben vestit i, abans que res, li hauré de dir que em perdoni per tractar-la sempre així; aniré a la Margarida a fer-li un fill per, només veure’l, intuir que l’estimo més del que m’estimo a mi”";
int fontSizeMin = 3;
float angleDistortion = 0.0;
int counter = 0;

PFont toThePoint;
// PFont font;

PImage dibuix;

void setup() {
  // use full screen size 
  size(1170, 840);
  background(255);
  smooth();
  cursor(CROSS);
  
  toThePoint = createFont("ToThePoint.ttf", 16, true);
  // font = createFont("Georgia", 16, true);
  
  dibuix = loadImage("saviesaifum.png");
  image(dibuix, 0, 0);
 
  x = mouseX;
  y = mouseY;

  textAlign(LEFT);
  fill(0);

}

void draw() {
  if (mousePressed) {
    float d = dist(x,y, mouseX,mouseY);
    // textFont("Georgia");
    textFont(toThePoint);
    // textFont(font);
    
    textSize(fontSizeMin+d/2);
    char newLetter = letters.charAt(counter);
    stepSize = textWidth(newLetter);

    if (d > stepSize) {
      float angle = atan2(mouseY-y, mouseX-x); 

      pushMatrix();
      translate(x, y);
      rotate(angle + random(angleDistortion));
      text(newLetter, 0, 0);
      popMatrix();

      counter++;
     if (counter > letters.length() - 1) counter = 0;

      x = x + cos(angle) * stepSize;
      y = y + sin(angle) * stepSize; 
    }
  }
}

void mousePressed() {
  x = mouseX;
  y = mouseY;
}

void keyTyped() {
  if (key == 's' || key == 'S') save("P_2_3_3_01.png");
}

void keyPressed() {
  // angleDistortion ctrls arrowkeys up/down 
  if (keyCode == DELETE || keyCode == BACKSPACE) background(255);
  if (keyCode == UP) angleDistortion += 0.1;
  if (keyCode == DOWN) angleDistortion -= 0.1; 
}