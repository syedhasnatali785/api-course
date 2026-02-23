import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Model/products_model.dart';

class ExampleFive extends StatelessWidget {
  ExampleFive({super.key});
  Future<ProductsModel> getProductsApi() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProductsModel>(
        future: getProductsApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //main products
            return ListView.builder(
              itemCount: snapshot.data!.products!.length,
              itemBuilder: (context, productslist) {
                final product = snapshot.data!.products![productslist];
                return InkWell(
                  onTap: (){},
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(15),
                  
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200,
                            child: PageView.builder(
                              itemCount: product.images!.length,
                              itemBuilder: (context, imageslist) {
                                return Image.network(product.images![imageslist], fit: BoxFit.cover,);
                              },
                            ),
                          ),
                  
                          Text(product.title!, style: TextStyle(fontSize: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Rs.${product.price.toString()}",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green.withValues(alpha: 5),
                                ),
                                child: Text(
                                  product.tags!.first,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Column(children: [Text("Loading...")]);
          }
        },
      ),
    );
  }
}
