import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pawlinker/model/heading.dart';

class CartNotifier extends StateNotifier<List<Details>> {
  CartNotifier() : super([]);

  void changeCart(Details detail) {
    if (state.contains(detail)) {
      state = state.where((element) => element != detail).toList();
    } else {
      state = [...state, detail];
    }
  }

  List<Details> allCart() {
    return state;
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<Details>>((ref) {
  return CartNotifier();
});
