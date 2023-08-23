import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_app_with_bloc/presentation/bloc/cart_bloc.dart';
import 'package:flutter_shopping_app_with_bloc/presentation/bloc/cart_event.dart';
import 'package:flutter_shopping_app_with_bloc/presentation/bloc/product_bloc.dart';
import 'package:flutter_shopping_app_with_bloc/presentation/bloc/product_event.dart';
import 'package:flutter_shopping_app_with_bloc/presentation/bloc/product_state.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 232, 227, 227),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            context.read<ProductBloc>().add(
                const LoadProductEvent('https://fakestoreapi.com/products'));
            return const Center(child: Text('Loading...'));
          } else if (state is ProductLoadedState) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Mens Clothings",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    height: MediaQuery.of(context).size.height - 150,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        String? title =
                            state.products[index].title.substring(0, 18);
                        String? image = state.products[index].image;
                        String? description =
                            state.products[index].description.substring(0, 20);
                        String? price =
                            '\$ ${state.products[index].price.toString()}';
                        String? itemCountValue =
                            state.products[index].itemCount.toString();

                        return Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Colors.white),
                          // height: 160,
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.network(
                                  image,
                                  height: 80,
                                  width: 80,
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
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blue),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                        ),
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                              UpdateCartBagdeCountEvent(
                                                  state.products));
                                        },
                                        child: const Text('Add'),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: IconButton(
                                            onPressed: () {
                                              context.read<ProductBloc>().add(
                                                  RemoveProductItemCountEvent(
                                                      index, state.products));
                                            },
                                            icon: const Icon(
                                              Icons.remove_circle_outline_sharp,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        child: Text(
                                          itemCountValue,
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        //),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 1),
                                          child: IconButton(
                                            onPressed: () {
                                              context.read<ProductBloc>().add(
                                                  AddProductItemCountEvent(
                                                      index, state.products));
                                            },
                                            icon: const Icon(
                                              Icons.add_circle_outline_sharp,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 20.0,
                      ),
                      itemCount: state.products.length,
                    ),
                  )
                ]);
          } else {
            return const Center(child: Text('Error in loading products!'));
          }
        },
      ),
    );
  }
}
