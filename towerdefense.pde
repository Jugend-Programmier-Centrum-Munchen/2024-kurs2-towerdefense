import processing.sound.*;

// Music
SoundFile backgroundMusic;
SoundFile gameoverMusic;

// Map
PImage backgroundMap;
int[] pointsX = {-10, 160, 160, 360, 360, 630, 630, 900};
int[] pointsY = {360, 360, 170, 170, 425, 425, 310, 310};

// Monsters und Towers
ArrayList<Monster> monsters = new ArrayList<Monster>();
ArrayList<Tower> towers = new ArrayList<Tower>();

// Monster Spawn und Coins
int globalMonsterTick;
int currentMonsterRate;
int allCoins = 30;

// Castle
PImage castleImage;
int lives = 1;

void setup() {
  size(1000, 670);
  backgroundMap = loadImage("back.png");
  castleImage = loadImage("burg.png");

  globalMonsterTick = 0;
  currentMonsterRate = 50;

  background(backgroundMap);
  towers.add(new BasicTower(440, 350));
  drawCoins();

  // Music
  backgroundMusic = new SoundFile(this, sketchPath("music.mp3"));
  gameoverMusic = new SoundFile(this, "C:/Projekte/JPCM/Kurs 2/Tower Defense/gameover.mp3");
  backgroundMusic.play();
}

void draw() {
  background(backgroundMap);

  monsterSpawnTick();
  allMonstersTick(monsters);

  drawCoins();
  drawTowers();
  drawMonsters();
  drawCastle();

  if (lives <= 0) {
    background(255, 100, 0, 150);
    textSize(30);
    fill(255, 255, 255);
    text("GAME OVER", 500, 320);
    text("CASTLE HAS FALLEN!", 500, 350);
    noLoop();

    backgroundMusic.stop();
    gameoverMusic.play();
  }
}

void keyPressed() {
  switch(key) {
    case '1':
      placeTower(mouseX, mouseY, "basic");
      break;
    case '2':
      placeTower(mouseX, mouseY, "flame");
      break;
    case '3':
      placeTower(mouseX, mouseY, "electro");
      break;
  }
}

void placeTower(int mX, int mY, String towerType) {

  Tower newTower;

  switch (towerType) {
    case "basic":
      newTower = new BasicTower(mX, mY);
      break;
    case "flame":
      newTower = new FlameTower(mX, mY);
      break;
    case "electro":
      newTower = new ElectroTower(mX, mY);
      break;
    // Add more cases as you introduce new tower types
    default:
      return;
  }

  if (newTower.cost <= allCoins) {
    towers.add(newTower);
    allCoins -= newTower.cost;
  }
}

void drawCoins() {
  image(loadImage("coin.png"), 10, 10, 50, 50);

  fill(10);
  rect(70, 15, 80, 40);

  textSize(30);
  fill(255);
  text(allCoins, 100, 33);
}
//updated 24.02
void drawTowers() {
  for (Tower t : towers) {
    t.tick(); // This ensures the tick method is called, which is necessary for shooting lasers.
    image(t.image, t.x-(t.size/2), t.y-(t.size/2), t.size, t.size);
  }
}

void drawMonsters() {
  for (int i = 0; i < monsters.size(); i++) {
    Monster a = monsters.get(i);
    if (a != null && a.visible == true) {
      image(a.image, a.x-(a.size/2), a.y-(a.size/2), a.size, a.size);
      fill(170);  // Health Bar (Background)
      stroke(80);
      strokeWeight(2);
      rect(a.x-30, a.y-50, 60, 6, 5);
      fill(210, 30, 30);  // Health Bar (Red)
      stroke(80);
      strokeWeight(2);
      double f = (double)a.hp / (double)a.hpmax * 60.0;
      rect(a.x-30, a.y-50, (int)f, 6, 5);
      textSize(20);
      fill(10);
      textAlign(CENTER, CENTER);
      text(a.hp, a.x, a.y-50);
    }
    else if (a != null && a.visible == false) {
      monsters.remove(a);
    }
  }
}

void drawCastle() {
  image(castleImage, 885, 220, 120, 120);

  textSize(20);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  text("Lives: " + lives, 942, 350);
}
