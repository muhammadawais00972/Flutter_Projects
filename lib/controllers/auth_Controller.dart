import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/models/user_model.dart';
import 'package:flashchat/services/auth_service.dart';
import 'package:get/get.dart';

import 'package:flashchat/routes/app_routes.dart';


class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final Rx<User?> _user = Rx<User?>(null);
  final Rx<UserModel?> _userModel = Rx<UserModel?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;
  final RxBool _isInitialized = false.obs;

  User? get user => _user.value;
  UserModel? get userModel => _userModel.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  bool get isAuthenticated => _user.value != null;

  @override
  void onInit() {
    super.onInit();
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authService.authStateChange.listen((firebaseUser) async {
      _user.value = firebaseUser;

      if (firebaseUser != null) {
        _userModel.value =
        await _authService.firestoreService.getUser(firebaseUser.uid);
      } else {
        _userModel.value = null;
      }

      _isInitialized.value = true;
    });
  }

  Future<void> login(String email, String password) async {
    try {
      _isLoading.value = true;
      _userModel.value =
      await _authService.signInwithEmailAndPassword(email, password);
      Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar("Error", _error.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> register(
      String email, String password, String name) async {
    try {
      _isLoading.value = true;
      _userModel.value =
      await _authService.registerInwithEmailAndPassword(
          email, password, name);
      Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar("Error", _error.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    Get.offAllNamed(AppRoutes.login);
  }


  Future<void> deleteaccount() async {
    await _authService.deleteAccount();
    Get.offAllNamed(AppRoutes.login);
  }
}
