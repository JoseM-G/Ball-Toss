/*
 *Authors: Jose Martinez and An Tran
 *Program name: Ball Bounce
 *Description: This program allows the user to throw 
 *around a bouncy ball. The user can grab the ball by 
 *having the mouse button pressed down and "catching"
 *the ball with the mouse. To throw the ball release
 *the mouse button while moving the mouse in the 
 *direction you want to throw it in.
 */


float r; //radius of the ball
float X; //x variable for ball
float Y; //y variable for ball
float Xspeed; //speed of ball in x direction
float Yspeed; //speed of ball in the y direction


float gravity; //brings the ball down to bottom of screen
float stopSpeed; //the ball at rest
float dissipation; //slows the ball after each bounce

void setup() {
  size(500, 500);
  smooth();
  ellipseMode(RADIUS);


  r = 25; //radius
  X = width/2; //inital x position
  Y = height/2; //initial y position
  Yspeed = 0; //initial y speed
  Xspeed = 0; //initial x speed



  gravity = 0.6; //how fast the ball is brought downn to bottom
  stopSpeed = 0.2; //how slow it needs to move to stop
  dissipation = 0.08; //how much ball is slowed down
}


void draw() {
  background(0, 255, 255);
  drawBall(); //draws the ball
  
  //detects if player catches the ball
  if ( mousePressed && mouseNear() == true ) {
    copyMousePosition();
    copyMouseSpeed();
  } else {
    moveBall();
  }
}

//ball
void drawBall() {
  fill(255, 0, 0);
  noStroke();
  ellipse(X, Y, r, r);
  X = constrain(X, r, width-r);
  Y = constrain(Y, r, height-r);
}

//draws ball on the x an y positions of the mouse
void copyMousePosition() {
  X = pmouseX;
  Y = pmouseY;
  background(0, 255, 255);
  fill(255, 0, 0);
  ellipse(X, Y, r, r);
}

//changes ball speed based on how far apart mouse position is to
//the previous mouse position
void copyMouseSpeed() {
  Xspeed = mouseX-pmouseX;
  Yspeed = mouseY-pmouseY;
}

//detects if mouse is within the ball
boolean mouseNear() {
  if (dist(X, Y, pmouseX, pmouseY)<r) {
    return true;
  } else {
    return false;
  }
}

//function for the ball's movements
void moveBall() {

  X = X + Xspeed;
  Y = Y + Yspeed; 
  //stops the ball at the bottom
  if ( abs(Yspeed)<stopSpeed ) {
    Yspeed = 0.0;
    //bounces ball off the floor
  } else if ( Y > height-r ) {
    Yspeed *= -(1-dissipation);
    //bounces ball off the ceiling
  } else if ( Y < r ) {
    Yspeed *= -(1-dissipation);
    //bounces ball off the right wall
  } else if ( X > width-r ) {
    Xspeed *= -(1-dissipation);
    //bounces ball off the left wall
  } else if ( X < r ) {
    Xspeed *= -(1-dissipation);
  }
  Yspeed += gravity; //adds gravity
}

