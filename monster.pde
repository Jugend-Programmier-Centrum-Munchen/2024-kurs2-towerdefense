// Klasse Monster
class Monster {
  int x, y;
  int hp;
  int hpmax;
  int checkpoint = 0;
  PImage image;
  boolean visible = true;
  int speed;
  int size;
  
  Monster(int hp, int speed, PImage img, int size) {
    this.x = pointsX[0];
    this.y = pointsY[0];
    this.hp = hp;
    this.hpmax = hp;
    this.image = img;
    this.speed = speed;
    this.size = size;
    
    this.checkpoint = 1;  // Immer zuerst ersten Checkpoint anpeilen
    this.visible = true;  // Immer am Anfang sichtbar
    
    image(img, x-(size/2), y-(size/2), size, size);  // Monster platzieren
  }
  
  void damage(int amount) {
    hp -= amount;
    if (hp <= 0) this.visible = false;
  }
}

//
//  Lässt für ein Monster ein Tick vergehen
//
void oneMonsterTick(Monster m) {
  
  if (m.checkpoint >= pointsX.length) {    // Wenn nächster Checkpoint nicht mehr gültig ist
    m.visible = false;
    return;
  }
  
  if (m.x < pointsX[m.checkpoint] - m.speed) m.x += m.speed;        // Anpassen von X Koordinate
  else if (m.x > pointsX[m.checkpoint] + m.speed) m.x -= m.speed;
  
  if (m.y < pointsY[m.checkpoint] - m.speed) m.y += m.speed;        // Anpassen von Y Koordinate
  else if (m.y > pointsY[m.checkpoint] + m.speed) m.y -= m.speed;
  
  if (m.x >= pointsX[m.checkpoint] - m.speed &&         // Wenn Checkpoint erreicht
      m.x <= pointsX[m.checkpoint] + m.speed &&
      m.y >= pointsY[m.checkpoint] - m.speed &&
      m.y <= pointsY[m.checkpoint] + m.speed) {
      
        m.x = pointsX[m.checkpoint];
        m.y = pointsY[m.checkpoint];
        m.checkpoint ++;
  }
  
  for (Tower t : towers) {
    if (dist(m.x, m.y, t.x, t.y) <= t.range) {
      m.damage(t.damage);
      
      stroke(255, 0, 0);
      strokeWeight(4);
      line(m.x, m.y, t.x, t.y);
    }
  }
}

//
//  Lässt für alle Monster einen Tick vergehen.
//
void allMonstersTick(ArrayList<Monster> monsterList) {
  for (Monster a : monsterList) {
    if (a != null && a.visible == true) {
      oneMonsterTick(a);
    }
  }
}
