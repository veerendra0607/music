import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/productDetailsByID.dart';
import 'allproductsApiCall.dart';


class ProductCategoryListController extends GetxController{

  var isLoading =true.obs;
  var  userList=<dynamic>[].obs;
  var  user=ProductsById().obs;


  @override
  void onInit() {
    // TODO: implement onInit
    fetchUsersList();
    super.onInit();
  }

  void fetchUsersList(){
    Timer(Duration(seconds:5),(){
      ApiService.getProductCategoryList().then((productsById)
      {
        user.value=productsById!;
        userList.value=productsById.images!;

      });
      isLoading(false);
    });

  }

}