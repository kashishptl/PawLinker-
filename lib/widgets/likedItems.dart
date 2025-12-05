import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pawlinker/model/heading.dart';
import 'package:pawlinker/provider/favoriteProvider.dart';
import 'package:pawlinker/widgets/thumbnail.dart';

class LikedItems extends ConsumerWidget {
  const LikedItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Details> items = ref.watch(favoriteProvider);
    return items.isEmpty
        ? const Center(child: Text("You haven't liked any yet"))
        : Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
          child: GridView.builder(
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 65.0,
              mainAxisExtent: 190,
            ),
            itemBuilder: (context, index) {
              return ThumbNail(item: items[index]);
            },
          ),
        );
  }
}
