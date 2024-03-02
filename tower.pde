// The abstract Tower class. All towers will inherit from this class.
abstract class Tower {
  int damage;
  PImage image;
  int size;
  int x, y;
  int range;
  public int cost;

  // Constructor for the Tower class
  public Tower(int x, int y) {
    this.x = x;
    this.y = y;
  }

  // Abstract method tick. This must be implemented by all subclasses.
  abstract void tick();
}

// The BasicTower class represents a basic tower with standard damage and range.
class BasicTower extends Tower {
  
  public BasicTower(int x, int y) {
    super(x, y); // Konstruktor in Super Klasse
    
    super.cost = 5; // Example cost
    super.image = loadImage("tower.png");
    super.damage = 2;
    super.range = 200;
    super.size = 80;
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
        break;
      }
    }
  }
}

// The FlamethrowerTower class represents a tower with shorter range, higher damage, and a flame effect.
class FlameTower extends Tower {
  
  public FlameTower(int x, int y) {
    super(x, y);
    
    super.cost = 10; // Example cost
    super.image = loadImage("tower_flame.png");
    super.damage = 4;
    super.range = 100;
    super.size = 80;
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
        break;
      }
    }
  }
}

class ElectroTower extends Tower {
  
  public ElectroTower(int x, int y) {
    super(x, y);
    
    super.cost = 15; // Example cost
    super.image = loadImage("electro_tower.png");
    super.damage = 8;
    super.range = 80;
    super.size = 80;
  }
  
  // Implementation of the tick method for the flamethrower tower.
  @Override
  void tick() {
    for (Monster m : monsters) {
      if (dist(x, y, m.x, m.y) <= range && m.hp > 0 && frameCount % 7 < 3) {
        m.damage(damage);
        stroke(0, 50, 255);
        strokeWeight(7);
        line(x, y, m.x, m.y);
        m.speedReduction(3);
        break;
      }
      else if (dist(x, y, m.x, m.y) > range) {
        m.speedReset();
      }
    }
  }
}
