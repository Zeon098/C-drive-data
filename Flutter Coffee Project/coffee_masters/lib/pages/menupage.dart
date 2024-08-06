import 'package:coffee_masters/datamanager.dart';
import 'package:coffee_masters/datamodel.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final DataManager dataManager;
  const MenuPage({super.key, required this.dataManager});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dataManager.getMenu(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            var categories = snapshot.data! as List<Category>;
            return ListView.builder(
                itemCount: categories.length,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(categories[index].name),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: categories[index].products.length,
                          itemBuilder: (context, prodIndex) {
                            var product = categories[index].products[prodIndex];
                            return ProductItem(
                                product: product,
                                onAdd: (addedProduct) {
                                 return dataManager.cartAdd(addedProduct);
                                });
                          })
                    ],
                  );
                }));
          } else if (snapshot.hasError) {
            return const Text("There was an error!");
          } else {
            return const CircularProgressIndicator();
          }
        }));
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final Function onAdd;
  const ProductItem({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(product.imageUrl,
            fit: BoxFit.cover,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("\$${product.price.toStringAsFixed(2)}"),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      onAdd(product);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColor),
                    ),
                    child: const Text("Add",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
