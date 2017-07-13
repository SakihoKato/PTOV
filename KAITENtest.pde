import controlP5.*; //GUIライブラリ
import nervoussystem.obj.*; //obj変換ライブラリ

ControlP5 cp5; //cpp5として宣言
Slider modelSize; //スライダーを宣言
Slider rotateX;
Slider rotateY;
Slider pixel;

boolean record = false;  //  obj変換フラグ
boolean autoRotate = false; 

PImage img;

float rotX, rotY;



//--------------------------------------
// setup
//--------------------------------------

void setup() {  
  
  size(500, 500, P3D);
  smooth();
  
  cp5 = new ControlP5(this); //controlP5を初期化

  //大きさスライダー
  modelSize = cp5.addSlider("modelSize")
  .setPosition(20,20) //位置
  .setSize(25,80)//サイズ
  .setRange(0, 400) //範囲
  .setValue(30); //初期値
  
  //向きスライダー
  rotateX =cp5.addSlider("rotateX")
  .setPosition(20,130) //位置
  .setSize(25,80)//サイズ
  .setRange(0, 400) //範囲
  .setValue(0); //初期値 
  
  //向きスライダー
  rotateY =cp5.addSlider("rotateY")
  .setPosition(20,240) //位置
  .setSize(25,80)//サイズ
  .setRange(0, 400) //範囲
  .setValue(0); //初期値 
  
  //解像度スライダー
  pixel =cp5.addSlider("pixel")
  .setPosition(20,350) //位置
  .setSize(25,100)//サイズ
  .setRange(1, 10) //範囲
  .setValue(5) //初期値 
  .setNumberOfTickMarks(10);

}



//--------------------------------------
// draw
//--------------------------------------

void draw() {

  //  描画モード切り替え（obj変換時は座標変換をするとobjの座標もずれるので。）
  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", "v2.obj");
  } else {
    img = loadImage("pattern1.jpg");
    background(0);
    noStroke();
    lights();
  }
  
  //float->int変換
  float px = (float)pixel.getValue();
  int PX = (int)px;

  
  
  for (int j = 0; j < 150; j = j + PX) {
    for (int i = 0; i < 150; i = i + PX) {
      color c = img.get(i, j);
      float r = red(c); // 赤を抽出
      //float g = green(c); // 緑を抽出 
      //float b = blue(c); // 青を抽出 
      
      fill(#CECECE);
      noStroke();
      pushMatrix();
      
      translate(width/2, height/2);  //ウィンドウの中心に移動
      
      if (autoRotate) {
        //自動でずっと回転
        rotateX(millis()/1000.0 * 1.0);
        rotateY(millis()/1000.0 * 1.5);
      } else {
        //マウスドラッグで回転
        rotateX(rotY);
        rotateY(rotX);
      }
      
      //スライダーで回転
      //rotateX(rotateX.getValue()*0.01);
      //rotateY(rotateY.getValue()*0.01);
      
      //println(r); //rの値を表示する
      
      if ( r < 30 ) {
        
        translate((i-150/2), (j-150/2), 0); //ウィンドウの中心と、モデルの中心を合わせる
        
        box(px, px, modelSize.getValue()*0.5);
        
      } else { //真ん中
        
        translate((i-150/2), (j-150/2), -modelSize.getValue()*0.5*0.5); //深さの分z軸方向を上に

        //translate(width/4+i, height/4+j, -modelSize.getValue()*0.5*0.5); //深さの分z軸方向を上に
        
        box(px,px,modelSize.getValue());
      }
      popMatrix();

    } //forの閉じかっこ
  } //forの閉じかっこ
  
  
  // obj変換中なら終了処理
  if (record) {
    endRecord();
    print("recorded");
    record = false;
  }
  
} //drawの閉じかっこ





//--------------------------------------
// マウスドラッグ時の処理
//--------------------------------------


void mouseDragged(){
  rotX += (mouseX - pmouseX) * 0.01;
  rotY -= (mouseY - pmouseY) * 0.01;
}



//--------------------------------------
// マウスクリックしたら、obj出力モードにする。
//--------------------------------------
  
  
void keyPressed() {
  autoRotate = !autoRotate;
}
  
void mousePressed() {
  record = true;
}


      //pushMatrix();
      //translate(150 + i * 20, 150 + j * 20, 0);
      //box(10);
      //popMatrix();
      
    