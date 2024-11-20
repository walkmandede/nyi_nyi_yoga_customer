import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/class_model.dart';

class CartController {

  CartController._privateConstructor();
  static final CartController _instance = CartController._privateConstructor();

  factory CartController() {
    return _instance;
  }


  ValueNotifier<List<ClassModel>> selectedData = ValueNotifier([]);

  void _addToCart({required ClassModel model}){
    final temp = [...selectedData.value];
    temp.add(model);
    selectedData.value = temp;
  }

  void _removeFromCart({required ClassModel model}){
    final temp = [...selectedData.value];
    temp.removeWhere((element) => element.id == model.id,);
    selectedData.value = temp;
  }

  void toggleItem({required ClassModel model}){
    if(isAlreadyInCart(model: model)){
      _removeFromCart(model: model);
    }
    else{
      _addToCart(model: model);
    }
  }

  bool isAlreadyInCart({required ClassModel model}){
    return selectedData.value.where((element) => element.id == model.id,).isNotEmpty;
  }

  void clearCart() {
    selectedData.value = [];
  }

}

