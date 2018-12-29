void drawHexShape(float lineDist, float linewidth){
  side = tHeight/(sqrt(3)/2);
  border = (tHeight+linewidth)/(sqrt(3)/2);
  linewidth /= 2;

  //parameter contrains to preserve holes
  if (linewidth > lineDist) lineDist = linewidth+(tHeight/20);

  textSize(10);
  //display parameter values below shape
  //text(String.format("%.1f", lineDist)+" - "+String.format("%.1f",linewidth,2), -tHeight/2, tHeight*1.6);
  for (int i = 0; i < 6; i++) {
    pushMatrix();
    rotate(radians(60*i));

    // outer border
    beginShape();
    vertex(border/2, -(tHeight+linewidth*2));
    vertex(-border/2, -(tHeight+linewidth*2));
    endShape();

    // tringale
    beginShape();
    vertex((side/2)-hypothenuse(lineDist+linewidth, 60), -tHeight);
    vertex(0, -hypothenuse(lineDist+linewidth, 30));
    vertex(-((side/2)-hypothenuse(lineDist+linewidth, 60)), -tHeight);
    vertex((side/2)-hypothenuse(lineDist+linewidth, 60), -tHeight);
    endShape();

    // elongated hole
    beginShape();
    vertex(side/2, -tHeight);
    vertex((side/2)-hypothenuse(lineDist-linewidth, 60), -tHeight);
    vertex(adjacentLeg(hypothenuse(linewidth, 30), 60), -hypothenuse(lineDist, 30));
    vertex(adjacentLeg(hypothenuse(lineDist+linewidth, 30)/2, 60), -hypothenuse(lineDist+linewidth, 30)/2);
    endShape();

    beginShape();
    vertex(-(side/2), -tHeight);
    vertex(-((side/2)-hypothenuse(lineDist-linewidth, 60)), -tHeight);
    vertex(-adjacentLeg(hypothenuse(linewidth, 30), 60), -hypothenuse(lineDist, 30));
    vertex(-adjacentLeg(hypothenuse(lineDist+linewidth, 30)/2, 60), -hypothenuse(lineDist+linewidth, 30)/2);
    endShape();

    // star
    beginShape();
    vertex(adjacentLeg(hypothenuse(lineDist-linewidth, 30)/2, 60), -hypothenuse(lineDist-linewidth, 30)/2);
    vertex(0, -hypothenuse(lineDist-linewidth, 30));
    vertex(-adjacentLeg(hypothenuse(lineDist-linewidth, 30)/2, 60), -hypothenuse(lineDist-linewidth, 30)/2);
    endShape();

    popMatrix();
  }
}