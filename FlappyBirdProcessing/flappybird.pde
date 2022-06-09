import ddf.minim.*;

Minim gerenciador;

AudioPlayer asas;
AudioPlayer ponto;

PImage background, flappy, cano, telainicial, moeda;

int i, j, game, score, highscore, x, y, vertical, wallx[] = new int[2], wally[] =new int[2]; 

void setup() {
   background = loadImage("back4.png");
   flappy = loadImage("bird.png");
   cano = loadImage("cano.png");
   telainicial = loadImage("start.png");
   moeda = loadImage("moeda.png");
   game = 1;
   score = 0;
   highscore = 0;
   x = -200;
   vertical = 0; 
  size(600,800);
  fill(0,0,0);
  textSize(20); 
  gerenciador = new Minim(this);
  asas = gerenciador.loadFile("sfx_wing.wav");
  ponto = gerenciador.loadFile("sfx_point.wav");
}

void draw() { 
  if(game == 0) {
    imageMode(CORNER);
    image(background, x, 0);
    image(background, x+background.width, 0);
    x -= 5;
    vertical += 1;
    y += vertical;
    if(x == -1800) x = 0;
    for(int i = 0 ; i < 2; i++) {
      imageMode(CENTER);
      image(cano, wallx[i], wally[i] - (cano.height/2+100));
      image(cano, wallx[i], wally[i] + (cano.height/2+100));
      if(wallx[i] < 0) {
        wally[i] = (int)random(100,height-200);
        wallx[i] = width;
      }
      if(wallx[i] == width/2){
        highscore = max(++score, highscore);
        ponto.rewind();
        ponto.play();
      }
      if(y>height||y<0||(abs(width/2-wallx[i])<25 && abs(y-wally[i])>100)) game=1;
      wallx[i] -= 6;
    }
    image(moeda,260,y);
    image(flappy, width/2, y);
    text("Score: "+score, 5, 20);
  }
  else {
    imageMode(CENTER);
    image(telainicial, width/2,height/2);
    text("High Score: "+highscore, 50, 130);
  }
}

void mousePressed() {
  asas.rewind();
  asas.play();
  vertical = -15;
  //pushMatrix();
  //translate(i,j);
  //rotate(radians(45));
  //image(flappy,0,0);
  //popMatrix();
  if(game==1) {
    wallx[0] = 600;
    wally[0] = y = height/2;
    wallx[1] = 900;
    wally[1] = 600;
    x = game = score = 0;
    
  }
}
