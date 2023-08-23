import 'package:flutter/cupertino.dart';
import '../../data/item_model.dart';

@immutable
abstract class CartState {}

class CartLoadingState extends CartState {
  List<Object?> get props => [];
}

class CartLoadedState extends CartState {
  final List<ProductItem> products;
  CartLoadedState(this.products);
}

class CartErrorState extends CartState {
  final String error;
  CartErrorState(this.error);
}

class UpdateCartBagdeCountState extends CartState {
  final String badgeCount;
  final List<ProductItem> products;
  UpdateCartBagdeCountState(this.products, this.badgeCount);
}
