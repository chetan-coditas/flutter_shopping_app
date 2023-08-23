import 'package:flutter/material.dart';

import '../../data/item_model.dart';

@immutable
abstract class ProductEvent {
  const ProductEvent();
}

class LoadProductEvent extends ProductEvent {
  final String apiName;
  const LoadProductEvent(this.apiName);
}

class AddCartItemEvent extends ProductEvent {}

class AddProductItemCountEvent extends ProductEvent {
  final int index;
  final List<ProductItem> products;

  const AddProductItemCountEvent(this.index, this.products);
}

class RemoveProductItemCountEvent extends ProductEvent {
  final int index;
  final List<ProductItem> products;

  const RemoveProductItemCountEvent(this.index, this.products);
}
