import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pawlinker/model/heading.dart';

class FavoriteNotifier extends StateNotifier<List<Details>> {
  FavoriteNotifier() : super([]);

  void changeFav(Details detail) {
    if (state.contains(detail)) {
      state = state.where((element) => element != detail).toList();
    } else {
      state = [...state, detail];
    }
  }

  List<Details> allfavorite() {
    return state;
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, List<Details>>((ref) {
  return FavoriteNotifier();
});
