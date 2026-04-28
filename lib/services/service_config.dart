import 'package:construction_app/models/add-sites_model.dart';
import 'package:construction_app/models/add_materials_body.dart';
import 'package:construction_app/models/add_materials_model.dart';
import 'package:construction_app/models/add_site_body.dart';
import 'package:construction_app/models/add_stage_body.dart';
import 'package:construction_app/models/add_stages_model.dart';
import 'package:construction_app/models/add_sub_stages_body.dart';
import 'package:construction_app/models/add_sub_stages_model.dart';
import 'package:construction_app/models/create_user_body.dart';
import 'package:construction_app/models/create_user_model.dart';
import 'package:construction_app/models/error_response_model.dart';
import 'package:construction_app/models/get_company.dart';
import 'package:construction_app/models/get_supervisor_model.dart';
import 'package:construction_app/models/login_model.dart';
import 'package:construction_app/models/sitesbycompanies.dart';
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


// Future<Result> getSites()async{
//   Result res = await BaseClient.get("sites");
//   if(res.isError){
//     ErrorResponseModel errorResponseModel = 
//     ErrorResponseModel(errorMessage: "Oops...!, Something went wrong");
//     return Result.error(errorResponseModel);
//   }else{
//     var response = res.asValue!.value;
//     debugPrint("Get Sites : $response");
//     GetSitesModel getSitesModel = GetSitesModel.fromJson(response);
//     return (getSitesModel.status)
//     ? Result.value(getSitesModel)
//     : Result.error(getSitesModel);
//   }
// }

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

Future<Result> getCompany() async{
  Result res = await BaseClient.get("companies");
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "Oops...!, Something went wrong");
    return Result.error(errorResponseModel);
    
  }else{
    var response = res.asValue!.value;
    debugPrint("Get Company : $response");
    GetCompany getCompanyModel = GetCompany.fromJson(response);
    return (getCompanyModel.status)
    ? Result.value(getCompanyModel)
    : Result.error(getCompanyModel);
  }
}


Future<Result> sitesByCompany(int companyId) async{
  Result res = await BaseClient.get("sites/$companyId");
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "Oops...!, Something went wrong");
    return Result.error(errorResponseModel);
    
  }else{
    var response = res.asValue!.value;
    debugPrint("Get sites by Company : $response");
    SitesbycompaniesModel getCompanyModel = SitesbycompaniesModel.fromJson(response);
    return (getCompanyModel.status)
    ? Result.value(getCompanyModel)
    : Result.error(getCompanyModel);
  }
}

Future<Result> addMaterial(AddMaterialsBody addMaterialBody)async{
  Result res = await BaseClient.post("add-materials", body: addMaterialBody.toJson());
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "Oops...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Add Materials : $response");
    AddMaterialsModel addSitesModel = AddMaterialsModel.fromJson(response);
    return (addSitesModel.status)
    ? Result.value(addSitesModel)
    : Result.error(addSitesModel);
  }
}


Future<Result> addStages(AddStagesBody addStagesBody)async{
  Result res = await BaseClient.post("sites/add-stages",body: addStagesBody.toJson());
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "Ooops something went wrong.....!");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Add Stages : $response");
    AddStagesModel addStagesModel = AddStagesModel.fromJson(response);
    return (addStagesModel.status)
    ?Result.value(addStagesModel)
    :Result.error(addStagesModel);
  }
}


Future<Result> addSubStages(AddSubStagesBody addSubStagesBody)async {
  Result res = await BaseClient.post('sites/add-sub-stages');
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "oops something went wrong...!");
    return Result.error(errorResponseModel);
  } else {
    var response = res.asValue!.value;
    debugPrint("Add Sub Stages : $response");
    AddSubStagesModel addSubStagesModel = AddSubStagesModel.fromJson(response);
    return (addSubStagesModel.status)
    ?Result.value(addSubStagesModel)
    :Result.error(addSubStagesModel);
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




}
