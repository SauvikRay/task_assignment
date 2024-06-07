import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../data/models/product_response.dart';

class ProductController extends GetxController{
  RxList<Product> productList=<Product>[].obs;
// ProductResponse productResponse=ProductResponse();


  sortProductList(String sort){
    
    if(sort=='price low to heigh'){
     productList.sort((a, b) => a.price!.compareTo(b.price??0.0));
    }
  }

  getResponse( )async{

  ProductResponse  productResponse= await parseJson(await loadJsonFromFile());
  productList.value=productResponse.product??[];
    log('${productList.first.name}');
  }

Future<String>  loadJsonFromFile()async{
final myjson = await rootBundle.loadString('assets/response.json');

return myjson;
  }


// // This is the entry point for the isolate
// Future<ProductResponse> parseJsonInIsolate(String jsonString) async {
//   final responseJson = jsonDecode(jsonString);
//   return ProductResponse.fromJson(responseJson);
// }

// Future<ProductResponse> parseJson(String jsonString) async {
//   // Create a ReceivePort to receive messages from the isolate
//   final responsePort = ReceivePort();

//   // Spawn an isolate
//   await Isolate.spawn(
//     _isolateEntry,
//     _IsolateParams(jsonString, responsePort.sendPort),
//   );

//   // Get the parsed data from the isolate
//   final result = await responsePort.first as ProductResponse;
//   return result;
// }

// void _isolateEntry(_IsolateParams params) async {
//   final productResponse = await parseJsonInIsolate(params.jsonString);
//   // Send the parsed data back to the main thread
//   params.sendPort.send(productResponse);
// }



}

class _IsolateParams {
  final String jsonString;
  final SendPort sendPort;

  _IsolateParams(this.jsonString, this.sendPort);
}