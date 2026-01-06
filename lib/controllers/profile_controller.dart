import 'package:flashchat/controllers/auth_Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flashchat/services/firestore_service.dart';
import 'package:flashchat/models/user_model.dart';
class ProfileController extends GetxController{
  final FirestoreService _firestoreService=FirestoreService();
  final TextEditingController disPlayName=TextEditingController();
  final AuthController _authController=Get.find<AuthController>();
   final TextEditingController email=TextEditingController();
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;
  final RxBool _isEditing = false.obs;
  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);
  bool get isLoading=>_isLoading.value;
  bool get isEditing=>_isEditing.value;
  String get error=>_error.value;
  UserModel? get currentUser=>_currentUser.value;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     _loadUserData();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disPlayName.dispose();
    email.dispose();
  }
void _loadUserData(){
  final currentUserid=_authController.user?.uid;
  if(currentUserid!=null){
    _currentUser.bindStream(_firestoreService.getUser(currentUserid));
  }
}



}