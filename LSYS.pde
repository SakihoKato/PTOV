/*
/2017/07/23
/Jose Sanchez tutorial
/https://goo.gl/cnPogR
*/

import nervoussystem.obj.*; //obj変換ライブラリ

//toxi
import toxi.geom.*;

//PeasyCam
import peasy.*;
PeasyCam cam; //オブジェクトの宣言

//controlP5
import controlP5.*;
ControlFrame cf;

//bob
Stick bob; //Stickをbobと呼ぶよ
ArrayList <Stick> allBobs; //bobが全部入った配列allBobs

boolean auto;
boolean record = false;  //  obj変換フラグ


/////////////////////////// SETTINGS ////////////////////////////


void settings() {
  size(800,600,P3D); //boxがでるウィンドウのサイズ
  smooth();
}


/////////////////////////// SETUP ////////////////////////////


void setup() {
  allBobs = new ArrayList <Stick> ();

  cam = new PeasyCam(this, 100); //オブジェクトの生成

  /////controller/////
  cf = new ControlFrame(this, 400, 200, "Controls");
  surface.setLocation(420, 10);

  noStroke();
}


/////////////////////////// DRAW ////////////////////////////


void draw() {

  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", "sample.obj");
  } else {
    background(#bfbabe);
  }

  allBobs.clear();

  Vec3D v = new Vec3D(0,0,0); //Stickインスタンスで使うベクター
  Vec3D iniVel = new Vec3D(100,0,0);

  bob = new Stick(v, iniVel , ITE, "A"); //Stickインスタンス
  //インスタンス＝クラスを実際に作ったもの、newしたもの

  allBobs.add(bob); //できたbobは全部allBobs配列に追加する

  stroke(255);
  noFill();
  strokeWeight(10);

  //for文の短い記述の仕方
  //allBobsに入ってる全部をrunする
  for(Stick b:allBobs){
    b.run();
  }

  // obj変換中なら終了処理
  if (record) {
    endRecord();
    print("recorded");
    record = false;
  }

}


void exportOBJ() {
  record = true;
}
