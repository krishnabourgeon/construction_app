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
  Future<void> login({Function(String role, bool trialExpired)? onSuccess, Function(String errorMessage)? onFailure}) async {
    updateLoadState(LoaderState.loading);
    var res = await serviceConfig.login(
        phone: loginUsernameController.text.trim(),
        password: loginPasswordController.text);
    if (!res.isError) {
      LoginModel loginModel = res.asValue!.value;
      if (loginModel.status) {
        await SharedPreferenceHelper.setOtpVerified(true);
      }

      if (isRememberCredentials && loginModel.token != null && loginModel.data != null) {
        await SharedPreferenceHelper.saveToken(loginModel.token!);
        await SharedPreferenceHelper.saveUserID(loginModel.data!.id.toString());
        await SharedPreferenceHelper.saveRole(loginModel.data!.role);
        await SharedPreferenceHelper.saveCompanyId(loginModel.data!.companyId);
        await SharedPreferenceHelper.saveUserName(loginModel.data!.name);
        await SharedPreferenceHelper.saveTrialInfo(
          daysLeft: loginModel.data!.trialDaysLeft ?? 0,
          expired:  loginModel.data!.trialExpired ?? true,
        );
      }
      
      if (onSuccess != null && loginModel.data != null) {
        onSuccess(loginModel.data!.role.toLowerCase(), loginModel.data!.trialExpired ?? true);
      } else if (onSuccess != null && !loginModel.status) {
        if (onFailure != null) onFailure(loginModel.message);
      }
      updateLoadState(LoaderState.loaded);
    } else {
      String errorMessage = 'Login failed';
      if (res.asError!.error is ErrorResponseModel) {
        errorMessage = (res.asError!.error as ErrorResponseModel).errorMessage ?? errorMessage;
      } else if (res.asError!.error is LoginModel) {
        errorMessage = (res.asError!.error as LoginModel).message;
      } else if (res.asError!.error is String) {
        errorMessage = res.asError!.error as String;
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
    try {
      await serviceConfig.logout();
    } catch (e) {
      debugPrint("API logout error (safe to ignore): $e");
    }
    await SharedPreferenceHelper.clearWholeData();
    if (onSuccess != null) onSuccess();
    updateLoadState(LoaderState.loaded);
    notifyListeners();
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }



}
