import 'dart:io';

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
import 'package:construction_app/models/change_password_body.dart';
import 'package:construction_app/models/change_password_model.dart';
import 'package:construction_app/models/create_user_body.dart';
import 'package:construction_app/models/create_user_model.dart';
import 'package:construction_app/models/edit_profile_body.dart';
import 'package:construction_app/models/edit_profile_model.dart';
import 'package:construction_app/models/error_response_model.dart';
import 'package:construction_app/models/forgot_pass_reset_model.dart';
import 'package:construction_app/models/forgot_pass_verify_otp_model.dart';
import 'package:construction_app/models/forgot_password_send_otp_Model.dart';
import 'package:construction_app/models/get_categories_model.dart';
import 'package:construction_app/models/get_company.dart';
import 'package:construction_app/models/get_labours_model.dart';
import 'package:construction_app/models/get_materials_model.dart';
import 'package:construction_app/models/get_payment_model.dart';
import 'package:construction_app/models/get_stages_model.dart';
import 'package:construction_app/models/get_sub_stages.dart';
import 'package:construction_app/models/get_supervisor_model.dart';
import 'package:construction_app/models/login_model.dart';
import 'package:construction_app/models/logout_model.dart';
import 'package:construction_app/models/material_name_model.dart';
import 'package:construction_app/models/payment_body.dart';
import 'package:construction_app/models/payment_details_model.dart';
import 'package:construction_app/models/payment_model.dart';
import 'package:construction_app/models/payment_modes_model.dart';
import 'package:construction_app/models/phone_verification_body.dart';
import 'package:construction_app/models/phone_verification_screen.dart';
import 'package:construction_app/models/profile_model.dart';
import 'package:construction_app/models/profile_register_body.dart';
import 'package:construction_app/models/profile_register_model.dart';
import 'package:construction_app/models/recepite_delete_model.dart';
import 'package:construction_app/models/register_company_body.dart';
import 'package:construction_app/models/register_company_model.dart';
import 'package:construction_app/models/set_password_body.dart';
import 'package:construction_app/models/set_password_model.dart';
import 'package:construction_app/models/site_detail_report_model.dart';
import 'package:construction_app/models/sitesbycompanies.dart';
import 'package:construction_app/models/stage_wise_report_model.dart';
import 'package:construction_app/models/supplier_detail_model.dart';
import 'package:construction_app/models/supplier_model.dart';
import 'package:construction_app/models/total_recevied_detail_model.dart';
import 'package:construction_app/models/total_spent_detail_model.dart';
import 'package:construction_app/models/units_model.dart';
import 'package:construction_app/models/update_stage_body.dart';
import 'package:construction_app/models/update_stage_model.dart';
import 'package:construction_app/models/verify_otp_body.dart';
import 'package:construction_app/models/verify_otp_model.dart';
import 'package:construction_app/services/base_client.dart';
import 'package:flutter/foundation.dart';
import 'package:async/async.dart';


class ServiceConfig {
  Future<Result> login({String? phone, String? password}) async {
    Map<String, dynamic> body = {
      'mobile': phone ?? '',
      'password': password ?? ''
    };

    try {
      Result res = await BaseClient.post('login', body: body);
      if (res.isError) {
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel(errorMessage: 'OOps...!, login failed');
        return Result.error(errorResponseModel);
      } else {
        var response = res.asValue!.value;
        debugPrint('login response $response');
        LoginModel loginResponseModel = LoginModel.fromJson(response);
        return (loginResponseModel.status)
            ? Result.value(loginResponseModel)
            : Result.error(loginResponseModel);
      }
    } catch (e) {
      debugPrint('Login Error: $e');
      return Result.error(ErrorResponseModel(errorMessage: e.toString()));
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
    return Result.error(res.asError!.error);
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
    return Result.error(res.asError!.error);
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
    return Result.error(res.asError!.error);
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
    return Result.error(res.asError!.error);
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
  debugPrint("---------------addLabours : ${addLabourBody.toJson()}-----------------------");
  if(res.isError){
    return Result.error(res.asError!.error);
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


Future<Result> getSupplierDetail({required int supplierId})async{
  Result res = await BaseClient.get("supplier?supplier_id=$supplierId");
  if(res.isError){
    ErrorResponseModel errorResponseModel = ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("-----------------Get Supplier Detail : $response ---------------------");
    SupplierDetailModel supplierDetailModel = SupplierDetailModel.fromJson(response);
    return (supplierDetailModel.status)
    ?Result.value(supplierDetailModel)
    :Result.error(supplierDetailModel);
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
  debugPrint("---------------- Update stage body : ${updateStageBody.toJson()} ---------------------");
  if (res.isError) {
    return Result.error(res.asError!.error);
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


Future<Result> getPaymentModes()async{
  Result res = await BaseClient.get("payment-modes");
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Get Payment Modes : $response");
    PaymentModesModel paymentModesModel = PaymentModesModel.fromJson(response);
    return (paymentModesModel.status)
    ?Result.value(paymentModesModel)
    :Result.error(paymentModesModel);
  }
}


Future<Result> addPayment(PaymentBody paymentBody) async {
  Result res = await BaseClient.post("add-payment",body: paymentBody.toJson());
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Add Payment : $response");
    debugPrint(paymentBody.toJson().toString());
    PaymentModel paymentModel = PaymentModel.fromJson(response);
    return (paymentModel.status)
    ?Result.value(paymentModel)
    :Result.error(paymentModel);
  }
}

Future<Result> getPayments(int siteId,int paymentType, String fromDate, String toDate) async {
  Result res = await BaseClient.get("get-payments?site_id=$siteId&payment_type=$paymentType&from_date=$fromDate&to_date=$toDate");
  if (res.isError) {
    ErrorResponseModel errorResponseModel =
    ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  } else {
    var response = res.asValue!.value;
    debugPrint("Get Payments : $response");
    GetPaymentModel getPaymentModel =
    GetPaymentModel.fromJson(response);
    return (getPaymentModel.status)
    ?Result.value(getPaymentModel)
    :Result.error(getPaymentModel);
  }
}


Future<Result> getSiteDetailReport(int siteid) async {
  Result res = await BaseClient.get("reports/site-detail?site_id=$siteid");
  if(res.isError){
    ErrorResponseModel errorResponseModel =
    ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Get Site Detail Report : $response");
    SiteDetailReportModel siteDetailReport =
    SiteDetailReportModel.fromJson(response);
    return (siteDetailReport.status)
    ?Result.value(siteDetailReport)
    :Result.error(siteDetailReport);
  }
}


Future<Result> getStageWiseReport(int siteId) async {
  Result res = await BaseClient.get("reports/stage-wise?site_id=$siteId");
  if(res.isError){
    ErrorResponseModel errorResponseModel = 
    ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Get Stage Wise Report : $response");
    StageWiseReportModel stageWiseReportModel = 
    StageWiseReportModel.fromJson(response);
    return (stageWiseReportModel.status)
    ?Result.value(stageWiseReportModel)
    :Result.error(stageWiseReportModel);
  }
}


Future<Result> getTotalSpentDetail(int siteId) async {
  Result res = await BaseClient.get("reports/site-spent-detail?site_id=$siteId");
  if(res.isError){
    ErrorResponseModel errorResponseModel =
    ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Get Total Spent Detail : $response");
    TotalSpentDetailModel totalSpentDetailModel =
    TotalSpentDetailModel.fromJson(response);
    return (totalSpentDetailModel.status)
    ?Result.value(totalSpentDetailModel)
    :Result.error(totalSpentDetailModel);
  }
}


Future<Result> getTotalReceivedDetail(int siteId) async {
  Result res = await BaseClient.get("reports/site-received-detail?site_id=$siteId");
  if(res.isError){
    ErrorResponseModel errorResponseModel =
    ErrorResponseModel(errorMessage: "OOps...!, Something went wrong");
    return Result.error(errorResponseModel);
  }else{
    var response = res.asValue!.value;
    debugPrint("Get Total Received Detail : $response");
    TotalReceivedDetailModel totalReceivedDetailModel =
    TotalReceivedDetailModel.fromJson(response);
    return (totalReceivedDetailModel.status)
    ?Result.value(totalReceivedDetailModel)
    :Result.error(totalReceivedDetailModel);
  }
}

  Future<Result> registerCompany(
    RegisterCompanyBody body,
    File? logoFile,
  ) async {

    Result res = await BaseClient.multipartPost(
      "register/complete-guest",

      fields: {

        "company_id": body.companyId.toString(),
        "reg_token": body.regtoken ?? "",
        "company_type": body.companyType ?? "",
        "registration_number": body.registrationNumber ?? "",
        "gst_number": body.gstNumber ?? "",
        "company_email": body.companyEmail ?? "",
       // "phone_number": body.phoneNumber ?? "",
        "street_address": body.streetAddress ?? "",
        "city": body.city ?? "",
        "state": body.state ?? "",
        "pincode": body.pincode ?? "",
        // "admin_name": body.adminName,
        // "admin_email": body.adminEmail,
        // "password": body.password,
        // "password_confirmation":
        //     body.passwordConfirmation,
      },

      file: logoFile,
      fileField: "logo",
    );

    if (res.isError) {
      return Result.error(res.asError!.error);
    } else {

      var response = res.asValue!.value;

      debugPrint("Register : $response");

      if (response['status'] == false) {
        return Result.error(ErrorResponseModel(
          errorMessage: response['message'] ?? "Registration failed",
        ));
      }
      RegisterCompanyModel model = RegisterCompanyModel.fromJson(response);

      return model.status
          ? Result.value(model)
          : Result.error(model);
    }
  }


  Future<Result> deleteReceipt(int receiptid)async{
    try {
      Result res = await BaseClient.post("receipt/delete",body: {"id": receiptid});
      print("-------------------Delete Receipt: $receiptid-------------------------------------");
      if(res.isError){
        return Result.error(res.asError!.error);
      }else{
        var response = res.asValue!.value;
        debugPrint("Delete Receipt : $response");
        ReceiptDeleteModel receiptDeleteModel =
        ReceiptDeleteModel.fromJson(response);
        return (receiptDeleteModel.status)
            ? Result.value(receiptDeleteModel)
            : Result.error(receiptDeleteModel);
      }
    } catch (e) {
      debugPrint("ServiceConfig: Error in deleteReceipt: $e");
      return Result.error(ErrorResponseModel(errorMessage: e.toString()));
    }
  }

  Future<Result> phoneNumberVerification(PhoneNumberVerficationBody body) async {
    Result res = await BaseClient.post('register/initiate',body: body.toJson());
    if(res.isError){
      return Result.error(res.asError!.error);
    } else {
      var response = res.asValue!.value;
      debugPrint("Phone Number Verification : $response");
      PhoneNumberVerficationModel phoneNumberVerificationModel =
      PhoneNumberVerficationModel.fromJson(response);
      return (phoneNumberVerificationModel.status)
      ?Result.value(phoneNumberVerificationModel)
      :Result.error(phoneNumberVerificationModel);
    }
  }


  Future<Result> verifyOtp(VerifyOtpBody body) async {
    Result res = await BaseClient.post('register/verify-otp', body: body.toJson());
    if(res.isError){
      return Result.error(res.asError!.error);
    }else{
      var response = res.asValue!.value;
      debugPrint("Verify Otp : $response");
      VerifyOtpModel verifyOtpModel =
      VerifyOtpModel.fromJson(response);
      return (verifyOtpModel.status)
      ?Result.value(verifyOtpModel)
      :Result.error(verifyOtpModel);
    }
  }


  Future<Result> setPassword(SetPasswordBody body) async {
    Result res = await BaseClient.post("register/set-password",body: body.toJson());
    if(res.isError){
      return Result.error(res.asError!.error);
    }else{
      var response = res.asValue!.value;
      debugPrint("Set Password : $response");
      SetPasswordModel setPasswordModel =
      SetPasswordModel.fromJson(response);
      return (setPasswordModel.status)
      ?Result.value(setPasswordModel)
      :Result.error(setPasswordModel);
    }
  }

  Future<Result> profile() async{
    Result res = await BaseClient.get("profile");
    if(res.isError){
      return Result.error(res.asError!.error);
    }else{
      var response = res.asValue!.value;
      debugPrint("Profile : $response");
      ProfileModel profileModel =
      ProfileModel.fromJson(response);
      return (profileModel.status)
      ?Result.value(profileModel)
      :Result.error(profileModel);
    }
  }


  Future<Result> getPaymentDetails()async{
    Result res = await BaseClient.get("plans");
    if(res.isError){
      return Result.error(res.asError!.error);
    }else{
      var response = res.asValue!.value;
      debugPrint("Get Payment Details : $response");
      PaymentDetailsModel paymentDetailsModel = 
      PaymentDetailsModel.fromJson(response);
      return (paymentDetailsModel.status)
      ?Result.value(paymentDetailsModel)
      :Result.error(paymentDetailsModel);
    }
  }


    Future<Result> registerProfile(
    ProfileRegisterBody body,
    File? logoFile,
  ) async {

    Result res = await BaseClient.multipartPost(
      "register/complete",

      fields: {

        //"company_name": body.companyName,
        "company_type": body.companyType ?? "",
        "registration_number": body.registrationNumber ?? "",
        "gst_number": body.gstNumber ?? "",
        "company_email": body.companyEmail ?? "",
       // "phone_number": body.phoneNumber ?? "",
        "street_address": body.streetAddress ?? "",
        "city": body.city ?? "",
        "state": body.state ?? "",
        "pincode": body.pincode ?? "",
        // "admin_name": body.adminName,
        // "admin_email": body.adminEmail,
        // "password": body.password,
        // "password_confirmation":
        //     body.passwordConfirmation,
      },

      file: logoFile,
      fileField: "logo",
    );

    if (res.isError) {
      return Result.error(res.asError!.error);
    } else {

      var response = res.asValue!.value;

      debugPrint("Register : $response");

      if (response['status'] == false) {
        return Result.error(ErrorResponseModel(
          errorMessage: response['message'] ?? "Registration failed",
        ));
      }
      ProfileRegisterModel model = ProfileRegisterModel.fromJson(response);

      return model.status
          ? Result.value(model)
          : Result.error(model);
    }
  }



  Future<Result> editProfile(
  EditProfileBody body
) async {

  Result res = await BaseClient.post(
    "profile/update",
    body: body.toJson(),
  );

  if (res.isError) {
    ErrorResponseModel errorResponseModel = ErrorResponseModel(
      errorMessage: "OOps...!, Something went wrong",
    );
    return Result.error(errorResponseModel);
  } else {
    var response = res.asValue!.value;
    debugPrint("Edit Profile: $response");

    if (response['status'] == false) {
      return Result.error(
        ErrorResponseModel(
          errorMessage: response['message'] ?? "Update failed",
        ),
      );
    }

    EditProfileModel model = EditProfileModel.fromJson(response);
    return Result.value(model);
  }
}

  Future<Result> changePassword(ChangePasswordBody body) async {
    Result res = await BaseClient.post("profile/change-password", body: body.toJson());

    if (res.isError) {
      ErrorResponseModel errorResponseModel = ErrorResponseModel(
        errorMessage: "OOps...!, Something went wrong",
      );
      return Result.error(errorResponseModel);
    } else {
      var response = res.asValue!.value;
      debugPrint("Change Password : $response");
      ChangePasswordModel changePasswordModel = ChangePasswordModel.fromJson(response);
      return (changePasswordModel.status)
          ? Result.value(changePasswordModel)
          : Result.error(changePasswordModel);
    }
  }



  Future<Result> forgotPassword(String phone) async {
    Result res = await BaseClient.post("forgot-password/send-otp", body:{"mobile":phone});
    if (res.isError) {
      ErrorResponseModel errorResponseModel = ErrorResponseModel(
        errorMessage: "OOps...!, Something went wrong",
      );
      return Result.error(errorResponseModel);
    } else {
      var response = res.asValue!.value;
      debugPrint("Forgot Password : $response");
      ForgotPasswordSendOtpModel forgotPasswordModel = ForgotPasswordSendOtpModel.fromJson(response);
      return Result.value(forgotPasswordModel);
    }
  }


  Future<Result> forgotPassVerifyOtp(String mobile, String otp) async {
    Result res = await BaseClient.post("forgot-password/verify-otp", body: {"mobile":mobile,"otp":otp});
    if (res.isError) {
      ErrorResponseModel errorResponseModel = ErrorResponseModel(
        errorMessage: "OOps...!, Something went wrong",
      );
      return Result.error(errorResponseModel);
    } else {
      var response = res.asValue!.value;
      debugPrint("Forgot Password verify otp: $response");
      ForgotPassVerifyOtpModel forgotPasswordModel = ForgotPassVerifyOtpModel.fromJson(response);
      return Result.value(forgotPasswordModel);
    }
  }


  Future<Result> forgotPassReset(String mobile, String password,String confirmPassword,String resetToken) async {
    Result res = await BaseClient.post("forgot-password/reset", body: {"mobile":mobile,"password":password,"password_confirmation":confirmPassword,"reset_token":resetToken});
    if (res.isError) {
      ErrorResponseModel errorResponseModel = ErrorResponseModel(
        errorMessage: "OOps...!, Something went wrong",
      );
      return Result.error(errorResponseModel);
    } else {
      var response = res.asValue!.value;
      debugPrint("Forgot Password reset: $response");
      ForgotPassResetModel forgotPasswordModel = ForgotPassResetModel.fromJson(response);
      return Result.value(forgotPasswordModel);
    }
  }








}