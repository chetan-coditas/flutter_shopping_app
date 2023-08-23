import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_app_with_bloc/presentation/bloc/product_bloc.dart';
import 'package:flutter_shopping_app_with_bloc/presentation/bloc/product_event.dart';

import 'bloc/cart_bloc.dart';
import 'bloc/cart_event.dart';
import 'bloc/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider<ProductBloc>(
    //         create: (BuildContext context) => ProductBloc(ProductRepository())),
    //     BlocProvider<CartBloc>(create: (BuildContext context) => CartBloc())
    //   ],
    //   child:
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        foregroundColor: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 232, 227, 227),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            context.read<CartBloc>().add(CartProductEvent());
            return const Center(child: Text('Loading...'));
          } else if (state is CartLoadedState) {
            if (state.products.isEmpty) {
              return const Center(child: Text('No item in your cart!'));
            } else {
              return Container(
                color: const Color.fromARGB(255, 232, 227, 227),
                child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    if (index == state.products.length) {
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          // ignore: prefer_const_constructors
                          context.read<ProductBloc>().add(
                              const LoadProductEvent(
                                  'https://fakestoreapi.com/products'));
                          context.read<CartBloc>().add(BuyCartItemEvent());
                        },
                        child: const Text('Buy'),
                      );
                    }

                    String? title =
                        state.products[index].title.substring(0, 18);
                    String? image = state.products[index].image;
                    String? description =
                        state.products[index].description.substring(0, 20);
                    String? price =
                        '\$ ${state.products[index].price.toString()}';
                    return Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Colors.white),
                      // height: 160,
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            child: Image.network(
                              image,
                              height: 60,
                              width: 60,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                description,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                price,
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 10.0,
                  ),
                  itemCount: state.products.length + 1,
                ),
              );
            }
          } else {
            return const Center(child: Text('Failed'));
          }
        },
      ),
    );
    //);
  }
}
