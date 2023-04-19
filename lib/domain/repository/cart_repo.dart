import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../app/core/utils/app_storage_keys.dart';
import '../../data/model/item_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<ItemModel> getCartList() {
    List<String>? cart = [];
    if (sharedPreferences.containsKey(AppStorageKey.cartItems)) {
      cart = sharedPreferences.getStringList(AppStorageKey.cartItems);
    }

    List<ItemModel> items = [];
    cart?.forEach((item) => items.add(ItemModel.fromJson(jsonDecode(item))));
    return items;
  }

  void saveNewItems(List<ItemModel> items) {
    List<String> cart = [];
    for (var item in items) {
      cart.add(jsonEncode(item.toJson()));
    }
    sharedPreferences.setStringList(AppStorageKey.cartItems, cart);
  }
}
