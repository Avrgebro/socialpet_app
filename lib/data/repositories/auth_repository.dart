import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:socialpet/config/constants/app_constants.dart';
import 'package:socialpet/data/providers/auth_provider.dart';
import 'package:socialpet/data/providers/user_provider.dart';
import 'package:socialpet/utils/enums/socials.dart';
import 'package:socialpet/utils/helpers/apple_sign_in_helper.dart';
import 'package:socialpet/data/models/user.dart' as AppUser;
import 'package:socialpet/utils/helpers/user_credentials_helper.dart';
import 'package:socialpet/utils/services/secure_storage_service.dart';

class AuthRepository {

  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;


  /// Sign in wuth google method
  Future<UserCredential> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
    

  }

  /// Sign in with facebook method
  Future<UserCredential> signInWithFacebook() async {

    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return _firebaseAuth.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithApple() async {

    final rawNonce = AppleSignInHelpers.generateNonce();
    final nonce = AppleSignInHelpers.sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    return await _firebaseAuth.signInWithCredential(oauthCredential);
  }

  /// Sign in with email and password
  Future<UserCredential?> signInWithCredentials(UserCredentials credentials) async {

    try {

      return await _firebaseAuth.signInWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password
      );

    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
    }

  }

  Future<UserCredential> signUp(String email, String password) async {
    
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

  }

  Future<void> signOut() async {
    await AuthProvider.logOutUser();
    await SecureStorage.deleteValue(AppConstants.tokenKey);
    return await _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser;
    final oAuthSet = await SecureStorage.hasKey(AppConstants.tokenKey);
    return currentUser != null && oAuthSet;
  }

  Future<String> signedInUuid() async {
    return await _firebaseAuth.currentUser!.uid;
  }

  Future<User> signedInFirebaseUser() async {
    return await _firebaseAuth.currentUser!;
  }

  Future<AppUser.User?> oAuthLogin(UserCredentials credentials) async {
    
    try {
      final Map<String, dynamic>? loginData = await AuthProvider.logInUser(credentials);
      if(loginData != null) {
        if(loginData.isNotEmpty){
          SecureStorage.setValue(AppConstants.tokenKey , loginData['token']);
          return AppUser.User.fromMap(loginData['user'] as Map<String, dynamic>);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<AppUser.User?> registerUser(Map<String, dynamic> userData) async {
    try {
      final Map<String, dynamic>? registerData = await AuthProvider.registerUser(userData);
      if(registerData != null) {
        if(registerData.isNotEmpty){
          print(registerData);
          SecureStorage.setValue(AppConstants.tokenKey , registerData['token']);
          return AppUser.User.fromMap(registerData['user'] as Map<String, dynamic>);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteUserFromFirebase(String email) async {
    try {
      final response = await _firebaseAuth.currentUser!.delete();
    } catch (e) {
      print('auth_repository:151 - ' + e.toString());
    }
  }

  Future<AppUser.User?> oAuthSocialLogin(String email, String uuid) async {
    final Map<String, dynamic>? loginData = await AuthProvider.logInUserWithSocial(email, uuid);

    if(loginData != null) {
      SecureStorage.setValue(AppConstants.tokenKey , loginData['token']);
      return AppUser.User.fromMap(loginData['user'] as Map<String, dynamic>);
    } else {
      return null;
    }

  }

  Future<AppUser.User?> getAuthenticatedUser() async {
    
    final Map<String, dynamic>? rawData = await UserProvider.fetchUser();
    if(rawData != null) {
      return AppUser.User.fromMap(rawData);
    } else {
      return null;
    }
    
  }


}