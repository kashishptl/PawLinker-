import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pawlinker/provider/cartProvider.dart';
import 'package:pawlinker/widgets/thumbnail.dart';

final quantityProvider = StateProvider<Map<String, int>>((ref) => {});

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider);
    final quantityMap = ref.watch(quantityProvider);

    double total = 0;
    for (var item in items) {
      int qty = quantityMap[item.id] ?? 1;
      total += (item.price ?? 0) * qty;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              ref.read(cartProvider.notifier).state = [];
              ref.read(quantityProvider.notifier).state = {};
            },
          ),
        ],
      ),
      body:
          items.isEmpty
              ? const Center(child: Text("Cart is empty"))
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total: ₹$total', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ElevatedButton(
                          onPressed: () {
                            // handle checkout
                          },
                          child: const Text('Checkout'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                        itemCount: items.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 65.0,
                          mainAxisExtent: 190,
                        ),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final quantity = quantityMap[item.id] ?? 1;

                          return Stack(
                            children: [
                              ThumbNail(item: item),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 28,
                                        width: 28,
                                        child: IconButton(
                                          icon: Icon(Icons.remove, size: 16, color: Theme.of(context).colorScheme.secondary),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          onPressed:
                                              quantity > 1
                                                  ? () {
                                                    ref.read(quantityProvider.notifier).state = {
                                                      ...quantityMap,
                                                      item.id: quantity - 1,
                                                    };
                                                  }
                                                  : null,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 6),
                                        child: Text(
                                          '$quantity',
                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 28,
                                        width: 28,
                                        child: IconButton(
                                          icon: Icon(Icons.add, size: 16, color: Theme.of(context).colorScheme.primary),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          onPressed:
                                              quantity < 10
                                                  ? () {
                                                    ref.read(quantityProvider.notifier).state = {
                                                      ...quantityMap,
                                                      item.id: quantity + 1,
                                                    };
                                                  }
                                                  : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
