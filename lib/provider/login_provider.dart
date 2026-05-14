import 'package:construction_app/models/login_model.dart';
import 'package:construction_app/models/error_response_model.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:flutter/cupertino.dart';


class LoginProvider extends ChangeNotifier with ProviderHelperClass {
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
  Future<void> login({Function(String role)? onSuccess, Function(String errorMessage)? onFailure}) async {
    updateLoadState(LoaderState.loading);
    var res = await serviceConfig.login(
        phone: loginUsernameController.text.trim(),
        password: loginPasswordController.text);
    if (!res.isError) {
      LoginModel loginModel = res.asValue!.value;
      if (isRememberCredentials && loginModel.token != null && loginModel.data != null) {
        await SharedPreferenceHelper.saveToken(loginModel.token);
        await SharedPreferenceHelper.saveUserID(loginModel.data.id.toString());
        await SharedPreferenceHelper.saveRole(loginModel.data.role);
        await SharedPreferenceHelper.saveCompanyId(loginModel.data.companyId);
        await SharedPreferenceHelper.saveUserName(loginModel.data.name);
        await SharedPreferenceHelper.saveTrialInfo(
          daysLeft: loginModel.data.trialDaysLeft,
          expired:  loginModel.data.trialExpired,
        );

        //print("Saved Company ID: ${loginModel.data.companyId}");
      }
      
      if (onSuccess != null && loginModel.data != null) {
        onSuccess(loginModel.data.role.toLowerCase());
      } else if (onSuccess != null && !loginModel.status) {
        // This case should theoretically be handled by the error branch, 
        // but adding safety just in case.
      }
      updateLoadState(LoaderState.loaded);
    } else {
      String errorMessage = 'Login failed';
      if (res.asError!.error is ErrorResponseModel) {
        errorMessage = (res.asError!.error as ErrorResponseModel).errorMessage ?? errorMessage;
      } else if (res.asError!.error is LoginModel) {
        errorMessage = (res.asError!.error as LoginModel).message;
      }
      errorToast = errorMessage;
      if (onFailure != null) onFailure(errorMessage);
      updateLoadState(LoaderState.loaded);
    }
    notifyListeners();
  }

  Future<void> logout(
      {Function()? onSuccess,
      Function(String errorMessage)? onFailure}) async {
    updateLoadState(LoaderState.loading);
    var res = await serviceConfig.logout();
    if (!res.isError) {
      await SharedPreferenceHelper.clearWholeData();
      if (onSuccess != null) onSuccess();
      updateLoadState(LoaderState.loaded);
    } else {
      String errorMessage = 'Logout failed';
      if (res.asError!.error is ErrorResponseModel) {
        errorMessage = (res.asError!.error as ErrorResponseModel).errorMessage ??
            errorMessage;
      }
      if (onFailure != null) onFailure(errorMessage);
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
