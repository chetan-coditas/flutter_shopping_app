import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_app_with_bloc/presentation/bloc/cart_bloc.dart';
import 'package:flutter_shopping_app_with_bloc/presentation/bloc/cart_event.dart';
import 'package:flutter_shopping_app_with_bloc/presentation/bloc/cart_state.dart';
import '../data/database_repository.dart';
import '../data/item_model.dart';
import 'cart_page.dart';
import 'market_page.dart';
import 'order_page.dart';

class MarketHomePage extends StatefulWidget {
  const MarketHomePage({super.key});

  @override
  State<MarketHomePage> createState() => _MarketHomePageState();
}

class _MarketHomePageState extends State<MarketHomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    initDb();
    super.initState();
  }

  void initDb() async {
    await DatabaseRepository.instance.database;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: constant_identifier_names
    const IconData shopping_cart =
        IconData(0xe59c, fontFamily: 'MaterialIcons');
    String badgeCountValue = '0';

    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider<ProductBloc>(
    //         create: (BuildContext context) => ProductBloc(ProductRepository())),
    //     BlocProvider<CartBloc>(create: (BuildContext context) => CartBloc())
    //   ],
    //   child:

    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is UpdateCartBagdeCountState) {
                badgeCountValue = state.badgeCount;
                cartProducts = state.products;
              }

              if (cartProducts.isEmpty) {
                badgeCountValue = '0';
              }
              return Badge(
                alignment: Alignment.topLeft,
                label: Text(
                  badgeCountValue,
                ),
                child: IconButton(
                    onPressed: () {
                      context.read<CartBloc>().add(CartProductEvent());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartPage()),
                      );
                    },
                    icon: const Icon(shopping_cart)),
              );
            },
          ),
        ],
        centerTitle: true,
        foregroundColor: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 232, 227, 227),
      ),
      body: const MarketPage(),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Market Categories'),
            ),
            ListTile(
              title: const Text('Mens clothing'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Womens clothing'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Jewelery'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                Navigator.pop(context);
                // Then close the drawer
              },
            ),
            ListTile(
              title: const Text('electronics'),
              selected: _selectedIndex == 3,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
                Navigator.pop(context);
                // Then close the drawer
              },
            ),
            ListTile(
              title: const Text('Cart'),
              selected: _selectedIndex == 4,
              onTap: () {
                // Update the state of the app
                _onItemTapped(4);
                // Then close the drawer
              },
            ),
            ListTile(
              title: const Text('Order'),
              selected: _selectedIndex == 5,
              onTap: () {
                // Update the state of the app
                _onItemTapped(5);
                // Then close the drawer
              },
            ),
          ],
        ),
      ),
    );
    //  );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
        case 4:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartPage()));
          break;
        case 5:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const OrderPage()));
          break;
      }
    });
  }
}
