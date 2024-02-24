// The abstract Tower class. All towers will inherit from this class.
abstract class Tower {
  protected int damage;
  protected PImage image;
  protected int size;
  protected int x, y;
  protected int range;

  // Constructor for the Tower class
  public Tower(int x, int y, PImage img, int size, int damage, int range) {
    this.image = img;
    this.size = size;
    this.damage = damage;
    this.range = range;
    this.x = x;
    this.y = y;
  }

  // Abstract method tick. This must be implemented by all subclasses.
  abstract void tick();
}

// The BasicTower class represents a basic tower with standard damage and range.
class BasicTower extends Tower {
  
  public BasicTower(int x, int y, PImage img, int size, int damage, int range) {
    super(x, y, img, size, damage, range);
  }
  
  // Implementation of the tick method for the basic tower.
  @Override
  void tick() {
    for (Monster m : monsters) {
      if (dist(x, y, m.x, m.y) <= range && m.hp > 0) {
        m.damage(damage);
        stroke(255, 0, 0);
        strokeWeight(4);
        line(x, y, m.x, m.y);
      }
    }
  }
}

// The FlamethrowerTower class represents a tower with shorter range, higher damage, and a flame effect.
class FlameTower extends Tower {
  
  public FlameTower(int x, int y, PImage img, int size, int damage, int range) {
    super(x, y, img, size, damage, range);
  }
  
  // Implementation of the tick method for the flamethrower tower.
  @Override
  void tick() {
    for (Monster m : monsters) {
      if (dist(x, y, m.x, m.y) <= range && m.hp > 0) {
        m.damage(damage);
        stroke(255, 150, 0);
        strokeWeight(10);
        line(x, y, m.x, m.y);
      }
    }
  }
}
