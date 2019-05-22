
//@Author Noah Gentilcore
//Version 1
//5 May 2019
PImage backImg;PImage birdImg;PImage wallImg;PImage startImg;
int gamestate = 1, score = 0, highScore = 0, x = -200, y, vy = 0, wx[] = new int[2], wy[] = new int[2];
void setup() { //All of the images loaded from the same folder
  backImg =loadImage("./bgImg.png");
  birdImg =loadImage("./birdImg.png");
  wallImg =loadImage("./wallImg.png");
  startImg=loadImage("./startImg.png");
  size(600,800);
  fill(0);
  textSize(40);  
}
void draw() { 
  if(gamestate == 0) {  //When the game starts, it loads the background here
    imageMode(CORNER);
    image(backImg, x, 0);
    image(backImg, x+backImg.width, 0);
    x -= 6;
    vy += 1;
    y += vy;
    if(x == -1800) x = 0;
    for(int i = 0 ; i < 2; i++) {
      imageMode(CENTER);
      image(wallImg, wx[i], wy[i] - (wallImg.height/2+100));  //Determines wall placement
      image(wallImg, wx[i], wy[i] + (wallImg.height/2+100));
      if(wx[i] < 0) {
        wy[i] = (int)random(200,height-200);
        wx[i] = width;
      }
      if(wx[i] == width/2) highScore = max(++score, highScore);  //Scoring
      if(y>height||y<0||(abs(width/2-wx[i])<25 && abs(y-wy[i])>100)) gamestate=1;
      wx[i] -= 6;
    }
    image(birdImg, width/2, y);
    text(""+score, width/2-15, 700);
  }
  else {
    imageMode(CENTER);
    image(startImg, width/2,height/2);
    text("High Score: "+highScore, 50, width);
  }
}
void mousePressed() { //All the uses of the mouse being pressed, such as velocity changing, or restarting the score when game restarts(but not resets
  vy = -17;
  if(gamestate==1) {
    wx[0] = 600;
    wy[0] = y = height/2;
    wx[1] = 900;
    wy[1] = 600;
    x = gamestate = score = 0;
  }
}
