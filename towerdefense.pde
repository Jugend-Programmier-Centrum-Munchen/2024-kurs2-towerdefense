// Checkpoints und Einstellungen der Karte
PImage backgroundMap;

int[] pointsX = {-10, 160, 160, 360, 360, 630, 630, 900};
int[] pointsY = {360, 360, 170, 170, 425, 425, 310, 310};

ArrayList<Monster> monsters = new ArrayList<Monster>();
ArrayList<Tower> towers = new ArrayList<Tower>();

int globalMonsterTick;
int currentMonsterRate;
int allCoins = 30;

//neu
PImage castleImage;
int lives = 100;


void setup() {
  size(1000, 670);
  backgroundMap = loadImage("back.png");
  background(backgroundMap);
  towers.add(new BasicTower(440, 350, loadImage("tower.png"), 80, 2, 200)); // Erster Standart-Tower
  globalMonsterTick = 0;
  currentMonsterRate = 50;

  //neu
  castleImage = loadImage("burg.png");
  drawCoins();
}

void draw() {
  background(backgroundMap);
  drawCoins();

  monsterSpawnTick();
  allMonstersTick(monsters);

  drawTowers();
  drawMonsters();

  drawCastle();
}

void keyPressed() {
   if (key == '1') {
    placeTower(mouseX, mouseY, "basic");
  }
  if (key == '2') {
    placeTower(mouseX, mouseY, "flamethrower");
  }
}
//updated code 24.02

void placeTower(int mX, int mY, String towerType) {
  int cost = 0; // You'll need to define the cost based on tower type
  PImage towerImage= loadImage("tower.png");; // Default image, change as needed
  int towerSize = 80; // Default size, adjust as necessary
  int towerDamage = 1; // Default damage, adjust as necessary
  int towerRange = 200; // Default range, adjust as necessary

  // Determine the specific attributes and cost for each tower type
  switch (towerType) {
    case "basic":
      cost = 5; // Example cost
      towerImage = loadImage("tower.png");
      towerDamage = 2;
      towerRange = 200;
      break;
    case "flamethrower":
      cost = 10; // Example cost
      towerImage = loadImage("tower_flame.png");
      towerDamage = 4;
      towerRange = 100;
      break;
    // Add more cases for each new tower type
  }

  // Check if the player has enough coins to place the tower
  if (allCoins >= cost) {
    allCoins -= cost;
    Tower newTower = null;

    // Create the new tower based on the type
    switch (towerType) {
      case "basic":
        newTower = new BasicTower(mX, mY, towerImage, towerSize, towerDamage, towerRange);
        break;
      case "flamethrower":
        newTower = new FlameTower(mX, mY, towerImage, towerSize, towerDamage, towerRange);
        break;
      // Add more cases as you introduce new tower types
    }

    if (newTower != null) {
      towers.add(newTower);
    }
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
  for (Monster a : monsters) {
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
  }
}

void drawCastle() {
  image(castleImage, 885, 220, 120, 120);

  textSize(20);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  text("Lives: " + lives, 942, 350);
}
