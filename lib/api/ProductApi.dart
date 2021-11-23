import 'dart:async';

import 'package:ecommerce/Helper.dart';
import 'package:ecommerce/Models/ProductModel.dart';

class ProductApi{

  StreamController<requestResponseState> productController = StreamController.broadcast();

  dispose(){
    productController.close();
  }

  getProducts() async {
    try{

      if(productList != null && productList.length != 0){
        addStreamEvent(requestResponseState.Success, productController);
        return;
      }

      productList = [];
      var res = await getRequest('https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline');

      if(res == null){
        addStreamEvent(requestResponseState.Error, productController);
        return;
      }

      var data = (res).map((i) => ProductModel.fromJson(i)).toList();
      productList = data;

      if(productList == null || productList.length == 0){
        productList = [];
        addStreamEvent(requestResponseState.Error, productController);
        return;
      }
      addStreamEvent(requestResponseState.Success, productController);

    }catch(e){
      print(e);
      productList = [];
      addStreamEvent(requestResponseState.Error, productController);
    }
  }
}