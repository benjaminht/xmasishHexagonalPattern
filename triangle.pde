import processing.svg.*;

int tHeight = 30;
float side, border;
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
  beginRecord(SVG, "stern.svg");
  noFill();
  
  pushMatrix();
  translate(tHeight*1.8, tHeight*1.8);
    for (float j = 0; j < floor((width/(tHeight*xMargin))); j++) {
      for (float k = 0; k < floor((height/(tHeight*yMargin))); k++) {
        
       lineDist = tHeight/random(2.4,10);
       linewidth = tHeight/random(2.7,10);
       
        side = tHeight/(sqrt(3)/2);
        border = (tHeight+linewidth)/(sqrt(3)/2);
        linewidth /= 2;
        
        if (linewidth > lineDist) lineDist = linewidth+(tHeight/20);
        
        pushMatrix();
        float hexoffset = j%2 == 0 ? 0 : 0.5;
        translate(j*(tHeight*xMargin), (k+hexoffset)*(tHeight*yMargin));
        textSize(10);
        //text(String.format("%.1f", linewidth)+" "+String.format("%.1f", lineDist,2), -tHeight/2, tHeight*1.6);
         for (int i = 0; i < 6; i++) {
          pushMatrix();
          rotate(radians(60*i));
          
          // outer border
          beginShape();
           vertex(border/2, -(tHeight+linewidth*2));
           vertex(-border/2, -(tHeight+linewidth*2));
           endShape();
        
          // small tringale
          beginShape();
          vertex((side/2)-hypo(lineDist+linewidth, 60), -tHeight);
          vertex(0, -hypo(lineDist+linewidth, 30));
          vertex(-((side/2)-hypo(lineDist+linewidth, 60)), -tHeight);
          vertex((side/2)-hypo(lineDist+linewidth, 60), -tHeight);
          endShape();
        
          beginShape();
          vertex(side/2, -tHeight);
          vertex((side/2)-hypo(lineDist-linewidth, 60), -tHeight);
          vertex(aKat(hypo(linewidth, 30), 60), -hypo(lineDist, 30));
          vertex(aKat(hypo(lineDist+linewidth, 30)/2, 60), -hypo(lineDist+linewidth, 30)/2);
          endShape();
        
          beginShape();
          vertex(-(side/2), -tHeight);
          vertex(-((side/2)-hypo(lineDist-linewidth, 60)), -tHeight);
          vertex(-aKat(hypo(linewidth, 30), 60), -hypo(lineDist, 30));
          vertex(-aKat(hypo(lineDist+linewidth, 30)/2, 60), -hypo(lineDist+linewidth, 30)/2);
          endShape();
        
          beginShape();
          vertex(aKat(hypo(lineDist-linewidth, 30)/2, 60), -hypo(lineDist-linewidth, 30)/2);
          vertex(0, -hypo(lineDist-linewidth, 30));
          vertex(-aKat(hypo(lineDist-linewidth, 30)/2, 60), -hypo(lineDist-linewidth, 30)/2);
          endShape();
          
          popMatrix();
        }
      popMatrix();
    }
  }
  popMatrix();
  endRecord();
}

// get hypothenuse from ankathete and angle
float hypo(float ankathete, float winkel) {
  return (ankathete/sin(radians(winkel)));
}

// get ankathete from gegenkathete and angle
float aKat(float gegenkathete, float winkel) {
  return (gegenkathete/tan(radians(winkel)));
}
