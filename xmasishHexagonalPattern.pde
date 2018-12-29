import processing.svg.*;

int tHeight = 30;
float side, border;

//randomized parameters
float lineDist = 5;
float linewidth = 2;

float xMargin = 2.5;
float yMargin = 3.1;

void setup() {
  size(1200, 700);
  background(50);
  noFill();
  stroke(255);
  
  lineDist = tHeight/2.4;
  linewidth = tHeight/10;
  
  lineDist = tHeight/5;
  beginRecord(SVG, "output.svg");
  noFill();
  
  translate(tHeight*1.8, tHeight*1.8);
    for (float j = 0; j < floor((width/(tHeight*xMargin))); j++) {
      for (float k = 0; k < floor((height/(tHeight*yMargin))); k++) {
        
        pushMatrix();
        float hexoffset = j%2 == 0 ? 0 : 0.5;
        translate(j*(tHeight*xMargin), (k+hexoffset)*(tHeight*yMargin));
        drawHexShape(tHeight/random(2.4,10),tHeight/random(2.7,10));
        popMatrix();
    }
  }
  endRecord();
}

//some basic trigonometry for better readability

// get hypothenuse from adjacent leg and angle
float hypothenuse(float adjacentLeg, float angle) {
  return (adjacentLeg/sin(radians(angle)));
}

// get adjacent leg from opposite leg and angle
float adjacentLeg(float oppositeLeg, float angle) {
  return (oppositeLeg/tan(radians(angle)));
}