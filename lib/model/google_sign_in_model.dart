import 'package:google_sign_in/google_sign_in.dart';
class GoogleAuthModel {

  static final _googleSignIn = GoogleSignIn(scopes: [
    'https://mail.google.com/'
  ]);

  static Future<GoogleSignInAccount?> signIn() async {

    if(await _googleSignIn.isSignedIn()) {

      return _googleSignIn.currentUser;

    } else {
      return _googleSignIn.signIn();
    }
  }

  static Future signOut1() async {
    return await _googleSignIn.signOut();
  }

}