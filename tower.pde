//
// Klasse fuer die Tuerme
//

class Tower {
  int damage;
  PImage image;
  int size;
  int x, y;
  int range;

  Tower(int x, int y, PImage img, int size, int damage, int range) {
    this.image = img;
    this.size = size;
    this.damage = damage;
    this.range = range;
    this.x = x;
    this.y = y;
  }
  
  void tick() {} // Das brauchen wir, damit die anderen Türme erben können
}

//
// Der normale Turm mit normalen Schaden und Range
//
class towerBasic extends Tower {
  
  towerBasic(int x, int y, PImage img, int size, int damage, int range) {
    super(x, y, img, size, damage, range);
  }
  
  void tick() {
    for (Monster m : monsters) {
      if (dist(super.x, super.y, m.x, m.y) <= super.range) {
        m.damage(super.damage);

        stroke(255, 0, 0);
        strokeWeight(4);
        line(super.x, super.y, m.x, m.y);
      }
    }
  }
}
