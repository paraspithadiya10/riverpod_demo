import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/provider/cart_provider.dart';
import 'package:riverpod_demo/provider/product_provider.dart';
import 'package:riverpod_demo/shared/cart_icon.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProducts = ref.watch(productsProvider);
    final cartProducts = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Sale Products'),
        actions: const [CartIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: allProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 204, 231, 244),
              ),
              child: Column(
                children: [
                  Image.asset(allProducts[index].image, height: 60, width: 60),
                  const SizedBox(width: 10),
                  Text(allProducts[index].title),
                  SizedBox(height: 20),
                  Text('₹ ${allProducts[index].price}'),
                  SizedBox(height: 12),
                  if (cartProducts.contains(allProducts[index]))
                    SizedBox(
                        height: 20,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(cartNotifierProvider.notifier)
                                  .removeProduct(allProducts[index]);
                            },
                            child: Text('Remove'))),
                  if (!cartProducts.contains(allProducts[index]))
                    SizedBox(
                        height: 20,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(cartNotifierProvider.notifier)
                                  .addProduct(allProducts[index]);
                            },
                            child: Text('Add')))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
