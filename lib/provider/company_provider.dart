import 'package:construction_app/models/add-sites_model.dart';
import 'package:construction_app/models/add_site_body.dart';
import 'package:construction_app/models/create_user_body.dart';
import 'package:construction_app/models/create_user_model.dart';
import 'package:construction_app/models/error_response_model.dart';
import 'package:construction_app/models/get_supervisor_model.dart';
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
  int? selectedSupervisorId;
  
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





  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
