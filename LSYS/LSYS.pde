
//toxi
import toxi.geom.*;

//PeasyCam
import peasy.*;
PeasyCam cam;

//controlP5
import controlP5.*;
ControlFrame cf;

float speed;
float pos;
float c0, c1, c2, c3;
boolean auto;

//bob
Stick bob; //Stickをbobと呼ぶよ？
ArrayList <Stick> allBobs;


/////////////////////////// SETTINGS ////////////////////////////


void settings() {
  size(800,600,P3D); //boxがでるウィンドウのサイズ
  smooth();
}


/////////////////////////// SETUP ////////////////////////////


void setup() {
  allBobs = new ArrayList <Stick> ();

  cam = new PeasyCam(this, 100);

  /////controller/////
  cf = new ControlFrame(this, 400, 200, "Controls");
  surface.setLocation(420, 10);

  noStroke();
}


/////////////////////////// DRAW ////////////////////////////


void draw() {
  background(0);

  allBobs.clear();

  Vec3D v = new Vec3D(0,0,0);
  Vec3D iniVel = new Vec3D(100,0,0);
  bob = new Stick(v, iniVel , ITE, "A");

  allBobs.add(bob);

  stroke(255);
  noFill();
  strokeWeight(10);

  for(Stick b:allBobs){
    b.run();
  }
}
