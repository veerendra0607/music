
import 'package:http/http.dart' as http;

import '../models/allProducts.dart';
import '../models/productDetailsByID.dart';
import 'apiurl.dart';

class ApiService{

  static var client= http.Client();

  static Future<AllProducts?> getUserList() async{
    var response =await client.get(Uri.parse(ApiUrl().getAllProducts));
    if(response.statusCode==200){
      print(response.body);
      var jsonString =response.body;
      return allProductsFromJson(jsonString);
    }
    else{
      print("null");
    }
    return null;
  }

  static Future<ProductsById?> getProductCategoryList() async{
    var response =await client.get(Uri.parse(ApiUrl().getProductDetailsId));
    if(response.statusCode==200){
      print(response.body);
      var jsonString =response.body;
      return productsByIdFromJson(jsonString);
    }
    else{
      print("null");
    }
    return null;
  }
}