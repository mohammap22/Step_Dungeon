// models/hero.dart
import 'package:step_dungeon/models/item.dart';

class Hero {
  int level;
  int experience;
  Item? equippedWeapon;

  Hero({required this.level, required this.experience});

  int get damage {
    int baseDamage = level * 5;
    int weaponDamage = equippedWeapon?.damageBonus ?? 0;
    return baseDamage + weaponDamage;
  }

  void addExperience(int experience) {
    this.experience += experience;
    level = (this.experience / 100).floor();
  }

  void equipWeapon(Item weapon) {
    equippedWeapon = weapon;
  }
}
