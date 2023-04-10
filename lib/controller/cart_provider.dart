import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../data/model/item_model.dart';
import '../domain/repository/cart_repo.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo cartRepo;
  CartProvider({required this.cartRepo});

  List<ItemModel> _cartList = [];
  List<ItemModel> get cartList => _cartList;
  bool _isAdded = false;
  bool get isAdded => _isAdded;

  void getCartData() {
    _cartList = [];
    _cartList.addAll(cartRepo.getCartList());
    log("==>${_cartList.map((e) => e.toJson()).toList()}");
    notifyListeners();
  }

  void removeFromCart({required ItemModel item, required int index}) {
    _cartList.removeAt(index);
    cartRepo.saveNewItems(_cartList);
    isAddedToCart(item: item);
    getCartData();
    notifyListeners();
  }

  void clearCartList() {
    _cartList = [];
    cartRepo.saveNewItems(_cartList);
    notifyListeners();
  }

  void addToCart({required ItemModel item}) {
    if (_cartList.any((e) => e.id == item.id)) {
      _cartList.removeWhere((e) => e.id == item.id);
      _cartList.add(item);
      cartRepo.saveNewItems(_cartList);
      isAddedToCart(item: item);
    } else {
      _cartList.add(item);
      cartRepo.saveNewItems(_cartList);
      isAddedToCart(item: item);
    }
    getCartData();
    notifyListeners();
  }

  void isAddedToCart({required ItemModel item}) {
    _isAdded = _cartList.any((e) => e.id == item.id&&e.qty == item.qty);
    notifyListeners();
  }

  // setNewQuantityToItem({required ItemModel item,required int qty}) {
  //   item.qty=qty;
  //   addToCart(item: item);
  //   notifyListeners();
  // }
}
