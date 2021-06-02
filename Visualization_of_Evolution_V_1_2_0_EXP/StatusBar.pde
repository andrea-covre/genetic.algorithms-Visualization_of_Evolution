void displayStatusBar() {
  color green = color(0, 255, 0);
  color red = color(255, 0, 0);

  stroke(255, 255, 255, 150);
  fill(0);
  rect(-10, height-20, width+10, 30);   //clear or re-clear just the lower status bar

  fill(255);
  textSize(12);
  textAlign(LEFT);

  text(sketchName + " by " + sketchAuthor, 5, height-5);
  text("Phase: " + phase, 300, height-5);
  text("Frame rate: " + frameRate, width/2-210, height-5);
  text("Status: ", width/2 -40, height-5); //15
  if (status == "Operative") {
    fill(0, 255, 0);
  } else if (status == "Looping") {
    fill(255, 180, 0);
  } else {
    fill(255, 13, 13);
  }
  text(status, width/2+5, height-5);
  fill(255);

  //CPU load bar
  text("CPU load", width/2 + 100, height-5);
  strokeWeight(0);
  fill(lerpColor(red, green, frameRate/settedRate));
  rect(width/2 + 155, height-15, 100-100*(frameRate/settedRate), 10);
  noFill();
  strokeWeight(1);
  rect(width/2 + 155, height-15, 100, 10);

  fill(255);
  text("V " + sketchVersion, width-45, height-5);        //SKetch Version ------
  text("Generation: " + generation, width-200, height-5);
  noFill();
  textSize(16);
}
