import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/app_storage_keys.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/item_model.dart';
import '../domain/repository/cart_repo.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo cartRepo;
  final SharedPreferences sharedPreferences;

  CartProvider({required this.cartRepo, required this.sharedPreferences});

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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  checkOut() async {
    try {
      _isLoading = true;
      notifyListeners();
      final List items = [];
      for (var item in _cartList) {
        items.add({
          "product_id": item.id,
          "qty": item.qty,
          "details": item.addons != null
              ? item.addons!
                  .map((e) => e.name)
                  .toList()
                  .toString()
                  .replaceAll("[", '')
                  .replaceAll("]", '')
              : ""
        });
      }

      Map<String, dynamic> body = {
        "user_id": sharedPreferences.getString(AppStorageKey.token),
        "store_id": _cartList[0].store!.id.toString(),
        "order_date": DateTime.now().toString(),
        "total": totalSum,
        "items": items
      };
      log(body.toString());

      Either<ServerFailure, Response> response =
          await cartRepo.checkOut(data: body);
      response.fold((fail) {
        _isLoading = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail.error),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) async {
        await openWhatsApp(
            url: success.data["url"], id: success.data["order_id"].toString());
        _cartList.clear();
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isLoading = false;
      notifyListeners();
    }
  }

  double getItemPrice({required ItemModel item}) {
    double itemPrice = 0;
    double addonsPrice = 0;
    if (item.addons != null) {
      for (int i = 0; i < item.addons!.length; i++) {
        if (item.addons![i].isSelected!) {
          addonsPrice += int.parse(item.addons![i].price ?? "0");
        }
      }
    }
    itemPrice += (int.parse(item.price ?? "0") + addonsPrice) * item.qty!;
    return itemPrice;
  }

  openWhatsApp({
    required String url,
    required String id,
  }) async {
    final link = WhatsAppUnilink(
      // phoneNumber: "+966${_cartList.first.store!.phone}",
      phoneNumber: "+201554444801",
      text: format(url: url, id: id),
    );
    await launch('$link');
  }

  format({
    required String url,
    required String id,
  }) {
    int i = 1;
    return "الطلب رقم($id) : \n${_cartList.map((e) {
              return "\n  (${i++}): ${e.name}  ---- العدد: ${e.qty}\n^^الاضافات${e.addons?.map((addon) {
                        if (addon.isSelected!) {
                          return "\n ==>النوع  : ${addon.name}";
                        }
                      }).toList().join("").replaceAll("null", "")}\n\$\$\$\$\$\$ (السعر : ${getItemPrice(item: e)} ر.س) \$\$\$\$\$\$"
                  "\n ------------------------------------";
            }).toList().join("")}"
        "\nالتوصيل : 0 ر.س\nالاجمالي : $totalSum ر.س"
        "\n**رقم الهاتف : ${FirebaseAuth.instance.currentUser?.phoneNumber?.replaceAll("+", "")}+ \n**المدينة : ${sharedPreferences.getString(AppStorageKey.cityName)}"
        "\n$url";
  }
}
