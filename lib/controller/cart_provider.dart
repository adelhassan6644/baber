import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import '../data/model/item_model.dart';
import '../domain/repository/cart_repo.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo cartRepo;
  CartProvider({required this.cartRepo});

  List<ItemModel> _cartList = [];
  List<ItemModel> get cartList => _cartList;
  bool isSameStore = false;
  bool isAdded = false;

  void getCartData() {
    _cartList.clear();
    _cartList.addAll(cartRepo.getCartList());
    log("==>${_cartList.map((e) => e.toJson()).toList()}");
    notifyListeners();
  }

  void removeFromCart({required ItemModel item, required int index}) {
    _cartList.removeAt(index);
    cartRepo.saveNewItems(_cartList);
    // isAddedToCart(item: item);
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
    } else {
      _cartList.add(item);
      cartRepo.saveNewItems(_cartList);
    }
    item.isAdded = true;
    getCartData();
    getTotalSum();
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
    for (var meal in _cartList) {
      totalSum = 0;
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

  // openWhatsApp({required String phone,required String text}) async{
  //   var whatsAppUrlAndroid = "whatsapp://send?phone=$phone&text=hello";
  //   var whatAppURLIos ="https://wa.me/$phone?text=${Uri.parse("hello")}";
  //   if(Platform.isIOS){
  //     // for iOS phone only
  //     if( await canLaunch(whatAppURLIos)){
  //       await launch(whatAppURLIos, forceSafariVC: false);
  //     }else{
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "whatsapp no installed",
  //               isFloating: true,
  //               backgroundColor: ColorResources.ACTIVE,
  //               borderColor: Colors.transparent));
  //     }
  //
  //   }else{
  //     if( await canLaunch(whatsAppUrlAndroid)){
  //       await launch(whatsAppUrlAndroid);
  //     }else{
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "whatsapp no installed",
  //               isFloating: true,
  //               backgroundColor: ColorResources.ACTIVE,
  //               borderColor: Colors.transparent));
  //
  //     }
  //
  //
  //   }
  //
  // }
  openWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: "+966${_cartList.first.store!.phone}",
      text: "طلبك عبارة عن : ${_cartList.map((e) {
        return e.name;
      }).toString()}",
    );
    await launch('$link');
  }
}
