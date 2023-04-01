import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:step_dungeon/models/hero.dart';
import 'package:step_dungeon/models/item.dart';
import 'package:step_dungeon/models/monster.dart';

class GameState with ChangeNotifier {
  Hero hero = Hero(level: 1, experience: 0);
  Monster? activeMonster;
  int monsterLevel = 1;
  int monstersDefeated = 0;
  List<Item> inventory = [];
  Timer? _monsterTimer;
  bool isFighting = false;
  double attackSpeedMultiplier = 1.0;

  GameState() {
    createNewMonster();
  }

  void createNewMonster() {
    bool isSpecial = (monstersDefeated % 10 == 0);
    activeMonster = Monster(level: monsterLevel, isSpecial: isSpecial);
  }

  void attackMonster() {
    if (activeMonster == null || activeMonster!.health <= 0) {
      activeMonster = Monster(level: monsterLevel, isSpecial: isSpecial);
    }
    activeMonster!.health -= hero.damage;
    if (activeMonster!.health <= 0) {
      activeMonster = null;
      int newMonsterLevel = monsterLevel;

      newMonsterLevel++;

      monsterLevel = newMonsterLevel;
    }
    notifyListeners();
  }

  void _handleMonsterDefeat() {
    Item? drop = activeMonster!.generateDrop();
    if (drop != null) {
      inventory.add(drop);
    }
    monstersDefeated++;
    if (!activeMonster!.isSpecial) {
      monsterLevel++;
    }
    createNewMonster();
    _resetMonsterTimer();
  }

  void _startMonsterTimer() {
    isFighting = true;
    _monsterTimer = Timer(Duration(seconds: 20), () {
      _resetMonsterTimer();
      createNewMonster();
      notifyListeners();
    });
  }

  void _resetMonsterTimer() {
    isFighting = false;
    _monsterTimer?.cancel();
  }

  void setAttackSpeedMultiplier(double multiplier) {
    attackSpeedMultiplier = multiplier;
  }
}
