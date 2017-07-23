import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import toxi.geom.*; 
import peasy.*; 
import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class LSYS extends PApplet {


//toxi


//PeasyCam

PeasyCam cam;

//controlP5

ControlFrame cf;

float speed;
float pos;
float c0, c1, c2, c3;
boolean auto;

//bob
Stick bob; //Stick\u3092bob\u3068\u547c\u3076\u3088\uff1f
ArrayList <Stick> allBobs;


/////////////////////////// SETTINGS ////////////////////////////


public void settings() {
  size(800,600,P3D); //box\u304c\u3067\u308b\u30a6\u30a3\u30f3\u30c9\u30a6\u306e\u30b5\u30a4\u30ba
  smooth();
}


/////////////////////////// SETUP ////////////////////////////


public void setup() {
  allBobs = new ArrayList <Stick> ();

  cam = new PeasyCam(this, 100);

  /////controller/////
  cf = new ControlFrame(this, 400, 200, "Controls");
  surface.setLocation(420, 10);

  noStroke();
}


/////////////////////////// DRAW ////////////////////////////


public void draw() {
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
float ANGLE1 = 0;
float ANGLE2 = 0;
float ANGLE3 = 0;
int ITE = 0;
int LENGTH = 0;

class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    surface.setLocation(10, 10);
    cp5 = new ControlP5(this);

    cp5.addSlider("ANGLE1")
       .plugTo(parent, "ANGLE1")
       .setRange(-90, 90)
       .setValue(5)
       .setPosition(100, 10)
       .setSize(200, 20);

    cp5.addSlider("ANGLE2")
      .plugTo(parent, "ANGLE2")
      .setRange(-90, 90)
      .setValue(90)
      .setPosition(100, 50)
      .setSize(200, 20);

    cp5.addSlider("ANGLE3")
      .plugTo(parent, "ANGLE3")
      .setRange(-90, 90)
      .setValue(11)
      .setPosition(100, 90)
      .setSize(200, 20);

    cp5.addSlider("ITE")
      .plugTo(parent, "ITE")
      .setRange(0, 30)
      .setValue(4)
      .setPosition(100, 130)
      .setSize(200, 20);

    cp5.addSlider("LENGTH")
      .plugTo(parent, "LENGTH")
      .setRange(0, 500)
      .setValue(50)
      .setPosition(100, 170)
      .setSize(200, 20);
  }

  public void draw() {
    background(190);
  }
}


class Stick{

  Vec3D loc;
  Vec3D oriLoc;
  Vec3D vel;

  int generations;

  String type;

  Stick(Vec3D _loc, Vec3D _vel, int _generations, String _type){
    loc = _loc;
    oriLoc = _loc.copy();
    vel = _vel;
    generations = _generations;
    type = _type;

    //stack of functions that get executed only once
    updateDir();
    updateLoc();
    spawn();
  }

  public void run(){
    display();
  }

  public void spawn(){

    if(generations > 0){

      if(type == "A"){
        Vec3D v = loc.copy();
        Vec3D iniVel = vel.copy();
        Stick newBob = new Stick(v, iniVel , generations-1, "A");

        allBobs.add(newBob);

        Vec3D v2 = loc.copy();
        Vec3D iniVel2 = vel.copy();
        Stick newBob2 = new Stick(v2, iniVel2 , generations-1, "B");

        allBobs.add(newBob2);
      }

      if(type == "B"){
        Vec3D v = loc.copy();
        Vec3D iniVel = vel.copy();
        Stick newBob = new Stick(v, iniVel , generations-1, "C");

        allBobs.add(newBob);
      }

      if(type == "C"){
        Vec3D v = loc.copy();
        Vec3D iniVel = vel.copy();
        Stick newBob = new Stick(v, iniVel , generations-1, "A");

        allBobs.add(newBob);
      }

    }
  }


  public void updateDir(){

    if(type == "A"){
      float angle1 = radians(0);
      float angle2 = radians(ANGLE1);
      float angle3 = radians(0);

      vel.rotateX(angle1);
      vel.rotateY(angle2);
      vel.rotateZ(angle3);

      vel.normalize();
      vel.scaleSelf(LENGTH);

    }

    if(type == "B"){
      float angle1 = radians(0);
      float angle2 = radians(0);
      float angle3 = radians(ANGLE2);

      vel.rotateX(angle1);
      vel.rotateY(angle2);
      vel.rotateZ(angle3);

      vel.normalize();
      vel.scaleSelf(LENGTH);
    }

    if(type == "C"){
      float angle1 = radians(-ANGLE3);
      float angle2 = radians(0);
      float angle3 = radians(0);

      vel.rotateX(angle1);
      vel.rotateY(angle2);
      vel.rotateZ(angle3);

      vel.normalize();
      vel.scaleSelf(LENGTH);
    }
  }

  public void updateLoc(){
    loc.addSelf(vel);
  }

  public void display(){
    stroke(255,0,0);
    strokeWeight(4);
    point(loc.x,loc.y,loc.z);

    stroke(255);
    strokeWeight(1);
    line(loc.x,loc.y,loc.z,oriLoc.x,oriLoc.y,oriLoc.z);

  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "LSYS" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
