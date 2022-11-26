import 'product_model.dart';

class ProductData {
 static List<ProductModel> items = [
    ProductModel(name: "Shoes", expression: "42 size", isChecked: true),
    ProductModel(name: "Coat", expression: "XXL", isChecked: true),
    ProductModel(name: "Trousers", expression: "medium", isChecked: false),
    ProductModel(name: "Cup", expression: "small", isChecked: false),
  ];
}
