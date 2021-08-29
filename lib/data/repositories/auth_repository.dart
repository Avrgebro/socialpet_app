import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:socialpet/data/providers/auth_provider.dart';
import 'package:socialpet/data/providers/user_provider.dart';
import 'package:socialpet/utils/helpers/apple_sign_in_helpers.dart';
import 'package:socialpet/data/models/user.dart' as AppUser;
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
  Future<UserCredential?> signInWithCredentials(String email, String password) async {

    try {

      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
    }

  }

  Future<UserCredential> signUp(String email, String password) async {
    
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

  }

  Future<void> signOut() async {
    await SecureStorage.clearStorage();
    await AuthProvider.logOutUser();
    return await _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<String> signedInUuid() async {
    return await _firebaseAuth.currentUser!.uid;
  }

  Future<AppUser.User?> getAuthenticatedUser() async {
    
    final String uuid = await _firebaseAuth.currentUser!.uid;
    final Map<String, dynamic>? rawData = await UserProvider.fetchUser(uuid);
    
    if(rawData != null) {
      return AppUser.User.fromMap(rawData);
    } else {
      return null;
    }
    

  }


}