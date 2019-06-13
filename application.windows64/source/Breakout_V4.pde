// Arjun Jale
// Sources: https://processing.org/examples/, http://programmingjustforfun.blogspot.com/, Google Images (for background), Lecture Powerpoints
// 9-10-17


//Declare constant variables
final int width = 800;
final int height = 800;
final int radius = 14;

int lives = 3;

int gameState = 0;

int time = 0;

int score = 0;

int numBounces = 0;

//declare variables for Ball
int x = (int)random(0, 400);
int y = 200;
int dx = 5;
int dy = 5;

int x_paddle = 400;
int y_paddle = 760;
int half_paddle = 55;

int[] blocks = new int[50];
int a;
int b;

PImage bg;
PImage bg2;

void setup() {
  size(800, 800);

  frameRate(60);
  smooth();
  noCursor();
  rectMode(CENTER);

  for ( int i = 0; i < 50; i ++) {
    blocks[i] = 1;
  }

  bg = loadImage("background.jpg");
  bg2 = loadImage("background0.jpg");
}



void draw() {
  if (keyPressed){
    if (key == 'c'){
      save("menu.png");
    }
    if (key == 'v'){
      save("game.png");
    }
  }
  
  
  if (gameState == 0) {
    background(bg2);

    fill(255);
    stroke(255);
    strokeWeight(10);
    line(0, 0, 0, 800);
    line(0, 0, 800, 0);
    line(0, 800, 800, 800);
    line(800, 0, 800, 800);

    fill(255);
    textSize(70);
    textAlign(CENTER);
    text("ATARI BREAKOUT", 400, 100);

    fill(255);
    textSize(30);
    textAlign(CENTER);
    text("Press 'Space' to play game", 400, 550);
    fill(255);
    textSize(25);
    textAlign(CENTER);
    text("Move mouse to move paddle", 400, 600);

    fill(255);
    textSize(16);
    textAlign(CENTER);
    text("By: Arjun Jale, 9/12/2017", 108, 790);


    if (keyPressed) {
      if (key == ' ') {
        gameState = 1;
      }
    }
  } else if (gameState == 1) {
    fill(255);
    line(1, 770, 799, 770);

    x= x + dx;
    y = y + dy;

    if (y < 0) {
      dy = -dy;
    }

    if (x > width || x < 0) {
      dx = -dx;
    }

    x_paddle = mouseX;

    if ((x_paddle-half_paddle)<x && (x_paddle+half_paddle)>x && (y_paddle-10)<y && (y_paddle)>y) {
      numBounces ++;
      dy = -dy;
    }

    background(bg);


    fill(255);
    textSize(16);
    textAlign(RIGHT);
    text("Bounces: ", 90, 790);
    textAlign(LEFT);
    text(numBounces, 90, 790);

    fill(255);
    textSize(16);
    textAlign(RIGHT);
    text("|  Score: ", 175, 790);
    textAlign(LEFT);
    text(score, 175, 790);

    fill(255);
    textSize(16);
    textAlign(RIGHT);
    text("|  Lives: ", 260, 790);
    textAlign(LEFT);
    text(lives, 260, 790);

    fill(92, 171, 201);
    strokeWeight(2);
    stroke (255);
    ellipse(x, y, radius, radius);

    rect(x_paddle, y_paddle, half_paddle*2, 11);

    if (y > height && lives > 0) {

      lives = lives - 1;

      y= 200;
      x = (int)random(0, 400);
    }

    if (lives == 0) {
      exit();
    }

    for (int i = 0; i<50; i++) {
      a = i%10 * 100 + 10;
      b = 40*(i/10)+10;

      print(a+ "     ");

      if (blocks[i] == 1) {
        fill(92, 171, 201);
        strokeWeight(2);
        stroke (255);
        rect(a+40, b+10, 80, 20);
      }

      if (x>(a+4) && x<(a+76) && y>b && y<(b+20) && blocks[i]==1) { 
        blocks[i]=0;
        dy = -dy;
        score ++;
      }

      if (((x>(a-5) && x<a) || (x>(a+80) && x<(a+85))) && y>b && y<(b+20) && blocks[i]==1) { 
        blocks[i]=0;
        dx = -dx;
        score ++;
      }
      
      if (((x>(a-1) && x<(a+5)) || (x>(a+75) && x<(a+81))) && y>b && y<(b+20) && blocks[i]==1) { 
        blocks[i]=0;
        dx = -dx;
        dy = -dy;
        score ++;
      }
    }
  }
}