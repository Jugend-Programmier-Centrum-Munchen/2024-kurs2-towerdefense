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
}
