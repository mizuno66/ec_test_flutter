import 'package:ec_test/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:ec_test/models/products.dart';
import 'package:ec_test/repository/products_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cartProvider = StateNotifierProvider<Cart, Map<int, int>>((ref) {
  return Cart();
});

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final cart = ref.watch(cartProvider);

    return FutureBuilder
    (
      future: ProductRepository().fetch(),
      builder: (context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
        {
          return const Center(child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ));
        }
        if(snapshot.hasError){
          return const Text("エラー");
        }
        if (!snapshot.hasData){
          return const Text("データなし");
        }

        return (GridView.count
        (
          crossAxisCount: 3,
          children: List.generate(snapshot.data!.length, (int i) => Container
          (
            alignment: Alignment.center,
            child: Column
            (
              children: <Widget> [
                Text(snapshot.data![i].getName()),
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: FloatingActionButton(
                        onPressed: () => ref.read(cartProvider.notifier).remove(snapshot.data![i].id),
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    Text((cart[snapshot.data![i].id] ?? 0).toString()),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: FloatingActionButton(
                        onPressed: () => ref.read(cartProvider.notifier).add(snapshot.data![i].id),
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ]
                )
              ],
            )
          ))
        ));
      }
    );
  }
}
