import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_dungeon/providers/game_state.dart';
import 'package:step_dungeon/providers/step_tracker.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StepTracker()),
        ChangeNotifierProvider(create: (context) => GameState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();

    final heroDamage = gameState.hero.damage;
    final heroAttackSpeed = gameState.hero.attackSpeed;
    final heroDPS = (heroDamage * heroAttackSpeed).toStringAsFixed(1);

    return MaterialApp(
      title: 'Step Hero',
      home: Scaffold(
        appBar: AppBar(title: Text('Step Hero')),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Steps: ${context.watch<StepTracker>().steps}'),
              Text('XP: ${context.watch<StepTracker>().calculateXP()}'),
              Text('DPS: $heroDPS'),
              TextButton(
                onPressed: gameState.isFighting ? null : gameState.attackMonster,
                child: Text('Attack Monster'),
              ),
              Text('Monster Level: ${gameState.monsterLevel}'),
              Text('Monster Health: ${gameState.activeMonster?.health ?? 0}'),
              Text('Hero Level: ${gameState.hero.level}'),
              Text('Inventory:'),
              ...gameState.inventory
                  .map(
                    (item) => Text(
                      'Item Level: ${item.level}, Rarity: ${item.rarity}, Damage Bonus: ${item.damageBonus}, Attack Speed: ${item.speedBonus.toStringAsFixed(1)}',
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
