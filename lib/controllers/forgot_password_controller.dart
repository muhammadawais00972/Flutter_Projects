import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

class ForgotPasswordController extends GetxController{
  final AuthService _authService = AuthService();
  final TextEditingController email=TextEditingController();
  final GlobalKey<FormState> formkey=GlobalKey();
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;
  final RxBool _emailsent = false.obs;
  bool get isLoading=>_isLoading.value;
  String get error=>_error.value;
  bool get emialsent=>_emailsent.value;

@override
  void onClose() {
    // TODO: implement dispose
    super.onClose();
    email.dispose();

  }
  Future<void> sentPassword() async{
  if(!formkey.currentState!.validate()) return;
  try{
    _isLoading.value=true;
    _error.value=' ';
    await _authService.sendPasswordResetEmail(email.text.trim());
    _emailsent.value=true;
    Get.snackbar("Success", "Password reset email sent to ${email.text}",
      backgroundColor:  Colors.green.withOpacity(0.1),
      colorText: Colors.green,
      duration: Duration(seconds: 4)

    );

  }
  catch(e){
    _error.value=e.toString();

    Get.snackbar("Error",e.toString(),
        backgroundColor:  Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        duration: Duration(seconds: 4)

    );
  }
  finally{
    _isLoading.value=false;
  }


  }
  void goBackToLogin(){
    Get.back();
  }
  void resendEmail(){
  _emailsent.value=false;
  sentPassword();
  }
  String? validateEmail(String? value){
  if(value?.isEmpty?? true){
    return ' enter the emial';

  }
  if(!GetUtils.isEmail(value!)){
    return 'please enter the email';
  }
  return null;

  }
}