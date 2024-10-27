import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheet_example/sheets/normal.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sheet Example'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ElevatedButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const NormalSheet(),
                ),
                child: const Text('通常のボトムシート'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('DraggableScrollableSheetを使ったボトムシート'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
