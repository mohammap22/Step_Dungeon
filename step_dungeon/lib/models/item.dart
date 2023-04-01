enum ItemRarity { normal, rare, epic, legendary }

class Item {
  int level;
  ItemRarity rarity;
  int damageBonus=1;
  int speedBonus=1;

  Item({required this.level, required this.rarity}) {
    var bonuses = _calculateBonuses();
    damageBonus = bonuses[0];
    speedBonus = bonuses[1];
  }

  List<int> _calculateBonuses() {
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

    int damageBonus = (baseDamage * rarityMultiplier).toInt();
    int speedBonus = (rarityMultiplier * 10).toInt();
    return [damageBonus, speedBonus];
  }
}
