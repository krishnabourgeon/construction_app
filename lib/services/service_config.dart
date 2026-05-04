import 'package:construction_app/models/add-sites_model.dart';
import 'package:construction_app/models/add_labour_body.dart';
import 'package:construction_app/models/add_labour_model.dart';
import 'package:construction_app/models/add_materials_body.dart';
import 'package:construction_app/models/add_materials_model.dart';
import 'package:construction_app/models/add_site_body.dart';
import 'package:construction_app/models/add_stage_body.dart';
import 'package:construction_app/models/add_stages_model.dart';
import 'package:construction_app/models/add_sub_stages_body.dart';
import 'package:construction_app/models/add_sub_stages_model.dart';
import 'package:construction_app/models/add_supplier_body.dart';
import 'package:construction_app/models/add_supplier_model.dart';
import 'package:construction_app/models/create_user_body.dart';
import 'package:construction_app/models/create_user_model.dart';
import 'package:construction_app/models/error_response_model.dart';
import 'package:construction_app/models/get_categories_model.dart';
import 'package:construction_app/models/get_company.dart';
import 'package:construction_app/models/get_labours_model.dart';
import 'package:construction_app/models/get_materials_model.dart';
import 'package:construction_app/models/get_stages_model.dart';
import 'package:construction_app/models/get_sub_stages.dart';
import 'package:construction_app/models/get_supervisor_model.dart';
import 'package:construction_app/models/login_model.dart';
import 'package:construction_app/models/logout_model.dart';
import 'package:construction_app/models/material_name_model.dart';
import 'package:construction_app/models/sitesbycompanies.dart';
import 'package:construction_app/models/supplier_model.dart';
import 'package:construction_app/models/units_model.dart';
import 'package:construction_app/models/update_stage_body.dart';
import 'package:construction_app/models/update_stage_model.dart';
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
  Result res = await BaseClient.post("add-site-materials", body: addMaterialBody.toJson());
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
  Result res = await BaseClient.post('sites/add-sub-stages',body: addSubStagesBody.toJson(),);
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


Future<Result> getStages(int siteId)async{
  Result res = await BaseClient.get("stages/$siteId");
  if(res.isError){
    ErrorResponseModel errorResponseModel =
    ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Get stages : $response");
    GetStagesModel getStagesModel = GetStagesModel.fromJson(response);
    return (getStagesModel.status)
    ?Result.value(getStagesModel)
    :Result.error(getStagesModel);
  }
}

Future<Result> getSubStages(int siteId)async{
  Result res = await BaseClient.get("substages/$siteId");
  if(res.isError){
    ErrorResponseModel errorResponseModel =
    ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Get Sub Stages : $response");
    GetSubStages getSubStagesModel = GetSubStages.fromJson(response);
    return (getSubStagesModel.status)
    ?Result.value(getSubStagesModel)
    :Result.error(getSubStagesModel);
  }
}


Future<Result> addLabours(AddLabourBody addLabourBody)async{
  Result res = await BaseClient.post("sites/add-labours",body: addLabourBody.toJson());
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Add Labours : $response");
    AddLabourModel addLabourModel = AddLabourModel.fromJson(response);
    return (addLabourModel.status)
    ?Result.value(addLabourModel)
    :Result.error(addLabourModel);
  }
}


Future<Result> getLabours({int? substageId})async{
  String url = "labours";
  if (substageId != null) {
    url += "?substage_id=$substageId";
  }
  Result res = await BaseClient.get(url);
  if(res.isError){
    ErrorResponseModel errorResponseModel =
    ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Get Labours : $response");
    GetLaboursModel getLaboursModel = GetLaboursModel.fromJson(response);
    return (getLaboursModel.status)
    ?Result.value(getLaboursModel)
    :Result.error(getLaboursModel);
  }
}

Future<Result> getCategories()async{
  Result res = await BaseClient.get("categories");
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Get Categories : $response");
    GetCategoriesModel getCategoriesModel = GetCategoriesModel.fromJson(response);
    return (getCategoriesModel.status)
    ?Result.value(getCategoriesModel)
    :Result.error(getCategoriesModel);
  }
}


Future<Result> getMaterialNames(String name) async {
  Result res = await BaseClient.get("materials?name=$name");
  if (res.isError) {
    ErrorResponseModel errorResponseModel =
        ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
    return Result.error(errorResponseModel);
  } else {
    var response = res.asValue!.value;
    debugPrint("Get Material Names: $response");
    MaterialsNameModel materialsNameModel =
        MaterialsNameModel.fromJson(response);
    return (materialsNameModel.status)
        ? Result.value(materialsNameModel)
        : Result.error(materialsNameModel);
  }
}


Future<Result> getUnits()async{
  Result res = await BaseClient.get("units");
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Get Units : $response");
    UnitsModel unitsModel = UnitsModel.fromJson(response);
    return (unitsModel.status)
    ?Result.value(unitsModel)
    :Result.error(unitsModel);
  }
}


Future<Result> getSuppliers()async{
  Result res = await BaseClient.get("suppliers");
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Get Suppliers : $response");
    SupplierModel supplierModel = SupplierModel.fromJson(response);
    return (supplierModel.status)
    ?Result.value(supplierModel)
    :Result.error(supplierModel);
  }
}


Future<Result> getMaterials(int? substageId)async{
  Result res = await BaseClient.get("site-materials?substage_id=$substageId");
  if(res.isError){
    ErrorResponseModel errorResponseModel =
    ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Get Materials : $response");
    GetMaterialsModel getMaterialsModel = GetMaterialsModel.fromJson(response);
    return (getMaterialsModel.status)
    ?Result.value(getMaterialsModel)
    :Result.error(getMaterialsModel);
  }
}


Future<Result> updateStages(UpdateStageBody updateStageBody) async {
  Result res = await BaseClient.post(
    "stages/update", 
    body: updateStageBody.toJson(),
  );
  
  if (res.isError) {
    ErrorResponseModel errorResponseModel =
        ErrorResponseModel(errorMessage: 'OOps...!, Something went wrong');
    return Result.error(errorResponseModel);
  } else {
    var response = res.asValue!.value;
    debugPrint("Update Stages: $response");
    UpdateStageModel updateStageModel =
        UpdateStageModel.fromJson(response);
    return (updateStageModel.status)
        ? Result.value(updateStageModel)
        : Result.error(updateStageModel);
  }
}


Future<Result> logout()async{
  Result res = await BaseClient.post('logout');
  if(res.isError){
    ErrorResponseModel errorResponseModel =
    ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Logout : $response");
    LogoutModel logoutModel = LogoutModel.fromJson(response);
    return (logoutModel.status)
    ?Result.value(logoutModel)
    :Result.error(logoutModel);
  }
}


Future<Result> addSupplier(AddSupplierBody addSupplierBody)async{
  Result res = await BaseClient.post('add-supplier',body: addSupplierBody.toJson(),);
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Add Supplier : $response");
    AddSupplierModel addSupplierModel = AddSupplierModel.fromJson(response);
    return (addSupplierModel.status)
    ?Result.value(addSupplierModel)
    :Result.error(addSupplierModel);
  }
}




}
