import static javax.swing.JOptionPane.*;

PImage star, dot, save, add, refresh, addTitle, galaxy;
int prevX = -10;
int prevY = -10;
String title = " ";
Boolean titled;
ArrayList<Point> points = new ArrayList<Point>();

void setup() {
  size(800, 400);
  background(#041d3b);
  stroke(255, 255, 255, 100); 
  
  // add menu items
  save = loadImage("../save.png");
  add = loadImage("../add.png");
  refresh = loadImage("../refresh.png");
  addTitle = loadImage("../title.png");
  image(save, 740, 370);
  image(add, 770, 370);
  image(refresh, 700, 370);
  image(addTitle, 660, 370);
  
  // place stars randomly
  star = loadImage("../star.png");
  dot = loadImage("../dot.png");
  int numOfStars = 10;
  for(int i=0; i<numOfStars; i++){
   image(star, random(0, 765), random(0, 365));
  }
  for(int i=0; i<numOfStars; i++){
   image(dot, random(0, 765), random(0, 365));
  }
  
  titled = false;
}


void draw() {
  if(mouseX >= 660 && mouseY >= 370) cursor(HAND);   // hover over menu items & make clickable
  if(mouseX <= 660 || mouseY <= 370) cursor(ARROW);   // default when not on menu
}

void mousePressed() {
  if(mouseX <= 660 || mouseY <= 370){ //avoid buttons
    if(prevX != -10 && prevY != 10) line(prevX, prevY, mouseX, mouseY);    // args = start X/Y and end X/Y
    ellipse(mouseX,mouseY, 8, 8);
    points.add(new Point(mouseX, mouseY));
    println(points);
    prevX = mouseX;
    prevY = mouseY;
  }
  
  // MENU BUTTONS
  //refresh the screen
  if(mouseX <= 730 && mouseX >= 700 && mouseY >= 370){
    setup();
    points.clear();
    prevX = -10;
    prevY = -10;
  }
  
  // saving a constellation
  if(mouseX <= 770 && mouseX >= 740 && mouseY >= 370){
    PImage constellation = get(0, 0, 800, 370);  //crop out menu
    String timeStamp =  Integer.toString(day()) + Integer.toString(month()) + Integer.toString(year()) + Integer.toString(hour()) + Integer.toString(minute()) + Integer.toString(millis());
    constellation.save("constellations/constellation" + timeStamp + ".png");
    //textSize(16);
    //text("CONSTELLATION SAVED", 465, 385);
  }
  
  //add constellation to "galaxy"
  if(mouseX <= 800 && mouseX >= 770 && mouseY >= 370){
    if(!titled){
      title = showInputDialog("Would you like to title your constellation?");
      fill(255, 255, 255, 100);
      PFont mono = loadFont("CenturySchL-Ital-48.vlw");
      textFont(mono);
      textSize(20);
      if(title != null){
        titled = true; 
        text(title, 10, 30); 
      }
    }
    galaxy = loadImage("galaxy.png");
    PGraphics output = createGraphics(galaxy.width+800, galaxy.height, JAVA2D);
    output.beginDraw();
    output.image(galaxy, 0, 0);    
    PImage constellation = get(0, 0, 800, 370);  //crop out menu
    output.image(constellation, galaxy.width, 0);    
    output.endDraw();
    output.save("galaxy.png");
    setup();
    prevX = -10;
    prevY = -10;
  }
  //title constellation
  if(mouseX <= 700 && mouseX >= 670 && mouseY >= 370){
    if(!titled){
      title = showInputDialog("Title your constellation");
      fill(255, 255, 255, 100);
      PFont mono = loadFont("CenturySchL-Ital-48.vlw");
      textFont(mono);
      textSize(20);
      if(title != null){
        text(title, 10, 30); 
        titled = true;
      }
    }
    else{
       showMessageDialog(null, "Already Titled!");
     }
  }

}
class Point {
  
  float x;
  float y;
  
  Point(float X, float Y) {
    x = X;
    y = Y;
  }
}