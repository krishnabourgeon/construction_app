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
import 'package:construction_app/models/get_stages_model.dart';
import 'package:construction_app/models/get_sub_stages.dart';
import 'package:construction_app/models/get_supervisor_model.dart';
import 'package:construction_app/models/sitesbycompanies.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:flutter/cupertino.dart';


class CompanyProvider extends ChangeNotifier with ProviderHelperClass {
  TextEditingController loginUsernameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController punnyamCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  String? errorToast;
  String? userNameValidationMessage;
  String? nameValidationMessage;
  String? emailValidationMessage;
  String? punnyamCodeValidationMessage;
  String? passwordValidationMessage;
  String? confirmPasswordValidationMessage;
  bool isLoginFormValidated = false;
  bool isRegisterFormValidated = false;
  bool isRememberCredentials = true;
  List<Supervisor> supervisorsList = [];
  List<SitesbyCompany> sitesList = [];
  int? selectedSupervisorId;
  int? selectedSiteId;
  List<GetStages> stagesList = [];
  List<SubStages> subStagesList = [];


  
  Future<void> createUser(
    // {Function(String? role)? onSuccess,
     {Function(String errorMessage)? onFailure,
    required String name,
    required String mobile,
    required String email,
    required String password,
    required String passwordConfirmation}
    )async {
    updateLoadState(LoaderState.loading);
    var res =
    await serviceConfig.createUser(CreateUserBody(
      name: name,
      mobile: mobile,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    ));
    if (!res.isError) {
     // CreateUserModel createUserModel = res.asValue!.value;
      // if (onSuccess != null) onSuccess(createUserModel.data?.role.toLowerCase());
      updateLoadState(LoaderState.loaded);
    } else {
      String errorMessage = "Failed to create user";
      if (res.asError!.error is ErrorResponseModel) {
        errorMessage =
            (res.asError!.error as ErrorResponseModel).errorMessage ??
            errorMessage;
      } else if (res.asError!.error is CreateUserModel) {
        errorMessage =
            (res.asError!.error as CreateUserModel).message;
      }
      errorToast = errorMessage;
      if (onFailure != null) onFailure(errorMessage);
      updateLoadState(LoaderState.loaded);
    }
    notifyListeners();
  }

  Future<void> getSupervisors({
    Function(String errorMessage)? onFailure,
  }) async {
    updateLoadState(LoaderState.loading);

    var res = await serviceConfig.getSupervisors();

    if (!res.isError) {
    final response = res.asValue!.value as GetSupervisorsModel;

    supervisorsList = response.data; //  STORE DATA HERE

    updateLoadState(LoaderState.loaded);
  } else {
    String errorMessage = "Failed to get supervisors";

    if (res.asError!.error is ErrorResponseModel) {
      errorMessage =
          (res.asError!.error as ErrorResponseModel).errorMessage ??
          errorMessage;
    }

    errorToast = errorMessage;
    if (onFailure != null) onFailure(errorMessage);

    updateLoadState(LoaderState.loaded);
  }

  notifyListeners(); //  VERY IMPORTANT
}


Future<void> addSites({
    Function(String errorMessage)? onFailure,
    required String sitename,
    required String contactperson,
    required String mobile,
    required int supervisorId,
    required DateTime startDate,
    required DateTime tentativeCompletionDate,
    required int estimateAmount,
    required String description,
  }) async {
    updateLoadState(LoaderState.loading);

    var res = await serviceConfig.addSite(
      AddSitesBody(
        sitename: sitename,
        contactperson: contactperson,
        mobile: mobile,
        supervisorId: supervisorId,
        startDate: startDate,
        tentativeCompletionDate: tentativeCompletionDate,
        estimateAmount: estimateAmount,
        description: description,
      ),
    );

    if (!res.isError) {
    final response = res.asValue!.value as AddSitesModel;

    updateLoadState(LoaderState.loaded);
  } else {
    String errorMessage = "Failed to add site";

    if (res.asError!.error is ErrorResponseModel) {
      errorMessage =
          (res.asError!.error as ErrorResponseModel).errorMessage ??
          errorMessage;
    }

    errorToast = errorMessage;
    if (onFailure != null) onFailure(errorMessage);

    updateLoadState(LoaderState.loaded);
  }

  notifyListeners(); //  VERY IMPORTANT
}


Future<void> getCompany({
    Function(String errorMessage)? onFailure,
  }) async {
    updateLoadState(LoaderState.loading);

    var res = await serviceConfig.getCompany();

    if (!res.isError) {
    final response = res.asValue!.value as GetCompany;

    updateLoadState(LoaderState.loaded);
  } else {
    String errorMessage = "Failed to get company";

    if (res.asError!.error is ErrorResponseModel) {
      errorMessage =
          (res.asError!.error as ErrorResponseModel).errorMessage ??
          errorMessage;
    }

    errorToast = errorMessage;
    if (onFailure != null) onFailure(errorMessage);

    updateLoadState(LoaderState.loaded);
  }

  notifyListeners();   

}



Future<void> sitesbycompanies({
    required int companyId,
    Function(String errorMessage)? onFailure,
  }) async {
    updateLoadState(LoaderState.loading);

    var res = await serviceConfig.sitesByCompany(companyId);

    if (!res.isError) {
    final response = res.asValue!.value as SitesbycompaniesModel;

     sitesList = response.data; 

    updateLoadState(LoaderState.loaded);
  } else {
    String errorMessage = "Failed to get Sites";

    if (res.asError!.error is ErrorResponseModel) {
      errorMessage =
          (res.asError!.error as ErrorResponseModel).errorMessage ??
          errorMessage;
    }

    errorToast = errorMessage;
    if (onFailure != null) onFailure(errorMessage);

    updateLoadState(LoaderState.loaded);
  }

  notifyListeners(); 
}


Future<void> addMaterials({
    Function(String errorMessage)? onFailure,
    required int companyId,
    required int siteId,
    required String name,
    required int quantity,
    required int unitId,
    required int price,
    required int totalAmount,
    required String supplier,
    required DateTime addedDate,
    required int estimateAmount,
    required String description,
  }) async {
    updateLoadState(LoaderState.loading);

    var res = await serviceConfig.addMaterial(
      AddMaterialsBody(
        companyId: companyId,
        siteId: siteId,
        name: name,
        quantity: quantity,
        unitId: unitId,
        price: price,
        totalAmount: totalAmount,
        supplier: supplier,
        addedDate: addedDate,
      ),
    );

    if (!res.isError) {
    final response = res.asValue!.value as AddMaterialsModel;

    updateLoadState(LoaderState.loaded);
  } else {
    String errorMessage = "Failed to add materials";

    if (res.asError!.error is ErrorResponseModel) {
      errorMessage =
          (res.asError!.error as ErrorResponseModel).errorMessage ??
          errorMessage;
    }

    errorToast = errorMessage;
    if (onFailure != null) onFailure(errorMessage);

    updateLoadState(LoaderState.loaded);
  }

  notifyListeners(); 
}


Future<int?> addStages({
  Function(String errorMessage)? onFailure,
  required int siteid,
  required String stage,
  required String description,
  required int status,
  required int hassubstage,
}) async {
  updateLoadState(LoaderState.loading);

  var res = await serviceConfig.addStages(
    AddStagesBody(
      siteId: siteid,
      stages: [
        Stage(
          stage: stage,
          hasSubstage: hassubstage,
          status: status,
          description: description,
        )
      ],
    ),
  );

  if (!res.isError) {
    final response = res.asValue!.value as AddStagesModel;
    updateLoadState(LoaderState.loaded);    
    await getStages(siteId: siteid);
    await getSubStages(siteId: siteid);
    notifyListeners();
    return response.data.first.id;
  } else {
    String errorMessage = "Failed to add stage";

    if (res.asError!.error is ErrorResponseModel) {
      errorMessage =
          (res.asError!.error as ErrorResponseModel).errorMessage ??
              errorMessage;
    }

    errorToast = errorMessage;
    if (onFailure != null) onFailure(errorMessage);

    updateLoadState(LoaderState.loaded);
    notifyListeners();
    return null;
  }
}

Future<void> addSubStages({
  required int siteId,
  required int stageId,
  required List<Substage> substages,
  Function(String errorMessage)? onFailure,
})async{
    updateLoadState(LoaderState.loading);

    var res = await serviceConfig.addSubStages(
      AddSubStagesBody(
        siteId: siteId,
        stageId: stageId,
        substages: substages,
      ),
    );

    if (!res.isError) {
    final response = res.asValue!.value as AddSubStagesModel;

    // Refresh the stages list so any sub-stage indicators are updated
    await getStages(siteId: siteId);
    await getSubStages(siteId: siteId);

    updateLoadState(LoaderState.loaded);
  } else {
    String errorMessage = "Failed to add sub stages";

    if (res.asError!.error is ErrorResponseModel) {
      errorMessage =
          (res.asError!.error as ErrorResponseModel).errorMessage ??
          errorMessage;
    }

    errorToast = errorMessage;
    if (onFailure != null) onFailure(errorMessage);

    updateLoadState(LoaderState.loaded);
  }

  notifyListeners();
}


Future<void> getStages({
  required int siteId,
  Function(String errorMessage)? onFailure,
})async{
  updateLoadState(LoaderState.loading);
  var res = await serviceConfig.getStages(siteId);
  if(!res.isError){
    final response = res.asValue!.value as GetStagesModel;
    stagesList = response.data;
    updateLoadState(LoaderState.loaded);
  } else {
    String errorMessage = "Failed to load stages";
    if(res.asError!.error is ErrorResponseModel){
      errorMessage = (res.asError!.error as ErrorResponseModel).errorMessage ??
      errorMessage;
    }
    errorToast = errorMessage;
    if(onFailure != null) onFailure(errorMessage);
    updateLoadState(LoaderState.loaded);
  }
  notifyListeners();
}



Future<void> getSubStages({required int siteId,Function(String errorMessage)? onFailure})async{
  updateLoadState(LoaderState.loading);
  var res = await serviceConfig.getSubStages(siteId);
  if(!res.isError){
    final response = res.asValue!.value as GetSubStages;
    subStagesList = response.data;
    updateLoadState(LoaderState.loaded);
  } else {
    String errorMessage = "Failed to load sub stages";
    if(res.asError!.error is ErrorResponseModel){
      errorMessage = (res.asError!.error as ErrorResponseModel).errorMessage ??
      errorMessage;
    }
    errorToast = errorMessage;
    if(onFailure != null) onFailure(errorMessage);
    updateLoadState(LoaderState.loaded);
  }
  notifyListeners();
}


  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
