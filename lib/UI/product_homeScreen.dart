
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../repository/allproductsContoller.dart';

class ProductHomeScreen extends StatefulWidget {
  const ProductHomeScreen({Key? key}) : super(key: key);

  @override
  State<ProductHomeScreen> createState() => _ProductHomeScreenState();
}

class _ProductHomeScreenState extends State<ProductHomeScreen> {
  final UserListController userListController = Get.put(UserListController());
Rx<List<Map<String,dynamic>>> foundallData=Rx<List<Map<String,dynamic>>>([]);
void onInit(){
  // super.onInit();
  foundallData=userListController.userList.value as Rx<List<Map<String, dynamic>>>;
}
void onClose(){
  void filterList(String titel){
    List<Map<String,dynamic>> result=[];
    if(titel.isEmpty){
      result=userListController.userList.value.cast<Map<String, dynamic>>() ;
    }
    else{
      result=userListController.userList.where((element) => element.toString().toLowerCase().contains(titel.toLowerCase())).cast<Map<String, dynamic>>().toList();
    }
    foundallData.value=result;
  }
}

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userListController.user.value.products == null)
        return Center(child: CircularProgressIndicator(),);
      else {
        return ListView.builder(
            itemCount: userListController.userList.length,
            itemBuilder: (context, index) {
              print("+++++++");
              print(userListController.userList.length);
              print(userListController.user.value.products![index].title
                  .toString());
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    // filterSearchResults(value);
                    userListController.user.value.products![index]
                        .title;
                  },
                  // controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              );
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
                              userListController.userList[index].thumbnail
                                  .toString(),
                              width: 150,
                              height: 100,
                              fit: BoxFit.fill,
                            ),

                          ),
                        ),
                        SizedBox(width: 30,),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Expanded(child: Text(
                                userListController.user.value.products![index]
                                    .title.toString(),
                                style: TextStyle(color: Colors.black87),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,)),
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                userListController.user.value.products![index]
                                    .brand.toString(),
                                style: TextStyle(color: Colors.black87),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ],
                ),
              );
            }
        );
      }
    });
  }

}


