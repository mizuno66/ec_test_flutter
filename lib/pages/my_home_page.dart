import 'package:flutter/material.dart';
import 'package:hello_world/models/products.dart';
import 'package:hello_world/repository/products_repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<Product, int> count = {};

  @override
  Widget build(BuildContext context){
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
                        onPressed: () => setState(() {
                          if ((count[snapshot.data![i]] ?? 0) == 0) return;
                          count[snapshot.data![i]] =(count[snapshot.data![i]] ?? 0) - 1;
                        }),
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    Text(count[snapshot.data![i]]?.toString() ?? '0'),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: FloatingActionButton(
                        onPressed: () => setState(() {
                          if (count[snapshot.data![i]] == null) count[snapshot.data![i]] = 0;
                          count[snapshot.data![i]] =(count[snapshot.data![i]] ?? 0) + 1;
                        }),
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
