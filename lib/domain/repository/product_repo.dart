import 'package:dio/dio.dart';
// import 'package:flutter_shopping_app_with_bloc/data/database_repository.dart';

// import '../../data/database_repository.dart';
import '../../data/item_model.dart';

abstract class IProductRepository {
  Future<List<ProductItem>> getAllProductData();
}

class ProductRepository extends IProductRepository {
  @override
  Future<List<ProductItem>> getAllProductData() async {
    // Make a GET request to the API
    Dio dio = Dio();
    Response response = await dio.get("https://fakestoreapi.com/products");

    List<ProductItem> products = List<ProductItem>.from(
        response.data.map((x) => ProductItem.fromJson(x)));

    // for (var item in products) {
    //   await DatabaseRepository.instance.insert(todo: item);
    // }

    // Future<List<ProductItem>> savedProducts =
    //     DatabaseRepository.instance.getAllProducts();

    // print(DatabaseRepository.instance.getAllProducts());

    // print(savedProducts);

    return products;
  }
}
