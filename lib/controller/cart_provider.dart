import 'dart:developer';
import 'package:baber/navigation/custom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import '../data/model/item_model.dart';
import '../domain/repository/cart_repo.dart';
import 'city_provider.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo cartRepo;
  CartProvider({required this.cartRepo});

  List<ItemModel> _cartList = [];
  List<ItemModel> get cartList => _cartList;
  bool isAdded = false;

  void getCartData() {
    _cartList.clear();
    _cartList.addAll(cartRepo.getCartList());
    log("==>${_cartList.map((e) => e.toJson()).toList()}");
    getTotalSum();
    notifyListeners();
  }

  void removeFromCart({
    required ItemModel item,
  }) {
    // _cartList.removeAt(index);
    _cartList.removeWhere((e) => e.id == item.id);
    cartRepo.saveNewItems(_cartList);
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
      int index = _cartList.indexOf(item);
      _cartList.removeAt(index);
      _cartList.insert(index, item);
      cartRepo.saveNewItems(_cartList);
    } else {
      _cartList.add(item);
      cartRepo.saveNewItems(_cartList);
    }
    item.isAdded = true;
    getCartData();
    notifyListeners();
  }

  checkStore({required ItemModel item}) {
    return _cartList.any((e) =>
        e.store?.id == item.store?.id && e.store?.phone == item.store?.phone);
  }

  existInCart({required ItemModel item}) {
    return _cartList.any((e) => e.id == item.id);
  }

  double totalSum = 0;
  void getTotalSum() {
    totalSum = 0;
    for (var meal in _cartList) {
      double addonsPrice = 0;
      if (meal.addons != null) {
        for (int i = 0; i < meal.addons!.length; i++) {
          if (meal.addons![i].isSelected!) {
            addonsPrice += int.parse(meal.addons![i].price ?? "0");
          }
        }
      }
      totalSum += (int.parse(meal.price ?? "0") + addonsPrice) * meal.qty!;
    }
  }

  openWhatsApp() async {
    final link = WhatsAppUnilink(
      // phoneNumber: "+966${_cartList.first.store!.phone}",
      phoneNumber: "+201017622825",
      text: format(),
    );
    await launch('$link');
  }

  format() {
    int i = 1;
    return "طلبك هو : \n${_cartList.map((e) {
          return "\n  ****الطلب رقم (${i++}): ${e.name}  ---- العدد: ${e.qty}${e.addons?.map((addon) {if (addon.isSelected!) {
            return "\n^^الاضافات \n ==>النوع  : ${addon.name}";
          }}).toList().join("").replaceAll("null", "")}\n\$\$\$\$\$\$ (السعر : ${e.price} ر.س) \$\$\$\$\$\$"
              "\n ------------------------------------";
        }).toList().join("")}"
        "\nالتوصيل : 0 ر.س\nالاجمالي : $totalSum ر.س"
        "\n**رقم الهاتف : ${FirebaseAuth.instance.currentUser?.phoneNumber} \n**المدينة : ${Provider.of<CityProvider>(CustomNavigator.navigatorState.currentContext!, listen: false).city!.name!}";
  }
}
