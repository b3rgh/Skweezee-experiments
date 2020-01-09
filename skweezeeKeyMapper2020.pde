/* import related to Skweezee */ 
import processing.serial.*;
import net.skweezee.processing.*;

/* import related to generate key strokes */ 
import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.io.IOException;


Robot robot; // can generate native input events, such as key strokes
String log;  // stores a log of events

// UI
boolean set[];  // array to store which gestures are recorded
int last[];  // array to store timestaps of last trigger per gesture
color bg;  // background color
color side;  // sidebar background color
color txt;  // text color

void setup() {
  size(700, 450);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  
  // Skweezee
  Skweezee.connect(this);
  
  // key strokes
  try {
    robot = new Robot();
  } catch (Exception e) {
    e.printStackTrace();
    exit();
  }
  
  log = "";
  last = new int[]{0, 0, 0, 0, 0};
  
  // UI
  set = new boolean[]{false, false, false, false, false};
  bg = color(0, 0, 100);  // white
  side = color(0, 0, 95);  // light gray
  txt = color(0, 0, 0);  // black
  background(bg);
  
  frameRate(30);
  
}

void draw() {
  
  background(bg);
  
  fill(txt);
  text("Skweezee Key Mapper", 20, 30);
  text("Press SPACE or arrow keys to (re)record squeezes.", 20, 50);
  text("Squeeze: "+(int) (Skweezee.norm()*100), 20, 70);

  String values = "";
  
  if (set[0] == true) {
    values += "Space: "+Skweezee.rcg("space")+"\n";  
  }
  
  if (set[1] == true) {
    values += "Left: "+Skweezee.rcg("left")+"\n";  
  }
  
  if (set[2] == true) {
    values += "Right: "+Skweezee.rcg("right")+"\n";  
  }
  
  if (set[3] == true) {
    values += "Up: "+Skweezee.rcg("up")+"\n";  
  }
  
  if (set[4] == true) {
    values += "Down: "+Skweezee.rcg("down")+"\n";  
  }
  
  text(values, 20, 110);
  
  
  // Sidebar
  fill(side);
  rect(360, 0, width-360, height);
  
  fill(txt);
  text("LOG:", 360+20, 30);
  text(log, 360+20, 60);

  int now = millis();

  if (now-last[0] > 1000 && Skweezee.rcg("space") > 0.7) {
    last[0] = millis();
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> PRESSING SPACE\n"+log;
    robot.keyPress(KeyEvent.VK_SPACE);
    robot.keyRelease(KeyEvent.VK_SPACE);
  }
  
  if (now-last[1] > 1000 && Skweezee.rcg("left") > 0.7) {
    last[1] = millis();
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> PRESSING LEFT\n"+log;
    robot.keyPress(KeyEvent.VK_LEFT);
    robot.keyRelease(KeyEvent.VK_LEFT);  
  }
  
  if (now-last[2] > 1000 && Skweezee.rcg("right") > 0.7) {
    last[2] = millis();
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> PRESSING RIGHT\n"+log;
    robot.keyPress(KeyEvent.VK_RIGHT);
    robot.keyRelease(KeyEvent.VK_RIGHT); 
  }
  
  if (now-last[3] > 1000 && Skweezee.rcg("up") > 0.7) {
    last[3] = millis();
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> PRESSING UP\n"+log;
    robot.keyPress(KeyEvent.VK_UP);
    robot.keyRelease(KeyEvent.VK_UP);
  }
  
  if (now-last[4] > 1000 && Skweezee.rcg("down") > 0.7) {
    last[4] = millis();
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> PRESSING DOWN\n"+log;
    robot.keyPress(KeyEvent.VK_DOWN);
    robot.keyRelease(KeyEvent.VK_DOWN);
  }
  
}

void keyPressed() {
  
  // println(keyCode); // Find out keyCode

  if (Skweezee.norm() > 0 ) {

  if (!set[0] && keyCode == 32) { // SPACE
    Skweezee.rcd("space");
    set[0] = true;
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> SPACE RECORDED\n"+log;
  }
  
  if (!set[1] && keyCode == 37) { // LEFT
    Skweezee.rcd("left");
    set[1] = true;
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> LEFT RECORDED\n"+log;
  }
  
  if (!set[2] && keyCode == 39) { // RIGHT
    Skweezee.rcd("right");
    set[2] = true;
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> RIGHT RECORDED\n"+log;
  }
  
  if (!set[3] && keyCode == 38) { // UP
    Skweezee.rcd("up");
    set[3] = true;
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> UP RECORDED\n"+log;
  }
  
  if (!set[4] && keyCode == 40) { // DOWN
    Skweezee.rcd("down");
    set[4] = true;
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> DOWN RECORDED\n"+log;
  }
  
  } else {
  
    log = millis()/60000 + ":" + String.format("%02d", (millis()%60000)/1000)  + "> NO SKWEEZEE FOUND\n"+log; 
    
  }
  
  
  
}
