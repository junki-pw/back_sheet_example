import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'normal.g.dart';

@riverpod
class _Pixel extends _$Pixel {
  @override
  double build() => 0;

  void updatePixel(double pixels) {
    state = pixels;
  }
}

@riverpod
bool _isBack(Ref ref) {
  return ref.watch(_pixelProvider) < -100;
}

class NormalSheet extends HookConsumerWidget {
  const NormalSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();

    ref.listen(
      _isBackProvider,
      (preValue, newValue) {
        if (preValue != newValue && newValue) {
          Navigator.of(context).pop();
        }
      },
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '通常のボトムシート',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    child: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 100,
              controller: controller
                ..addListener(() {
                  controller.position.pixels;
                  ref
                      .read(_pixelProvider.notifier)
                      .updatePixel(controller.position.pixels);
                }),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
