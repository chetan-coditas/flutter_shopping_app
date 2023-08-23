import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/item_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoadingState()) {
    on<CartProductEvent>((event, emit) async {
      emit(CartLoadingState());
      try {
        //Todo: fetch or get item count array here
        emit(CartLoadedState(cartProducts));
      } catch (e) {
        emit(CartErrorState(e.toString()));
      }
    });

    on<UpdateCartBagdeCountEvent>((event, emit) async {
      Iterable<ProductItem> filteredProducts = event.products.where((item) {
        return item.itemCount > 0;
      });

      emit(UpdateCartBagdeCountState(
          filteredProducts.toList(), filteredProducts.length.toString()));
    });

    on<BuyCartItemEvent>((event, emit) async {
      cartProducts = [];
      emit(CartLoadedState(cartProducts));
    });
  }
}
