class hexShape { 
  float side, border;
  PShape fragment,outerBorder,triangle,hole,star;
  hexShape(float tHeight, float lineDist, float lineWidth) {    
    side = tHeight/(sqrt(3)/2);
    border = (tHeight+lineWidth)/(sqrt(3)/2);
    lineWidth /= 2;
    if (lineWidth > lineDist) lineDist = lineWidth+(tHeight/20);
    
    textSize(10);
    //display parameter values below hexShape
    //text(String.format("%.1f", lineDist)+" - "+String.format("%.1f",linewidth,2), -tHeight/2, tHeight*1.6);
    
    outerBorder = createShape();
    outerBorder.beginShape();
    outerBorder.vertex(border/2, -(tHeight+lineWidth*2));
    outerBorder.vertex(-border/2, -(tHeight+lineWidth*2));
    outerBorder.endShape();

    triangle = createShape();
    triangle.beginShape();
    triangle.vertex(0, -hypothenuse(lineDist+lineWidth, 30));
    triangle.vertex((side/2)-hypothenuse(lineDist+lineWidth, 60), -tHeight);
    triangle.vertex(0, -tHeight);
    triangle.endShape();

    hole = createShape();
    hole.beginShape();
    hole.vertex(side/2, -tHeight);
    hole.vertex((side/2)-hypothenuse(lineDist-lineWidth, 60), -tHeight);
    hole.vertex(adjacentLeg(hypothenuse(lineWidth, 30), 60), -hypothenuse(lineDist, 30));
    hole.vertex(adjacentLeg(hypothenuse(lineDist+lineWidth, 30)/2, 60), -hypothenuse(lineDist+lineWidth, 30)/2);
    hole.endShape();

    star = createShape();
    star.beginShape();
    star.vertex(adjacentLeg(hypothenuse(lineDist-lineWidth, 30)/2, 60), -hypothenuse(lineDist-lineWidth, 30)/2);
    star.vertex(0, -hypothenuse(lineDist-lineWidth, 30));
    star.endShape();
    
    fragment = createShape(GROUP);
    fragment.addChild(outerBorder);
    fragment.addChild(triangle);
    fragment.addChild(hole);
    fragment.addChild(star);
    fragment.setStroke(color(255));
    fragment.setStrokeWeight(4);
    
    for (int i = 0; i < 6; i++) {
      rotate(radians(60*i));
      shape(fragment);
      scale(-1,1);
      shape(fragment);
    }    
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
}