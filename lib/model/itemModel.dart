import 'package:flutter/material.dart';

class ItemModel extends ChangeNotifier{

  //list of the items on sale
  final List _shopItems = [
    // [ itemName, itenPrice, imagePath, color ]
    ["Medium Treasure box", "4.99", "assets/bbox.png", Colors.lightBlue],
    ["Big Treasure box", "9.99", "assets/mbox.png", Colors.yellow],
    // ["XXX Treasure box", "1.99", "assets/recommend.png", Colors.green],
    // ["XXX Treasure box", "2.99", "assets/orderagain.png", Colors.orange],
  ];

  //list of the cart items
  List _cartItems = [];

  get shopItems => _shopItems;

  get cartItems => _cartItems;


  //add item to cart
  void addItemToCart(int index){
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  //remove item from cart
  void removeItemToCart(int index){
    _cartItems.removeAt(index);
    notifyListeners();
  }

  //calculator tatol price
  String calculatorTotal(){
    double totalPrice = 0;
    for(int i=0; i<_cartItems.length; i++){
      totalPrice += double.parse(_cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }

  //cal servicetax
  String calculateServiceTax() {
    double totalPrice = double.parse(calculatorTotal());
    double serviceTax = totalPrice * 0.06; // 6% service tax
    return serviceTax.toStringAsFixed(2);
  }

  //cal govermenttax
  String calculateGovermentTax() {
    double totalPrice = double.parse(calculatorTotal());
    double govermentTax = totalPrice * 0.00; 
    return govermentTax.toStringAsFixed(2);
  }

  //cal voucher
  String calculateVoucher() {
    double totalPrice = double.parse(calculatorTotal());
    double vVoucher = totalPrice * 0.00; 
    return vVoucher.toStringAsFixed(2);
  }

  //total + tax
  String calculateTotalWithServiceTax() {
    double total = double.parse(calculatorTotal());
    double tax = double.parse(calculateServiceTax());
    double gtax = double.parse(calculateGovermentTax());
    double voucher = double.parse(calculateVoucher());
    double totalWithTax = total + tax + gtax - voucher;
    return totalWithTax.toStringAsFixed(2);
  }
}