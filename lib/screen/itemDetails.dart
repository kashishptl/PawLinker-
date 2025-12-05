import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pawlinker/model/heading.dart';
import 'package:pawlinker/provider/favoriteProvider.dart';
import 'package:pawlinker/provider/cartProvider.dart';
import 'package:pawlinker/screen/cart.dart';
import 'package:pawlinker/screen/fullScreenImg.dart';

class ItemDetails extends ConsumerStatefulWidget {
  const ItemDetails({super.key, required this.item});
  final Details item;

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends ConsumerState<ItemDetails> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating, duration: const Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoriteProvider);
    final cartItems = ref.watch(cartProvider);
    final isFav = favorites.contains(widget.item);
    final isInCart = cartItems.contains(widget.item);
    final isPet = widget.item.isPet;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: () {
              ref.read(favoriteProvider.notifier).changeFav(widget.item);
              _showSnack(context, isFav ? 'Removed from favorites' : 'Added to favorites');
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: isInCart ? Colors.green : null),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80), // to avoid overlapping with bottom button
            child: Column(
              children: [
                SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.item.image.length,
                    itemBuilder: (context, index) {
                      final imgUrl = widget.item.image[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => FullScreenImg(item: widget.item, imageUrl: imgUrl)),
                            );
                          },
                          child: Hero(
                            tag: imgUrl,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(imgUrl, width: double.infinity, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.item.title, style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 6),

                      // Show different information based on whether it's a pet or product
                      if (isPet)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Breed: ${widget.item.breed}", style: TextStyle(color: Colors.grey[700])),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  widget.item.gender == Gender.Male ? Icons.male : Icons.female,
                                  color: widget.item.gender == Gender.Male ? Colors.blue : Colors.pink,
                                ),
                                const SizedBox(width: 8),
                                Text("${widget.item.age} Years old"),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.cake, color: Colors.amber),
                                const SizedBox(width: 8),
                                Text("Birth Date: ${widget.item.date}"),
                              ],
                            ),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Product Type: ${widget.item.breed}", style: TextStyle(color: Colors.grey[700])),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.primary),
                                const SizedBox(width: 8),
                                Text("Production Date: ${widget.item.date}"),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.av_timer, color: Theme.of(context).colorScheme.primary),
                                const SizedBox(width: 8),
                                Text("Product Lasting Duration: ${widget.item.age} Years"),
                              ],
                            ),
                          ],
                        ),

                      const SizedBox(height: 10),
                      if (widget.item.price != null)
                        Text("₹${widget.item.price}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 20),
                      Text(widget.item.description),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),

          // Bottom cart button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: InkWell(
                  onTap: () {
                    ref.read(cartProvider.notifier).changeCart(widget.item);
                    _showSnack(context, isInCart ? 'Removed from cart' : 'Added to cart');
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: isInCart ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(isInCart ? Icons.remove_shopping_cart : Icons.shopping_cart, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          isInCart ? 'Remove from Cart' : 'Add to Cart',
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
