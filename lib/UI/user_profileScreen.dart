import 'package:flutter/material.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({Key? key}) : super(key: key);

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {

  final List<String> entries = [
  "smartphones",
  "laptops",
  "fragrances",
  "skincare",
  "groceries",
  "home-decoration",
  "furniture",
  "tops",
  "womens-dresses",
  "womens-shoes",
  "mens-shirts",
  "mens-shoes",
  "mens-watches",
  "womens-watches",
  "womens-bags",
  "womens-jewellery",
  "sunglasses",
  "automotive",
  "motorcycle",
  "lighting"
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: entries.length,
        itemBuilder: (BuildContext ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15)),
              child: Text('${entries[index]}',style: TextStyle(color: Colors.black87),),
            ),
          );
        }
        );
    //   ListView.builder(
    //     padding: const EdgeInsets.all(8),
    //     itemCount: entries.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Container(
    //         height: 50,
    //         width: 40,
    //         child: Center(child: Text('${entries[index]}',style: TextStyle(color: Colors.black87),)),
    //       );
    //     }
    // );
  }
}
