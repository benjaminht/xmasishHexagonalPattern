import processing.svg.*;

int tHeight = 30;

//randomized parameters
float lineDist,lineWidth;

//
float xMargin = 2.4;
float yMargin = 3;

void setup() {
  size(900, 350);
  
  beginRecord(SVG, "output.svg");
  noStroke();
  fill(50);
  rect(0,0,width,height);
  noFill();
  stroke(255);
  
  lineWidth = tHeight/10;  
  lineDist = tHeight/5;
  
  translate(tHeight*1.8, tHeight*1.8);
    for (float j = 0; j < floor((width/(tHeight*xMargin))); j++) {
      for (float k = 0; k < floor((height/((tHeight+0.5*yMargin)*yMargin))); k++) {
        
        pushMatrix();
        float hexoffset = j%2 == 0 ? 0 : 0.5;
        translate(j*(tHeight*xMargin), (k+hexoffset)*(tHeight*yMargin));
        new hexShape(tHeight, tHeight/random(2.4,10),tHeight/random(2.7,10));
        popMatrix();
    }
  }
  endRecord();
}
