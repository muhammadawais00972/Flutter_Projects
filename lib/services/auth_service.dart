
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/models/user_model.dart';
import 'package:flashchat/services/firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  FirestoreService get firestoreService => _firestoreService;
  User? get currentUser => _auth.currentUser;
  String? get currentUserId => _auth.currentUser?.uid;
  Stream<User?> get authStateChange => _auth.authStateChanges();


  Future<UserModel?> signInwithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result =
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      if (user == null) return null;

      await _firestoreService.updateUserOnlineStatus(user.uid, true);

      return await _firestoreService.getUser(user.uid);
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }


  Future<UserModel> registerInwithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      UserCredential result =
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = result.user!;

      await user.updateDisplayName(displayName);

      final userModel = UserModel(
        id: user.uid,
        email: email,
        displayName: displayName,
        photoURL: '',
        isOnline: true,
        lastSeen: DateTime.now(),
        createdAt: DateTime.now(),
      );

      await _firestoreService.createUser(userModel);
      return userModel;
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }


  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }


  Future<void> signOut() async {
    if (currentUser != null) {
      await _firestoreService.updateUserOnlineStatus(
          currentUserId!, false);
    }
    await _auth.signOut();
  }


  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestoreService.deleteUser(user.uid);
      await user.delete();
    }
  }
}
