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
              ElevatedButton(
                onPressed: () => context.read<GameState>().attackMonster(),
                child: Text('Attack Monster'),
              ),
              Text('Monster Level: ${context.watch<GameState>().monsterLevel}'),
              Text('Monster Health: ${context.watch<GameState>().activeMonster?.health ?? 0}'),
              Text('Hero Level: ${context.watch<GameState>().hero.level}'),
              Text('Hero Damage: ${context.watch<GameState>().hero.damage}'),
              Text('Inventory:'),
              ...context
                  .watch<GameState>()
                  .inventory
                  .map((item) => Text('Item Level: ${item.level}, Rarity: ${item.rarity}, Damage Bonus: ${item.damageBonus}'))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
