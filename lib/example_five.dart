import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Model/products_model.dart';
class ExampleFive extends StatelessWidget {
  const ExampleFive({super.key});
Future<ProductsModel> getProductsApi ()async{
  final response = http.get(Uri.parse('https://webhook.site/a5883001-a088-4efe-8fc1-73c29e6f7f54'));

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(future: future, builder: builder),);

  }
}
