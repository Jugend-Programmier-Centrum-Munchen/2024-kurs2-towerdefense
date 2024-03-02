//
// Klasse fuer die Monster
//

int monsterTot = 0;

class Monster {
  int x, y;
  int hp;
  int hpmax;
  int checkpoint = 0;
  PImage image;
  boolean visible = true;
  int originalSpeed;
  int speed;
  int size;

  int coins;

  Monster(int hp, int speed, PImage img, int size, int coins) {
    this.x = pointsX[0];
    this.y = pointsY[0];
    this.hp = hp;
    this.hpmax = hp;
    this.image = img;
    this.speed = speed;
    this.originalSpeed = this.speed;
    this.size = size;
    this.coins = coins;

    this.checkpoint = 1;  // Immer zuerst ersten Checkpoint anpeilen
    this.visible = true;  // Immer am Anfang sichtbar

    image(img, x-(size/2), y-(size/2), size, size);  // Monster platzieren
  }

  void damage(int amount) {
    hp -= amount;
    if (hp <= 0) {
      this.visible = false;
      allCoins += this.coins;
      monsterTot++;
    }
  }
  
  void speedReduction(int amount) {
    this.speed -= amount;
    if (this.speed <= 0) this.speed = 1;
  }
  
  void speedReset() {
    this.speed = originalSpeed;
  }

  void tick() {
    if (this.checkpoint >= pointsX.length || !this.visible) {    // Wenn nächster Checkpoint nicht mehr gültig ist
      this.visible = false;
      lives--;
      return;
    }

    if (this.x < pointsX[this.checkpoint] - this.speed) this.x += this.speed;        // Anpassen von X Koordinate
    else if (this.x > pointsX[this.checkpoint] + this.speed) this.x -= this.speed;

    if (this.y < pointsY[this.checkpoint] - this.speed) this.y += this.speed;        // Anpassen von Y Koordinate
    else if (this.y > pointsY[this.checkpoint] + this.speed) this.y -= this.speed;

    if (this.x >= pointsX[this.checkpoint] - this.speed &&         // Wenn Checkpoint erreicht
      this.x <= pointsX[this.checkpoint] + this.speed &&
      this.y >= pointsY[this.checkpoint] - this.speed &&
      this.y <= pointsY[this.checkpoint] + this.speed) {

        this.x = pointsX[this.checkpoint];
        this.y = pointsY[this.checkpoint];
        this.checkpoint ++;
    }
  }
}

//
//  Lässt für alle Monster einen Tick vergehen.
//
void allMonstersTick(ArrayList<Monster> monsterList) {
  for (Monster a : monsterList) {
    if (a != null && a.visible == true) {
      a.tick();
    }
  }
}

//
// Funktion fuer die automatischen Monster Spawns
//
void monsterSpawnTick() {
  if (globalMonsterTick >= currentMonsterRate) {

    // Monster zufaellig spawnen
    switch ((int)random(1, 4)) {
      case 1:
        monsters.add(new Monster(300, (int)random(1, 3), loadImage("monster_pink.png"), 65, 1));
        break;
      case 2:
        monsters.add(new Monster(1000, (int)random(2, 5), loadImage("monster_blue.png"), 70, 2));
        break;
      case 3:
        monsters.add(new Monster(2500, (int)random(3, 7), loadImage("monster_green.png"), 60, 3));
        break;
    }

    globalMonsterTick = 0;
  }
  else {
    globalMonsterTick++;
  }
}
