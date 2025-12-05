import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pawlinker/model/heading.dart';
import 'package:pawlinker/provider/cartProvider.dart';
import 'package:pawlinker/provider/favoriteProvider.dart';

class FullScreenImg extends ConsumerWidget {
  final Details item;
  FullScreenImg({super.key, required this.item, required this.imageUrl});
  String imageUrl;
  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating, duration: const Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteProvider);
    final cartItems = ref.watch(cartProvider);
    final isFav = favorites.contains(item);
    final isInCart = cartItems.contains(item);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: () {
              ref.read(favoriteProvider.notifier).changeFav(item);
              _showSnack(context, isFav ? 'Removed from favorites' : 'Added to favorites');
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: isInCart ? Colors.green : null),
            onPressed: () {
              ref.read(cartProvider.notifier).changeCart(item);
              _showSnack(context, isInCart ? 'Removed from cart' : 'Added to cart');
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: imageUrl, // make sure it matches the tag in ItemDetails
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 1.0,
              maxScale: 5.0,
              child: Align(
                alignment: Alignment.center,
                child: Image.network(imageUrl, width: double.infinity, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
