class hexShape { 
  float side, border;
  ArrayList<PVector> triangle, smallHex;
  
  hexShape(float tHeight, float lineDist, float lineWidth) {    
    side = tHeight/(sqrt(3)/2);
    border = (tHeight+lineWidth)/(sqrt(3)/2);
    lineWidth /= 2;
    if (lineWidth > lineDist) lineDist = lineWidth+(tHeight/20);
    
    textSize(10);
    //display parameter values below hexShape
    //text(String.format("%.1f", lineDist)+" - "+String.format("%.1f",linewidth,2), -tHeight/2, tHeight*1.6);
    
    //calculate points for the triangles
    triangle = new ArrayList<PVector>();
    
    triangle.add(new PVector(0, -hypothenuse(lineDist+lineWidth, 30)));
    triangle.add(new PVector((side/2)-hypothenuse(lineDist+lineWidth, 60), -tHeight));
    triangle.add(new PVector(-((side/2)-hypothenuse(lineDist+lineWidth, 60)), -tHeight));
    
    //calculate points for the small hexagons
    smallHex = new ArrayList<PVector>();
    
    PVector holeLeft1 = new PVector(side/2, -tHeight);
    PVector holeLeft2 = new PVector((side/2)-hypothenuse(lineDist-lineWidth, 60), -tHeight);
    PVector holeLeft3 = new PVector(adjacentLeg(hypothenuse(lineWidth, 30), 60), -hypothenuse(lineDist, 30));
    PVector holeLeftRot1 = pointRotation(holeLeft1,180);
    PVector holeLeftRot2 = pointRotation(holeLeft2,180);
    PVector holeLeftRot3 = pointRotation(holeLeft3,180);
    PVector holeSpace = new PVector(adjacentLeg(hypothenuse(lineDist+lineWidth, 30)/2, 60), -hypothenuse(lineDist+lineWidth, 30)/2);
    
    smallHex.add(new PVector(holeLeft1.x,holeLeft1.y));
    smallHex.add(new PVector(holeLeft2.x,holeLeft2.y));
    smallHex.add(new PVector(holeLeft3.x,holeLeft3.y));
    smallHex.add(new PVector(holeLeftRot1.x+(holeLeft1.x+holeSpace.x),holeLeftRot1.y+(holeLeft1.y+holeSpace.y)));
    smallHex.add(new PVector(holeLeftRot2.x+(holeLeft1.x+holeSpace.x),holeLeftRot2.y+(holeLeft1.y+holeSpace.y)));
    smallHex.add(new PVector(holeLeftRot3.x+(holeLeft1.x+holeSpace.x),holeLeftRot3.y+(holeLeft1.y+holeSpace.y)));

    // draw outer hexagon shape
    beginShape();
    for (int i = 0; i <= 6; i++) {
      PVector rotCorner = pointRotation(new PVector(border/2, -(tHeight+lineWidth*2)),60*i);
      vertex(rotCorner.x,rotCorner.y);
    }

    for (int i = 0; i < 6; i++) {
      // draw triangles
      beginContour();
      for (int j = 0; j < triangle.size(); j++) {
        PVector rotPoint = pointRotation(new PVector(triangle.get(j).x,triangle.get(j).y),i*60); 
       vertex(rotPoint.x,rotPoint.y);
      }
      endContour();
      // draw small hexagons
      beginContour();
      for (int j = 0; j < smallHex.size(); j++) {
        PVector rotPoint = pointRotation(new PVector(smallHex.get(j).x,smallHex.get(j).y),i*60); 
       vertex(rotPoint.x,rotPoint.y);
      }
      endContour();
    }
    // draw center star
    beginContour();
    for (int j = 5; j >= 0; j--) {
      PVector star1 = new PVector(0, -hypothenuse(lineDist-lineWidth, 30));
      PVector star2 = new PVector(adjacentLeg(hypothenuse(lineDist-lineWidth, 30)/2, 60), -hypothenuse(lineDist-lineWidth, 30)/2);
      PVector rot1 = pointRotation(star1,60*j);
      PVector rot2 = pointRotation(star2,60*j);
      vertex(rot2.x,rot2.y);
      vertex(rot1.x,rot1.y);
    }
    endContour();
    endShape(CLOSE);
  }

  //some basic trigonometry
  
  // get hypothenuse from adjacent leg and angle
  float hypothenuse(float adjacentLeg, float angle) {
    return (adjacentLeg/sin(radians(angle)));
  }
  
  // get adjacent leg from opposite leg and angle
  float adjacentLeg(float oppositeLeg, float angle) {
    return (oppositeLeg/tan(radians(angle)));
  }
  
  // popMatrix/pushMatrix between beginShape/endShape is not supported, so here's a custom point rotation function
  PVector pointRotation(PVector point, float angle) {
    PVector rotatedPoint = new PVector();
    rotatedPoint.x = point.x*cos(radians(angle))-point.y*sin(radians(angle));
    rotatedPoint.y = point.x*sin(radians(angle))+point.y*cos(radians(angle));
    return rotatedPoint;
  }
}
