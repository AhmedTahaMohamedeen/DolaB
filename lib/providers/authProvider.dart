
// ignore_for_file: file_names, avoid_debugPrint, constant_identifier_names, unnecessary_null_comparison

// ignore: import_of_legacy_library_into_null_safe
import 'package:adminappp/Screens/home/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:shared_preferences/shared_preferences.dart';




enum AuthStatus{unAuthenticated,Authenticated,loading}
class AuthProvider with ChangeNotifier{
  String email='';
  String password='';
  final FirebaseAuth _auth=FirebaseAuth.instance;
  User? _user;
  User? get user=> _user;
  AuthStatus _authStatus=AuthStatus.unAuthenticated;
  String?  error;
  AuthStatus get authStatus=>_authStatus;

  String phone='';




  auth(){

    _auth.authStateChanges().listen((User? user) {
      if (user==null){print(' AuthProvider user=null');}
      else{_user=user;print('AuthProvider user=$user');}
      debugPrint('AuthProvider  done');
      notifyListeners();
    });
  }

  Future<bool>logIn()async{
    try{


       await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) =>  _user=value.user);

      setPref(email,password);
      debugPrint('login done');



      notifyListeners();
      return true;

    }on FirebaseException catch(e){
      if(e.code=='invalid-email'){error='invalid-email';}
      if(e.code=='user-disabled'){error='user-disabled';}
      if(e.code=='user-not-found'){error='user-not-found';}
      if(e.code=='wrong-password'){error='wrong-password';}
      else{debugPrint(e.toString());}
debugPrint('no');
      _authStatus=AuthStatus.unAuthenticated;
      notifyListeners();

      return false;
    }
  }

  Future <bool>register()async{

    try{

      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _authStatus=AuthStatus.Authenticated;


      notifyListeners();

      return true;


    } on FirebaseException  catch(e){
      if(e.code=='weak-password'){error='weak_password';}
      if(e.code=='email-already-in-use'){error='email-already-in-use';}
      if(e.code=='invalid-email'){error='invalid-email';}
      _authStatus=AuthStatus.unAuthenticated;

      notifyListeners();

      return false;

    }
  }

  logout()async{
    await _auth.signOut();
    _authStatus=AuthStatus.unAuthenticated;
    removePref();
    debugPrint('logged out');

    notifyListeners();
  }

  Future sendLink()async{

    if( !user!.emailVerified){await user!.sendEmailVerification();debugPrint('email sent');} else{error='you are already verified';}

    notifyListeners();

  }

  loginAnonymously()async{
    await _auth.signInAnonymously();
    _authStatus=AuthStatus.Authenticated;
    notifyListeners();
  }

  forgetPassword()async{
    var x=await _auth.sendPasswordResetEmail(email: email,);
    var x2=await _auth.confirmPasswordReset(code: '', newPassword: '');
  }





  setPref(email,password)async {
    var pref=await SharedPreferences.getInstance();
    pref.setBool('login',true);
    pref.setString('email', email);
    pref.setString('password', password);
    debugPrint('prefs has been created');


  }
  getPref()async{
    var pref=await SharedPreferences.getInstance();
    email=pref.getString('email')!;
    password=pref.getString('password')!;
    debugPrint('get pref done');

  }









  removePref()async{
    var pref=await SharedPreferences.getInstance();


    pref.remove('login');
    pref.remove('email');
    pref.remove('password');
    debugPrint('prefs deleted');
  }





setPrefPhone()async{
  var pref=await SharedPreferences.getInstance();
  pref.setBool('login', true);
  pref.setString('id', _user!.uid);
  debugPrint('Phone prefs added ');

}

removePrefPhone()async{
  var pref=await SharedPreferences.getInstance();
  pref.remove('login');
  pref.remove('id');

  debugPrint('prefs deleted');

}






 authWithPhone0( {required String phone,required BuildContext context})async{




      await _auth.verifyPhoneNumber(
        phoneNumber: '+2$phone',




        verificationCompleted: (PhoneAuthCredential credential) async{
          print('iam in completed');
          _auth.signInWithCredential(credential).then((value) =>_user= value.user);
         if(_user!=null){ Navigator.pushNamed(context, Home.route);}







        },



        verificationFailed: (FirebaseAuthException e) {
          print('iam in failed');
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },




        codeSent: (String verificationId, int? resendToken) async{


        },
        timeout: const Duration(seconds: 60),






        codeAutoRetrievalTimeout: (String verificationId) {
          print('iam in timeout');
        },
      );








  }


























/* Future<UserCredential> signInWithGoogle() async {

    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();


    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;


    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    return await FirebaseAuth.instance.signInWithCredential(credential);
  }*/





/*  Future<UserCredential> signInWithFacebook() async {

    final LoginResult loginResult = await FacebookAuth.instance.login();


    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);


    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }*/




}

/*

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthProvider2 bota=AuthProvider2();
  SharedPreferences pref=await SharedPreferences.getInstance();
  bool login=pref.getBool('login');
  String screen;
  if (login=true){
    if(await bota.logIn(email: pref.getString('email'),password: pref.getString('password'))){screen=Home.route;}else{screen=FirstScreen.route;}
  }else{screen=FirstScreen.route;}


  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(),),
        ChangeNotifierProvider(create: (_) => FireProvider(),),
      ],


      child:


      MyApp( screen: screen, )



  ));
}

class MyApp extends StatefulWidget {
final String screen;
MyApp({this.screen});

  @override
  _MyAppState createState() => _MyAppState();
}

  */



/*
  provider:
  firebase_core: "0.7.0"
  firebase_auth: ^0.20.1
 */

class Auth{
  String email='';
  String password='';
  final FirebaseAuth _auth=FirebaseAuth.instance;
  User? _user;
  User? get user=> _user;

  String?  error;


  String phone='';




  auth(){

    _auth.authStateChanges().listen((User? user) {
      if (user==null){print('user1=null');}
      else{_user=user;print('user1=$user');}
      debugPrint('auth done');

    });
  }

  Future<bool>logIn()async{
    try{


      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) =>  _user=value.user);

      setPref(email,password);
      debugPrint('login done');




      return true;

    }on FirebaseException catch(e){
      if(e.code=='invalid-email'){error='invalid-email';}
      if(e.code=='user-disabled'){error='user-disabled';}
      if(e.code=='user-not-found'){error='user-not-found';}
      if(e.code=='wrong-password'){error='wrong-password';}
      else{debugPrint(e.toString());}




      return false;
    }
  }

  Future <bool>register()async{

    try{

      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) =>  _user=value.user);





      return true;


    } on FirebaseException  catch(e){
      if(e.code=='weak-password'){error='weak_password';}
      if(e.code=='email-already-in-use'){error='email-already-in-use';}
      if(e.code=='invalid-email'){error='invalid-email';}



      return false;

    }
  }

  logout()async{
    await _auth.signOut();
    removePref();
    debugPrint('logged out');


  }

  Future sendLink({User? user})async{

    if( !user!.emailVerified){await user.sendEmailVerification();debugPrint('email sent');} else{error='you are already verified';}



  }

  loginAnonymously()async{
    await _auth.signInAnonymously();

  }

  forgetPassword()async{
    var x=await _auth.sendPasswordResetEmail(email: email,);
    var x2=await _auth.confirmPasswordReset(code: '', newPassword: '');
  }





  setPref(email,password)async {
    var pref=await SharedPreferences.getInstance();
    pref.setBool('login',true);
    pref.setString('email', email);
    pref.setString('password', password);
    debugPrint('prefs has been created');


  }
  getPref()async{
    var pref=await SharedPreferences.getInstance();
    email=pref.getString('email')!;
    password=pref.getString('password')!;
    debugPrint('get pref done');

  }









  removePref()async{
    var pref=await SharedPreferences.getInstance();


    pref.remove('login');
    pref.remove('email');
    pref.remove('password');
    debugPrint('prefs deleted');
  }





  setPrefPhone()async{
    var pref=await SharedPreferences.getInstance();
    pref.setBool('login', true);
    pref.setString('id', _user!.uid);
    debugPrint('Phone prefs added ');

  }

  removePrefPhone()async{
    var pref=await SharedPreferences.getInstance();
    pref.remove('login');
    pref.remove('id');

    debugPrint('prefs deleted');

  }






  authWithPhone0( {required String phone,required BuildContext context})async{




    await _auth.verifyPhoneNumber(
      phoneNumber: '+2$phone',




      verificationCompleted: (PhoneAuthCredential credential) async{
        print('iam in completed');
        _auth.signInWithCredential(credential).then((value) =>_user= value.user);
        if(_user!=null){ Navigator.pushNamed(context, Home.route);}







      },



      verificationFailed: (FirebaseAuthException e) {
        print('iam in failed');
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },




      codeSent: (String verificationId, int? resendToken) async{


      },
      timeout: const Duration(seconds: 60),






      codeAutoRetrievalTimeout: (String verificationId) {
        print('iam in timeout');
      },
    );








  }



}









































/*

class Auth{
  String email='';
  String password='';
  final FirebaseAuth _auth=FirebaseAuth.instance;
  User? _user;
  AuthStatus _authStatus=AuthStatus.unAuthenticated;
  String?  error;
  AuthStatus get authStatus=>_authStatus;

  User? get user=> _user;

  String phone='';
  bool goo=false;


  auth(){

    _auth.authStateChanges().listen((User? user) {
      if (user==null){_authStatus==AuthStatus.unAuthenticated;}
      else{_user=user;}
      debugPrint('auth2 done');

    });
  }

  Future<bool>logIn({required String email ,required String password})async{
    try{

      await _auth.signInWithEmailAndPassword(email:email , password:password ).then((value) =>  _user=value.user);
      _authStatus=AuthStatus.Authenticated;


      setPref(email,password);
      debugPrint('login2 done');




      return true;

    }on FirebaseException catch(e){
      if(e.code=='invalid-email'){error='invalid-email';}
      if(e.code=='user-disabled'){error='user-disabled';}
      if(e.code=='user-not-found'){error='user-not-found';}
      if(e.code=='wrong-password'){error='wrong-password';}

      _authStatus=AuthStatus.unAuthenticated;


      return false;
    }
  }

  Future <bool>register()async{

    try{

      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _authStatus=AuthStatus.Authenticated;



      return true;


    } on FirebaseException  catch(e){
      if(e.code=='weak-password'){error='weak_password';}
      if(e.code=='email-already-in-use'){error='email-already-in-use';}
      if(e.code=='invalid-email'){error='invalid-email';}
      _authStatus=AuthStatus.unAuthenticated;



      return false;

    }
  }

  logout()async{
    await _auth.signOut();
    _authStatus=AuthStatus.unAuthenticated;
    removePref();

  }

  Future sendLink()async{

    if( !user!.emailVerified){await user!.sendEmailVerification();} else{error='you are already verified';}


  }

  loginAnonymously()async{
    await _auth.signInAnonymously();
    _authStatus=AuthStatus.Authenticated;

  }



  func()async{





  }


  setPref(email,password)async {
    var pref=await SharedPreferences.getInstance();
    pref.setBool('login',true);
    pref.setString('email', email);
    pref.setString('password', password);
    debugPrint('pref set');


  }
  getPref()async{
    var pref=await SharedPreferences.getInstance();
    email=pref.getString('email')!;
    password=pref.getString('password')!;
    debugPrint('get pref done');

  }









  removePref()async{
    var pref=await SharedPreferences.getInstance();

    debugPrint('pref removed');
    pref.remove('login');
    pref.remove('email');
    pref.remove('password');

  }





}*/
