import 'package:construction_app/models/add-sites_model.dart';
import 'package:construction_app/models/add_site_body.dart';
import 'package:construction_app/models/create_user_body.dart';
import 'package:construction_app/models/create_user_model.dart';
import 'package:construction_app/models/error_response_model.dart';
import 'package:construction_app/models/get_supervisor_model.dart';
import 'package:construction_app/models/login_model.dart';
import 'package:construction_app/services/base_client.dart';
import 'package:flutter/foundation.dart';
import 'package:async/async.dart';


class ServiceConfig {
  Future<Result> login({String? email, String? password}) async {
    Map<String, dynamic> body = {
      'email': email ?? '',
      'password': password ?? ''
    };

    Result res = await BaseClient.post('login', body: body);
    if (res.isError) {
      ErrorResponseModel errorResponseModel =
          ErrorResponseModel(errorMessage: 'OOps...!, login failed');
      return Result.error(errorResponseModel);
    } else {
      var response = res.asValue!.value;
      debugPrint('login response $response');
      LoginModel loginResponseModel =
          LoginModel.fromJson(response);
      return (loginResponseModel.status)
          ? Result.value(loginResponseModel)
          : Result.error(loginResponseModel);
    }
  }


  Future<Result> createUser(CreateUserBody createUserBody) async {
  try {
    Result res = await BaseClient.post(
      'create-user',
      body: createUserBody.toJson(),
    );

    if (res.isError) {
      return Result.error(res.asError!.error);
    }

    var response = res.asValue!.value;
    debugPrint('create user response $response');

    CreateUserModel createUserModel =
        CreateUserModel.fromJson(response);

    return (createUserModel.status)
        ? Result.value(createUserModel)
        : Result.error(createUserModel.message);
  } catch (e) {
    return Result.error(
        ErrorResponseModel(errorMessage: e.toString()));
  }
}


Future<Result> getSupervisors() async{
  Result res = await BaseClient.get("supervisors");
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "Oops...!, Something went wrong");
    return Result.error(errorResponseModel);
    
  }else{
    var response = res.asValue!.value;
    debugPrint("Get Supervisors : $response");
    GetSupervisorsModel getSupervisorsModel = GetSupervisorsModel.fromJson(response);
    return (getSupervisorsModel.status)
    ? Result.value(getSupervisorsModel)
    : Result.error(getSupervisorsModel);
  }
}

Future<Result> addSite(AddSitesBody addSiteBody)async{
  Result res = await BaseClient.post("add-sites",body: addSiteBody.toJson());
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "Oops...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Add Site : $response");
    AddSitesModel addSitesModel = AddSitesModel.fromJson(response);
    return (addSitesModel.status)
    ? Result.value(addSitesModel)
    : Result.error(addSitesModel);
  }
}


//   Future<Result> getDeities() async {
//     Result res = await BaseClient.get('deities');
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('deities response $response');
//       DeitiesResponse deitiesResponse = DeitiesResponse.fromJson(response);
//       return (deitiesResponse.status ?? false)
//           ? Result.value(deitiesResponse)
//           : Result.error(deitiesResponse);
//     }
//   }


//     Future<Result> getAllProduct() async {
//     Result res = await BaseClient.post('invproducts_all');
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('deities response $response');
//       GetAllProduct getAllProduct = GetAllProduct.fromJson(response);
//       return (getAllProduct.status ?? false)
//           ? Result.value(getAllProduct)
//           : Result.error(getAllProduct);
//     }
//   }



//   //  Future<Result> getProduct() async {
//   //   Result res = await BaseClient.post('invproducts');
//   //   if (res.isError) {
//   //     ErrorResponseModel errorResponseModel =
//   //         ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//   //     return Result.error(errorResponseModel);
//   //   } else {
//   //     var response = res.asValue!.value;
//   //     debugPrint('product response $response');
//   //     ProductModel productModel = ProductModel.fromJson(response);
//   //     return (productModel.status ?? false)
//   //         ? Result.value(productModel)
//   //         : Result.error(productModel);
//   //   }
//   // }



//   Future<Result> getProduct({int? categoryId}) async {
//   Map<String, dynamic> body = {};

//   //  Add category_id if available
//   if (categoryId != null) {
//     body['cat_id'] = categoryId;
//   }


//   print("product category id $categoryId");

//   Result res = await BaseClient.post('invproducts', body: body);

//   if (res.isError) {
//     return Result.error(
//       ErrorResponseModel(errorMessage: 'Oops... Something went wrong'),
//     );
//   } else {
//     var response = res.asValue!.value;
//     debugPrint('product response $response');

//     ProductModel productModel = ProductModel.fromJson(response);

//     return (productModel.status ?? false)
//         ? Result.value(productModel)
//         : Result.error(productModel);
//   }
// }


//   Future<Result> getSupplier() async {
//     Result res = await BaseClient.get('suppliers');
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('supplier response $response');
//       SupplierModel supplierModel = SupplierModel.fromJson(response);
//       return (supplierModel.status ?? false)
//           ? Result.value(supplierModel)
//           : Result.error(supplierModel);
//     }
//   }



//   Future<Result> getUnit() async {
//     Result res = await BaseClient.get('units');
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('unit response $response');
//       UnitModel unitModel = UnitModel.fromJson(response);
//       return (unitModel.status ?? false)
//           ? Result.value(unitModel)
//           : Result.error(unitModel);
//     }
//   }

//   Future<Result> getCategory({int? categoryId}) async {
//   String url = 'cat';

//   if (categoryId != null) {
//     url = 'cat?category_id=$categoryId'; //  pass param here
//   }


// print("category id : $categoryId");
//   Result res = await BaseClient.get(url);

//   if (res.isError) {
//     return Result.error(
//       ErrorResponseModel(errorMessage: 'Oops... Something went wrong'),
//     );
//   } else {
//     var response = res.asValue!.value;
//     CategoryModel model = CategoryModel.fromJson(response);

//     return (model.status ?? false)
//         ? Result.value(model)
//         : Result.error(model);
//   }
// }


//      Future<Result> getPurchases() async {
//     Result res = await BaseClient.get('purchases');
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('category response $response');
//       ViewPurchaseModel purchaseModel = ViewPurchaseModel.fromJson(response);
//       return (purchaseModel.status ?? false)
//           ? Result.value(purchaseModel)
//           : Result.error(purchaseModel);
//     }
//   }

//     Future<Result> purchaseDetails(String id) async {
//     Result res =
//         await BaseClient.post('purchase-details', body: {'purchase_id': id});
//         print("purchase details id : ${id}");
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('purchase details response $response');
//       PurchaseDetailsModel purchaseDetailsModel = PurchaseDetailsModel.fromJson(response);

//       return (purchaseDetailsModel.status ?? false)
//           ? Result.value(purchaseDetailsModel)
//           : Result.error(purchaseDetailsModel);
//     }
//   }


//   Future<Result> viewProductStock(String productid) async {
//     Result res =
//         await BaseClient.post('viewproductstock', body: {'product_id': productid});
//         print("view product stock id : ${productid}");
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('view product stock response $response');
//         ViewProductStock viewProductStock = ViewProductStock.fromJson(response);

//       return (viewProductStock.status ?? false)
//           ? Result.value(viewProductStock)
//           : Result.error(viewProductStock);
//     }
//   }


// // Future<Result> getStockList() async {
// //   //  LOAD storeId first
// //   String storeId = await SharedPreferenceHelper.getStoreID();

// //   //  DEBUG — check what is actually being sent
// //   debugPrint('getStockList => storeId: "$storeId"');

// //   // API expects GET with JSON body: { "store_id": 1 }
// //   Result res = await BaseClient.getWithBody(
// //     'viewstock',
// //     body: {'store_id': int.tryParse(storeId) ?? 0},
// //   );

// //   if (res.isError) {
// //     ErrorResponseModel errorResponseModel =
// //         ErrorResponseModel(errorMessage: 'Oops...!, Something went wrong');
// //     return Result.error(errorResponseModel);
// //   } else {
// //     var response = res.asValue!.value;
// //     debugPrint('stock list response $response');

// //     ViewStockModel viewStockModel = ViewStockModel.fromJson(response);

// //     return (viewStockModel.status)
// //         ? Result.value(viewStockModel)
// //         : Result.error(viewStockModel);
// //   }
// // }



// // Future<Result> deletePurchaseDetails(String id) async {
// //   Result res = await BaseClient.delete(
// //     'delete-purchase-details?id=$id',
// //   );

// //   if (res.isError) {
// //     ErrorResponseModel errorResponseModel =
// //         ErrorResponseModel(errorMessage: 'Oops...! Something went wrong');
// //     return Result.error(errorResponseModel);
// //   } else {
// //     var response = res.asValue!.value;

// //     DeletePurchaseModel deleteModel =
// //         DeletePurchaseModel.fromJson(response);

// //     return (deleteModel.status ?? false)
// //         ? Result.value(deleteModel)
// //         : Result.error(deleteModel);
// //   }
// // }


// Future<Result> deletePurchaseDetails(String id, String productId) async {
//   Result res = await BaseClient.delete(
//     'delete-purchase-details?id=$id&product_id=$productId',
//   );
//   print("-------------------------productid : ${productId}-----------------");
//   print("-------------------------id : ${id}-----------------");
//   if (res.isError) {
//     return Result.error(
//       ErrorResponseModel(errorMessage: 'Oops...! Something went wrong'),
//     );
//   } else {
//     var response = res.asValue!.value;

//     DeletePurchaseModel deleteModel =
//         DeletePurchaseModel.fromJson(response);

//     return (deleteModel.status ?? false)
//         ? Result.value(deleteModel)
//         : Result.error(deleteModel);
//   }
// }

// Future<Result> getStockList({
//   String? fromDate,
//   String? toDate,
//   int? supplierId,
// }) async {
//   String storeId = await SharedPreferenceHelper.getStoreID();

//   debugPrint('getStockList => storeId: "$storeId"');

//   /// 🔹 BUILD BODY DYNAMICALLY
//   Map<String, dynamic> body = {
//     'store_id': int.tryParse(storeId) ?? 0,
//   };

//   if (fromDate != null) {
//     body['from_date'] = fromDate;
//   }

//   if (toDate != null) {
//     body['to_date'] = toDate;
//   }

//   if (supplierId != null) {
//     body['supplier_id'] = supplierId;
//   }

//   debugPrint('REQUEST BODY: $body');
//   print("view stock : ${body}");

//   Result res = await BaseClient.getWithBody(
//     'viewstock',
//     body: body,
//   );

//   if (res.isError) {
//     return Result.error(
//       ErrorResponseModel(errorMessage: 'Oops...!, Something went wrong'),
//     );
//   } else {
//     var response = res.asValue!.value;
//     debugPrint('stock list response $response');

//     ViewStockModel model = ViewStockModel.fromJson(response);

//     return (model.status)
//         ? Result.value(model)
//         : Result.error(model);
//   }
// }

// Future<Result> getStockCount() async {
//   //  LOAD storeId first
//   String storeId = await SharedPreferenceHelper.getStoreID();

//   //  DEBUG — check what is actually being sent
//   debugPrint('getStockList => storeId: "$storeId"');

//   // API expects GET with JSON body: { "store_id": 1 }
//   Result res = await BaseClient.getWithBody(
//     'viewstock',
//     body: {'store_id': int.tryParse(storeId) ?? 0},
//   );

//   if (res.isError) {
//     ErrorResponseModel errorResponseModel =
//         ErrorResponseModel(errorMessage: 'Oops...!, Something went wrong');
//     return Result.error(errorResponseModel);
//   } else {
//     var response = res.asValue!.value;
//     debugPrint('stock list response $response');

//     ViewStockModel viewStockModel = ViewStockModel.fromJson(response);

//     return (viewStockModel.status)
//         ? Result.value(viewStockModel)
//         : Result.error(viewStockModel);
//   }
// }


// Future<Result> getProductStock({
//   required String storeId,
//   required String productId,
// }) async {
//   debugPrint('getProductStock => storeId: $storeId, productId: $productId');

//   Result res = await BaseClient.getWithBody(
//     'viewproductstorestock',
//     body: {
//       'store_id': int.tryParse(storeId) ?? 0,
//       'product_id': int.tryParse(productId) ?? 0,
//     },
//   );

//   if (res.isError) {
//     return Result.error(
//       ErrorResponseModel(errorMessage: 'Failed to fetch stock'),
//     );
//   } else {
//     var response = res.asValue!.value;
//     debugPrint('product stock response $response');

//     ProductStoreModel model = ProductStoreModel.fromJson(response);

//     return model.status
//         ? Result.value(model)
//         : Result.error(model);
//   }
// }

//   Future<Result> saveStock(SaveStockBody saveStockBody) async {
//   if (kDebugMode) {
//     print("saveStock..............${saveStockBody.toJson()}");
//   }

//   Result res = await BaseClient.post(
//     'billing/stock', // make sure this matches your API route
//     body: saveStockBody.toJson(),
//   );

//   if (res.isError) {
//     ErrorResponseModel errorResponseModel =
//         ErrorResponseModel(errorMessage: 'Oops...! Something went wrong');
//     return Result.error(errorResponseModel);
//   } else {
//     var response = res.asValue!.value;

//     SaveStockModel saveStockResponse =
//         SaveStockModel.fromJson(response);

//     return (saveStockResponse.status)
//         ? Result.value(saveStockResponse)
//         : Result.error(saveStockResponse);
//   }
// }




//   Future<Result> saveProduct(SaveProductBody saveProductBody) async {
//   if (kDebugMode) {
//     print("add product..............${saveProductBody.toJson()}");
//   }

//   Result res = await BaseClient.post(
//     'addproduct', // make sure this matches your API route
//     body: saveProductBody.toJson(),
//   );

//   if (res.isError) {
//     ErrorResponseModel errorResponseModel =
//         ErrorResponseModel(errorMessage: 'Oops...! Something went wrong');
//     return Result.error(errorResponseModel);
//   } else {
//     var response = res.asValue!.value;

//     SaveProductModel saveProductResponse =
//         SaveProductModel.fromJson(response);

//     return (saveProductResponse.status)
//         ? Result.value(saveProductResponse)
//         : Result.error(saveProductResponse);
//   }
// }


//   Future<Result> addCat(SaveCatBody saveCatBody) async {
//   if (kDebugMode) {
//     print("add CAT..............${saveCatBody.toJson()}");
//   }

//   Result res = await BaseClient.post(
//     'addcat', // make sure this matches your API route
//     body: saveCatBody.toJson(),
//   );

//   if (res.isError) {
//     ErrorResponseModel errorResponseModel =
//         ErrorResponseModel(errorMessage: 'Oops...! Something went wrong');
//     return Result.error(errorResponseModel);
//   } else {
//     var response = res.asValue!.value;

//     AddCatModel addCatResponse =
//         AddCatModel.fromJson(response);

//     return (addCatResponse.status)
//         ? Result.value(addCatResponse)
//         : Result.error(addCatResponse);
//   }
// }


 
//   Future<Result> getStarts() async {
//     Result res = await BaseClient.get('stars');
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('stars response $response');
//       StarsResponse starsResponse = StarsResponse.fromJson(response);
//       return (starsResponse.status ?? false)
//           ? Result.value(starsResponse)
//           : Result.error(starsResponse);
//     }
//   }

//   Future<Result> getgothra() async {
//     Result res = await BaseClient.post('gothra');
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('gothra response $response');
//       GothraDatamodel gothraResponse = GothraDatamodel.fromJson(response);
//       return (gothraResponse.status ?? false)
//           ? Result.value(gothraResponse)
//           : Result.error(gothraResponse);
//     }
//   }

//   Future<Result> getrashi() async {
//     Result res = await BaseClient.post('rashi');
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('gothra response $response');
//       RashiDatamodel rashiResponse = RashiDatamodel.fromJson(response);
//       return (rashiResponse.status ?? false)
//           ? Result.value(rashiResponse)
//           : Result.error(rashiResponse);
//     }
//   }

//   Future<Result> getSpecialStars() async {
//     Result res = await BaseClient.get('special-stars');
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('special star response $response');
//       SpecialStarResponse specialStarResponse =
//           SpecialStarResponse.fromJson(response);
//       return (specialStarResponse.status ?? false)
//           ? Result.value(specialStarResponse)
//           : Result.error(specialStarResponse);
//     }
//   }

//   Future<Result> getPoojas(String deityId) async {
//     Result res =
//         await BaseClient.post('deity/poojas', body: {'deity': deityId});
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('pooja response $response');
//       PoojaResponse poojaResponse = PoojaResponse.fromJson(response);

//       return (poojaResponse.status ?? false)
//           ? Result.value(poojaResponse)
//           : Result.error(poojaResponse);
//     }
//   }

//   Future<Result> getCounters() async {
//     Result res = await BaseClient.post('counters');
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('counters response $response');
//       CounterModel counterResponse = CounterModel.fromJson(response);
//       return (counterResponse.status ?? false)
//           ? Result.value(counterResponse)
//           : Result.error(counterResponse);
//     }
//   }

//   Future<Result> searchCustomer(String mobileNumber) async {
//     Result res =
//         await BaseClient.post('devotees', body: {'mobile': mobileNumber});
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('search response $response');
//       SearchResponse searchResponse = SearchResponse.fromJson(response);
//       return (searchResponse.status ?? false)
//           ? Result.value(searchResponse)
//           : Result.error(searchResponse);
//     }
//   }

//   Future<Result> createCustomer(CreateCustomer createCustomer) async {
//     Result res =
//         await BaseClient.post('create-devotee', body: createCustomer.toJson());
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel = ErrorResponseModel(
//           errorMessage:
//               'Mobile number already exists. Please try another one.');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       debugPrint('create customer response $response');
//       return response['status'] == true
//           ? Result.value('Customer created successfully')
//           : Result.error(
//               'Mobile number already exists. Please try another one.');
//     }
//   }
//   Future<Result> getPreviewBill(SaveBillBody previewBillBody) async {
//     Result res =
//         await BaseClient.post('preview-bill', body: previewBillBody.toJson());
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');

//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       PreviewBillResponse previewBillResponse =
//           PreviewBillResponse.fromJson(response);
//       return (previewBillResponse.status ?? false)
//           ? Result.value(previewBillResponse)
//           : Result.error(previewBillResponse);
//     }
//   }


//   Future<Result> getversion() async {
//     Result res = await BaseClient.get(
//       'app-versions',
//     );
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');

//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       VersionDatamodel versionResponse = VersionDatamodel.fromJson(response);
//       return (versionResponse.success ?? false)
//           ? Result.value(versionResponse)
//           : Result.error(versionResponse);
//     }
//   }

//   Future<Result> saveBill(SaveBillBody saveBillBody) async {
//     if (kDebugMode) {
//       print("savebill..............${saveBillBody.toJson()}");
//     }
//     Result res =
//         await BaseClient.post('save-bill', body: saveBillBody.toJson());
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;

//       SaveBillResponse saveBillResponse = SaveBillResponse.fromJson(response);
//       return (saveBillResponse.status ?? false)
//           ? Result.value(saveBillResponse)
//           : Result.error(saveBillResponse);
//     }
//   }

//   Future<Result> getquickbill() async {
//     Result res = await BaseClient.get('quick-bill-pooja');
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');

//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       QuickbillDatamodel quickbillResponse =
//           QuickbillDatamodel.fromJson(response);

//       return (quickbillResponse.status ?? false)
//           ? Result.value(quickbillResponse)
//           : Result.error(quickbillResponse);
//     }
//   }

//   Future<Result> savequickbill(
//       {int? modeid, String? amt, List? poojalist}) async {
//     final body = {
//       "counter_id": AppConfig.counterID,
//       "payment_mode": modeid,
//       "bill_amount": amt,
//       "paid_amount": amt,
//       "pooja_details": poojalist
//     };

//     Result res = await BaseClient.post('quick-bill', body: body);
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       SavequickbillDatamodel quickbillResponse =
//           SavequickbillDatamodel.fromJson(response);
//       return (quickbillResponse.status ?? false)
//           ? Result.value(quickbillResponse)
//           : Result.error(quickbillResponse);
//     }
//   }

//   Future<Result> getPaymentModes() async {
//     Result res = await BaseClient.get('payment-modes');
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       PaymentModeResponse paymentModeResponse =
//           PaymentModeResponse.fromJson(response);
//       return (paymentModeResponse.status ?? false)
//           ? Result.value(paymentModeResponse)
//           : Result.error(paymentModeResponse);
//     }
//   }

//   Future<Result> getBillList(String date) async {
//     Result res = await BaseClient.get(
//       'bill-list?date=${date.toString()}',
//     );
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       if (kDebugMode) {
//         print(response);
//       }
//       BillListResponseModel billListResponseModel =
//           BillListResponseModel.fromJson(response);
//       return (billListResponseModel.status ?? false)
//           ? Result.value(billListResponseModel)
//           : Result.error(billListResponseModel);
//     }
//   }

//   Future<Result> getPoojaSummary(String fromDate, String toDate) async {
//     // print("pagein api....${page}");
//     Result res = await BaseClient.get(
//       'reports/pooja-summary?from_date=${fromDate.toString()}&to_date=${toDate.toString()}',
//     );
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       PoojaSummaryResponse poojaSummaryResponse =
//           PoojaSummaryResponse.fromJson(response);
//       // print("....responsepoojasummary...${response}");n
//       return (poojaSummaryResponse.status ?? false)
//           ? Result.value(poojaSummaryResponse)
//           : Result.error(poojaSummaryResponse);
//     }
//   }

//   CounterWiseSummaryResponse? counterWiseSummaryResponse;
//   Future<Result> getCounterWiseSummary(String? fromDate) async {
//     counterWiseSummaryResponse = null;
//     final prefs = await SharedPreferences.getInstance();
//     String? id = prefs.getString("counterid");
//     if (kDebugMode) {
//       print("...id...$id...$fromDate");
//     }
//     Result res = await BaseClient.get('reports/counter-wise',
//         map: {'from_date': fromDate ?? '', 'counter_id': id ?? '0'});
//     if (res.isError) {
//       ErrorResponseModel errorResponseModel =
//           ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
//       return Result.error(errorResponseModel);
//     } else {
//       var response = res.asValue!.value;
//       counterWiseSummaryResponse =
//           CounterWiseSummaryResponse.fromJson(response);
//       if (kDebugMode) {
//         print(
//             "${counterWiseSummaryResponse?.status}..${counterWiseSummaryResponse?.counter}");
//       }
//       if (kDebugMode) {
//         print(counterWiseSummaryResponse?.selectedDate);
//       }
//       return (counterWiseSummaryResponse?.status ?? false)
//           ? Result.value(counterWiseSummaryResponse)
//           : Result.error(counterWiseSummaryResponse!);
//     }
//   }
}
