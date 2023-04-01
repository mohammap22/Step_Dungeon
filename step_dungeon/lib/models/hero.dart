import 'package:step_dungeon/models/item.dart';

class Hero {
  int level;
  int experience;
  Item? equippedWeapon;
  double attackSpeed=1;

  Hero({required this.level, required this.experience}) {
    attackSpeed = _calculateAttackSpeed();
  }

  int get damage {
    int baseDamage = level * 5;
    int weaponDamage = equippedWeapon?.damageBonus ?? 0;
    return baseDamage + weaponDamage;
  }

  void addExperience(int experience) {
    this.experience += experience;
    level = (this.experience / 100).floor();
    attackSpeed = _calculateAttackSpeed();
  }

  void equipWeapon(Item weapon) {
    equippedWeapon = weapon;
    attackSpeed = _calculateAttackSpeed();
  }

  double _calculateAttackSpeed() {
    double baseAttackSpeed = 1.0;

    switch (equippedWeapon?.rarity) {
      case ItemRarity.normal:
        baseAttackSpeed += 0.0;
        break;
      case ItemRarity.rare:
        baseAttackSpeed += 0.1;
        break;
      case ItemRarity.epic:
        baseAttackSpeed += 0.2;
        break;
      case ItemRarity.legendary:
        baseAttackSpeed += 0.3;
        break;
      case null:
        baseAttackSpeed += 0.0;
        break;
    }

    return baseAttackSpeed / level;
  }
}
