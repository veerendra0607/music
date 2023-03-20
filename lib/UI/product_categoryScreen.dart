import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../repository/productcategoryContoller.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({Key? key}) : super(key: key);

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  final ProductCategoryListController userListController1=Get.put(ProductCategoryListController());
  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(userListController1.user.value.id==null)
        return Center(child: CircularProgressIndicator(),);
      else {
        return ListView.builder(
            itemCount: userListController1.userList.length,
            itemBuilder: (context,index)
            {
              print("+++++++");
              print( userListController1.userList.length);
              print( userListController1.user.value.images![index].toString());
              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.fromLTRB(16, 8, 8, 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:
                            Image.network(
                              userListController1.user.value.images![index].toString(),
                              width: 150,
                              height: 100,
                              fit: BoxFit.fill,
                            ),

                          ),
                        ),
                        SizedBox(width: 10,),

                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Expanded(child: Text(userListController1.user.value.brand.toString(),
                                style: TextStyle(color: Colors.black87),overflow: TextOverflow.ellipsis,maxLines: 2,)),
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(userListController1.user.value.title.toString(),
                                style: TextStyle(color: Colors.black87),overflow: TextOverflow.ellipsis,maxLines: 1,),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(userListController1.user.value.description.toString(),
                          style: TextStyle(color: Colors.black87),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,maxLines: 3,),
                      ],
                    ),
                    Row(
                      children: [
                        Text(userListController1.user.value.category.toString(),
                          style: TextStyle(color: Colors.black87),overflow: TextOverflow.ellipsis,maxLines: 2,)
                      ],
                    ),
                    Row(
                      children: [
                        Text("Discount : "+userListController1.user.value.discountPercentage!.toString()+"%",
                          style: TextStyle(color: Colors.black87),overflow: TextOverflow.ellipsis,maxLines: 2,),
                        SizedBox(width: 20,),
                        Text("Rating : "+userListController1.user.value.rating!.toString(),
                          style: TextStyle(color: Colors.black87),overflow: TextOverflow.ellipsis,maxLines: 2,)
                      ],
                    ),
                    Row(children: [
                      Text("Price :",
                        style: TextStyle(color: Colors.black87),overflow: TextOverflow.ellipsis,maxLines: 1,),
                      Text(userListController1.user.value.price!.toString(),
                        style: TextStyle(color: Colors.black87),overflow: TextOverflow.ellipsis,maxLines: 1,),
                    ],),
                    Row(children: [
                      Text("Stock :"+ userListController1.user.value.stock!.toString(),
                        style: TextStyle(color: Colors.black87),overflow: TextOverflow.ellipsis,maxLines: 1,),
                      Text(userListController1.user.value.id!.toString(),
                        style: TextStyle(color: Colors.black87),overflow: TextOverflow.ellipsis,maxLines: 1,),
                    ],),
                  ],
                ),
              );

            }
        );
      }
    });
  }
}
