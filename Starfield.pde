Particle[] parts;
void setup()
{
  size(1000, 1000);
  background(0);
  noStroke();
  parts = new Particle[1006];
  for (int i = 0; i < parts.length; i++) {
    if (i < 1000) parts[i] = new Particle();
    else parts[i] = new Interceptor();
  }
}
void draw()
{
  fill(0, 100);
  quad(0, 0, 0, 1000, 1000, 1000, 1000, 0);
  for (int i = 0; i < parts.length; i++) {
    parts[i].move();
    parts[i].show();
    if (parts[i].dist > 750) parts[i] = new Particle();
  }
}
class Particle
{
  color col;
  double xPos, yPos, vel, angle, size, dist;
  Particle() {
    size = Math.random();
    xPos = 500;
    yPos = 500;
    vel = Math.random()*2.5+0.1;
    angle = Math.random()*2*PI;
    col = color(#FFFFFF);
    dist = 0;
  }
  void move() {
    xPos += vel*Math.cos(angle);
    yPos += vel*Math.sin(angle);
    dist = Math.sqrt(Math.pow(xPos-500, 2)+Math.pow(yPos-500, 2));
  }
  void show() {
    fill(col);
    ellipse((float)xPos, (float)yPos, (float)(size*dist/50.0), (float)(size*dist/50.0));
  }
}

class Interceptor extends Particle //inherits from Particle
{
  double targetX, targetY, targetAngle, delta;
  Interceptor() {
    size = 1;
    xPos = 500;
    yPos = 500;
    vel = Math.random()*3+3;
    angle = Math.random()*PI*2;
    col = color(#7777FF);
    dist = 0;
    targetX = 500;
    targetY = 500;
    targetAngle = angle;
    delta = 0;
  }
  void move() {
    targetX = mouseX;
    targetY = mouseY;
    //calculates target angle and prevents wraparound
    if(xPos > targetX) targetAngle = PI+Math.atan((yPos-targetY)/(xPos-targetX));
    if(xPos < targetX) targetAngle = Math.atan((yPos-targetY)/(xPos-targetX));
    if(targetAngle-angle > PI) targetAngle-=2*PI;
    if(targetAngle-angle < -PI) targetAngle+=2*PI;
    xPos += vel*Math.cos(angle);
    yPos += vel*Math.sin(angle);
    //calculates angle difference, rotates interceptor proportional to
    delta = Math.abs(targetAngle - angle + Math.random()*0.1-0.05);
    if(delta > 0.25) delta = 0.25;
    if(angle < targetAngle) angle += delta;
    if(angle > targetAngle) angle -= delta;
    //prevents wraparound
    if(angle > 2*PI) angle-=2*PI;
    if(angle < -2*PI) angle+=2*PI;
    dist = Math.sqrt(Math.pow(xPos-500, 2)+Math.pow(yPos-500, 2)); //unused for now
  }
  void show() {
    fill(col);
    stroke(0);
    translate((float)xPos,(float)yPos);
    rotate((float)angle-PI/2);
    quad(0,0,-12,-30,0,-20,12,-30);
    rotate(-(float)angle+PI/2);
    translate(-(float)xPos,-(float)yPos);
    
  }
}
