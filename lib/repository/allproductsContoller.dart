import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/allProducts.dart';
import 'allproductsApiCall.dart';


class UserListController extends GetxController{

  var isLoading =true.obs;
  var  userList=<Product>[].obs;
  var  user=AllProducts().obs;


  @override
  void onInit() {
    // TODO: implement onInit
    fetchUsersList();
    super.onInit();
  }

  void fetchUsersList(){
    Timer(Duration(seconds:5),(){
      ApiService.getUserList().then((allProducts)
      {
        user.value=allProducts!;
        userList.value=allProducts.products!;

      });
      isLoading(false);
    });

  }

}