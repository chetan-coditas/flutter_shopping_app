import 'package:flutter/material.dart';
import 'package:flutter_shopping_app_with_bloc/data/item_model.dart';

@immutable
abstract class ProductState {}

class ProductLoadingState extends ProductState {
  List<Object?> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<ProductItem> products;
  ProductLoadedState(this.products);
}

class ProductErrorState extends ProductState {
  final String error;
  ProductErrorState(this.error);
}
