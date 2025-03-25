import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_demo/models/product.dart';
part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Set<Product> build() {
    return {}; // Initialize an empty Set to store unique products
  }

  // Method to add a product to cart
  void addProduct(Product product) {
    if (!state.contains(product)) {
      // Check if product doesn't exist in cart
      state = {
        ...state,
        product
      }; // Add product using spread operator to create new Set
    }
  }

  // Method to remove a product from cart
  void removeProduct(Product product) {
    if (state.contains(product)) {
      // Check if product exists in cart
      state = state
          .where((p) => p.id != product.id)
          .toSet(); // Remove product by filtering
    }
  }
}

// Another provider to calculate total cart value
@riverpod
int cartTotal(ref) {
  final cartProducts = ref.watch(cartNotifierProvider);

  int total = 0;

  // Calculate total by summing up all product prices
  for (Product product in cartProducts) {
    total += product.price;
  }

  return total;
}
