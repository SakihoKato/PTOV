import nervoussystem.obj.*;
boolean record = false;  //  obj変換フラグ
PImage img;

//--------------------------------------
// setup
//--------------------------------------

void setup() {  
  size(600, 601, P3D);
}



//--------------------------------------
// draw
//--------------------------------------

void draw() {
  //  描画モード切り替え（obj変換時は座標変換をするとobjの座標もずれるので。）
  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", "v2.obj");
  } else {
    img = loadImage("sample02.png");
    background(0);
    noStroke();
    lights();
    rotateY(0.5); 
    rotateX(0.5);
  }
  
  int step = 1;
  int depth = 50;
  
  for (int j = 1; j < height; j = j + step) {
    for (int i = 1; i < width; i = i + step) {
      color c = img.get(i, j);
      float r = red(c); // 赤を抽出
      float g = green(c); // 緑を抽出 
      float b = blue(c); // 青を抽出 
      
      println(r); //rの値を表示する
      
      if ( r < 30 ) {
        fill(#CECECE);
        noStroke();
        pushMatrix();
        translate(i , j , 0);
        box(1);
        popMatrix();
      } else {
        fill(#CECECE);
        noStroke();
        pushMatrix();
        translate(i , j , depth/2); //深さの分z軸方向を上に
        box(1,1,depth);
        popMatrix();
      }

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
// マウスクリックしたら、obj出力モードにする。
//--------------------------------------
  
void mousePressed() {
  record = true;
}


      //pushMatrix();
      //translate(150 + i * 20, 150 + j * 20, 0);
      //box(10);
      //popMatrix();
      
    