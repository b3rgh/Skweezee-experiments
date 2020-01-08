import processing.serial.*;
import net.skweezee.processing.*;

import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.io.IOException;

int timestamp;
Robot robot;

color bg;
color light;
color txt;

String log;

void setup() {
  
  size(700, 450);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  
  Skweezee.connect(this);
  
  bg = color(0, 0, 100);
  txt = color(0, 0, 0);
  
  background(bg);
  
  timestamp = 0;
  log = "";
  
  try {
      robot = new Robot();
    }
    catch (Exception e) {
      e.printStackTrace();
      exit();
    }
    
}

void draw() {
  
  background(bg);
  
  fill(txt);
  text("Skweezee Key Mapper", 20, 30);
  text("Press SPACE or arrow keys to (re)record squeezes.", 20, 50);
  text("Squeeze: "+(int) Skweezee.norm()*100, 20, 70);
  
  float xs = Skweezee.rcg("space");
  float xl = Skweezee.rcg("left");
  float xr = Skweezee.rcg("right");
  float xu = Skweezee.rcg("up");
  float xd = Skweezee.rcg("down");
  
  if (xs == 0.0) text("Space: <squeeze and press SPACE to record>", 20, 110);
  else text("Space: "+xs, 20, 110);
  
  if (xl == 0.0) text("Left: <squeeze and press LEFT to record>", 20, 130);
  else text("Left: "+xl, 20, 130);
  
  if (xr == 0.0) text("Right: <squeeze and press RIGHT to record>", 20, 150);
  else text("Right: "+xr, 20, 150);
  
  if (xu == 0.0) text("Up: <squeeze and press UP to record>", 20, 170);
  else text("Up:"+xu, 20, 170);
  
  if (xd == 0.0) text("Down: <squeeze and press DOWN to record>", 20, 190);
  else text("Down: "+xd, 20, 190);
  
  
  fill(0, 0, 95);
  rect(360, 0, width-360, height);
  
  fill(txt);
  text("LOG:", 360+20, 30);
  text(log, 360+20, 60);


  if (Skweezee.rcg("space") > 0.8) {
    if(millis() - timestamp > 1000) {
      timestamp = millis();
      log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> PRESSING SPACE\n"+log;
      robot.keyPress(KeyEvent.VK_SPACE);  
    }
  }
  
  if (Skweezee.rcg("left") > 0.7) {
    if(millis() - timestamp > 1000) {
      timestamp = millis();
      log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> PRESSING LEFT\n"+log;
      robot.keyPress(KeyEvent.VK_LEFT);  
    }
  }
  
  if (Skweezee.rcg("right") > 0.7) {
    if(millis() - timestamp > 1000) {
      timestamp = millis();
      log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> PRESSING RIGHT\n"+log;
      robot.keyPress(KeyEvent.VK_RIGHT);  
    }
  }
  
  if (Skweezee.rcg("up") > 0.7) {
    if(millis() - timestamp > 1000) {
      timestamp = millis();
      log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> PRESSING UP\n"+log;
      robot.keyPress(KeyEvent.VK_UP);  
    }
  }
  
  if (Skweezee.rcg("down") > 0.7) {
    if(millis() - timestamp > 1000) {
      timestamp = millis();
      log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> PRESSING DOWN\n"+log;
      robot.keyPress(KeyEvent.VK_DOWN);  
    }
  }
  
}

void keyPressed() {
  
  // println(keyCode); // Find out keyCode

  if (Skweezee.norm() > 0 ) {

  if (keyCode == 32) { // SPACE
    Skweezee.rcd("space");
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> SPACE RECORDED\n"+log;
  }
  
  if (keyCode == 37) { // LEFT
    Skweezee.rcd("left");
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> LEFT RECORDED\n"+log;
  }
  
  if (keyCode == 39) { // RIGHT
    Skweezee.rcd("right");
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> RIGHT RECORDED\n"+log;
  }
  
  if (keyCode == 38) { // UP
    Skweezee.rcd("up");
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> UP RECORDED\n"+log;
  }
  
  if (keyCode == 40) { // DOWN
    Skweezee.rcd("down");
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> DOWN RECORDED\n"+log;
  }
  
  } else {
  
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> NO SKWEEZEE FOUND\n"+log; 
    
  }
  
  
  
}
