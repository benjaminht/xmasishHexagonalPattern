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
    for (int i = 0; i < 6; i++) {
      PVector rotCorner = pointRotation(new PVector(border/2, -(tHeight+lineWidth*2)),60*i);
      outerBorder.vertex(rotCorner.x,rotCorner.y);
    }
    outerBorder.endShape(CLOSE);

    triangle = createShape();
    triangle.beginShape();
    triangle.vertex(0, -hypothenuse(lineDist+lineWidth, 30));
    triangle.vertex((side/2)-hypothenuse(lineDist+lineWidth, 60), -tHeight);
    triangle.vertex(-((side/2)-hypothenuse(lineDist+lineWidth, 60)), -tHeight);
    triangle.endShape(CLOSE);
    
    hole = createShape();
    hole.beginShape();
    PVector holeLeft1 = new PVector(side/2, -tHeight);
    PVector holeLeft2 = new PVector((side/2)-hypothenuse(lineDist-lineWidth, 60), -tHeight);
    PVector holeLeft3 = new PVector(adjacentLeg(hypothenuse(lineWidth, 30), 60), -hypothenuse(lineDist, 30));
    PVector holeLeftRot1 = pointRotation(holeLeft1,180);
    PVector holeLeftRot2 = pointRotation(holeLeft2,180);
    PVector holeLeftRot3 = pointRotation(holeLeft3,180);
    PVector holeSpace = new PVector(adjacentLeg(hypothenuse(lineDist+lineWidth, 30)/2, 60), -hypothenuse(lineDist+lineWidth, 30)/2);
    
    hole.vertex(holeLeft1.x,holeLeft1.y);
    hole.vertex(holeLeft2.x,holeLeft2.y);
    hole.vertex(holeLeft3.x,holeLeft3.y);
    hole.vertex(holeLeftRot1.x+(holeLeft1.x+holeSpace.x),holeLeftRot1.y+(holeLeft1.y+holeSpace.y));
    hole.vertex(holeLeftRot2.x+(holeLeft1.x+holeSpace.x),holeLeftRot2.y+(holeLeft1.y+holeSpace.y));
    hole.vertex(holeLeftRot3.x+(holeLeft1.x+holeSpace.x),holeLeftRot3.y+(holeLeft1.y+holeSpace.y));
    hole.endShape(CLOSE);

    star = createShape();
    star.beginShape();
    for (int i = 0; i < 6; i++) {
      PVector star1 = new PVector(0, -hypothenuse(lineDist-lineWidth, 30));
      PVector star2 = new PVector(adjacentLeg(hypothenuse(lineDist-lineWidth, 30)/2, 60), -hypothenuse(lineDist-lineWidth, 30)/2);
      PVector rot1 = pointRotation(star1,60*i);
      PVector rot2 = pointRotation(star2,60*i);
      star.vertex(rot1.x,rot1.y);
      star.vertex(rot2.x,rot2.y);
    }
    star.endShape(CLOSE);

    fragment = createShape(GROUP);
    fragment.addChild(triangle);
    fragment.addChild(hole);
    
    for (int i = 0; i < 6; i++) {
      shape(fragment);
      rotate(radians(60));
    }
    shape(outerBorder);
    shape(star);
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
  
  // popMatrix/pushMatrix inside beginShape is not supported, so here's a custom point rotation functio 
  PVector pointRotation(PVector point, float angle) {
    PVector rotatedPoint = new PVector();
    rotatedPoint.x = point.x*cos(radians(angle))-point.y*sin(radians(angle));
    rotatedPoint.y = point.x*sin(radians(angle))+point.y*cos(radians(angle));
    return rotatedPoint;
  }
}
