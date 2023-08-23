import 'package:flutter/cupertino.dart';
import '../../data/item_model.dart';

@immutable
abstract class CartEvent {
  const CartEvent();
}

class CartProductEvent extends CartEvent {}

class UpdateCartBagdeCountEvent extends CartEvent {
  final List<ProductItem> products;
  const UpdateCartBagdeCountEvent(this.products);
}

class BuyCartItemEvent extends CartEvent {}
