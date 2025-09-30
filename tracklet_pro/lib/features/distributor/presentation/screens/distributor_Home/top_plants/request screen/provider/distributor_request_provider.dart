import 'package:flutter/material.dart';

class DistributorRequestProvider extends ChangeNotifier {
  final double perKgPrice = 250;
  final List<double> cylinderWeights = [45.4, 27.5, 15.0, 11.8];

  final Map<double, int> quantities = {45.4: 0, 27.5: 0, 15.0: 0, 11.8: 0};

  int discount = 0;

  void increaseQty(double weight) {
    quantities[weight] = (quantities[weight] ?? 0) + 1;
    notifyListeners();
  }

  void decreaseQty(double weight) {
    if ((quantities[weight] ?? 0) > 0) {
      quantities[weight] = (quantities[weight] ?? 0) - 1;
      notifyListeners();
    }
  }

  int get totalKg {
    int total = 0;
    quantities.forEach((weight, qty) {
      total += (weight * qty).toInt();
    });
    return total;
  }

  double get totalPrice {
    double price = totalKg * (perKgPrice - discount);
    return price;
  }

  String? _pressedButton; // Track which button is pressed

  void setPressedButton(String buttonId) {
    _pressedButton = buttonId;
    notifyListeners();
  }

  void clearPressedButton() {
    _pressedButton = null;
    notifyListeners();
  }

  bool isButtonPressed(String buttonId) {
    return _pressedButton == buttonId;
  }

  void setDiscount(int value) {
    discount = value;
    notifyListeners();
  }
}
