import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class myNotifier extends StateNotifier<List<String>> {
  myNotifier() : super([]);

  void addString(String stringToAdd) {
    state = [...state, stringToAdd];
  }
}

final myProvider = StateNotifierProvider((ref) => myNotifier());

class MyApp extends ConsumerWidget {
  Random random = new Random();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfString = ref.watch(myProvider) as List;

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              ...listOfString.map(
                (string) => Text(string),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                ref
                    .read(myProvider.notifier)
                    .addString('string ${random.nextInt(100)}');
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
