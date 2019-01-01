import processing.svg.*;

int tHeight = 60;

//randomized parameters
float lineDist,lineWidth;

//
float xMargin = 2.5;
float yMargin = 3.1;

void setup() {
  size(1200, 700);
  background(150);
  noFill();
  stroke(0);
  
  lineWidth = tHeight/10;  
  lineDist = tHeight/5;
  
  beginRecord(SVG, "output.svg");
  noFill();
  
  translate(tHeight*1.8, tHeight*1.8);
    for (float j = 0; j < floor((width/(tHeight*xMargin))); j++) {
      for (float k = 0; k < floor((height/(tHeight*yMargin))); k++) {
        
        pushMatrix();
        float hexoffset = j%2 == 0 ? 0 : 0.5;
        translate(j*(tHeight*xMargin), (k+hexoffset)*(tHeight*yMargin));
        new hexShape(tHeight, tHeight/random(2.4,10),tHeight/random(2.7,10));
        popMatrix();
    }
  }
  endRecord();
}