// models/item.dart
enum ItemRarity { normal, rare, epic, legendary }

class Item {
  int level;
  ItemRarity rarity;
  int damageBonus = 1;

  Item({required this.level, required this.rarity}) {
    damageBonus = _calculateDamageBonus();
    damageBonus ??= 0;
  }

  int _calculateDamageBonus() {
    int baseDamage = level * 2;
    double rarityMultiplier;

    switch (rarity) {
      case ItemRarity.normal:
        rarityMultiplier = 1.0;
        break;
      case ItemRarity.rare:
        rarityMultiplier = 1.5;
        break;
      case ItemRarity.epic:
        rarityMultiplier = 2.0;
        break;
      case ItemRarity.legendary:
        rarityMultiplier = 2.5;
        break;
    }

    return (baseDamage * rarityMultiplier).toInt();
  }
}
