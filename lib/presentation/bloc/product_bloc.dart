import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_app_with_bloc/domain/repository/product_repo.dart';
import 'package:flutter_shopping_app_with_bloc/presentation/bloc/product_event.dart';
import 'package:flutter_shopping_app_with_bloc/presentation/bloc/product_state.dart';
import '../../data/item_model.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc(this._productRepository) : super(ProductLoadingState()) {
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final products = await _productRepository.getAllProductData();
        emit(ProductLoadedState(products));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });

    on<AddProductItemCountEvent>((event, emit) async {
      ProductItem selectedProduct = event.products[event.index];
      int updatedItemCount = selectedProduct.itemCount + 1;
      event.products[event.index].itemCount = updatedItemCount;
      emit(ProductLoadedState(event.products));
    });

    on<RemoveProductItemCountEvent>((event, emit) async {
      ProductItem selectedProduct = event.products[event.index];
      if (selectedProduct.itemCount > 0) {
        int updatedItemCount = selectedProduct.itemCount - 1;
        event.products[event.index].itemCount = updatedItemCount;
        emit(ProductLoadedState(event.products));
      }
    });
  }
}
