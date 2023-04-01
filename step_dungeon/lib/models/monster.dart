// models/monster.dart
import 'dart:math';
import 'package:step_dungeon/models/item.dart';

class Monster {
  int level;
  int health = 5;
  bool isSpecial;

  Monster({required this.level, required this.isSpecial}) {
    health = _calculateHealth();
  }

  int _calculateHealth() {
    int baseHealth = level * 10;
    if (isSpecial) {
      return baseHealth * 3;
    } else {
      return baseHealth;
    }
  }

  void takeDamage(int damage) {
    health -= damage;
  }

  Item? generateDrop() {
    int random = Random().nextInt(100);
    ItemRarity rarity;

    if (isSpecial) {
      if (random < 50) {
        rarity = ItemRarity.epic;
      } else if (random < 80) {
        rarity = ItemRarity.legendary;
      } else if (random < 95) {
        rarity = ItemRarity.rare;
      } else {
        rarity = ItemRarity.normal;
      }
    } else {
      if (random < 70) {
        rarity = ItemRarity.normal;
      } else if (random < 90) {
        rarity = ItemRarity.rare;
      } else if (random < 99) {
        rarity = ItemRarity.epic;
      } else {
        rarity = ItemRarity.legendary;
      }
    }

    return Item(level: level, rarity: rarity);
  }
}
