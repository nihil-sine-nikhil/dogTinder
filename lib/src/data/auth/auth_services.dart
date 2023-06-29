import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/constants/app_constants.dart';
import '../../app/navigation/router.dart';
import '../../app/navigation/routes.dart';
import '../api/services/api_base_services.dart';
import '../user/model/user_model.dart';

class AuthenticationServices {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  String? _uid;
  String? get uid => _uid;
  final FirebaseStorage _fbStorage = FirebaseStorage.instance;
  final FirebaseFirestore _fbFireStore = FirebaseFirestore.instance;

  /// CHECKING WHETHER SIGNED IN OR NOT
  Future<bool> checkSignedIn() async {
    final SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    if (_sharedPref.getBool(AppConstant.spIsSignedIn) == true) {
      return true;
    }
    return false;
  }

  Future setSignin() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(AppConstant.spIsSignedIn, true);

    _isSignedIn = true;
  }

  Future<CustomResponse> signInWithPhone(String _phone) async {
    CustomResponse _response =
        CustomResponse(status: true, msg: "OTP is sent to $_phone");
    Completer<CustomResponse> _completer = Completer<CustomResponse>();

    try {
      await _fbAuth.verifyPhoneNumber(
          phoneNumber: '+91$_phone',
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            phoneAuthCredential.smsCode;
            User? user =
                (await _fbAuth.signInWithCredential(phoneAuthCredential)).user;

            if (user != null) {
              // userID is stored to a variable and then saved to shared preference
              SharedPreferences sp = await SharedPreferences.getInstance();
              sp.setString(AppConstant.spUserID, user.uid);
              sp.setInt(AppConstant.spPhone, int.parse(_phone));
              // now we check if the user exists or not in FireStore
              checkExistingUser();
            } else {
              if (kDebugMode) {
                print("User is null");
              }
            }
          },
          verificationFailed: (FirebaseAuthException error) {
            if (error.code == 'network-request-failed') {
              _response.status = false;
              _response.msg = 'Check your internet connection & try again.';
              _completer.complete(_response);
            } else {
              _response.status = false;
              _response.msg = 'The provided number is not valid.';
              print('kException 113 ${error.code}');
              print('kException 113 $error');

              _completer.complete(_response);
            }

            // TODO: unhandled exception here

            throw Exception(error.message);
          },
          codeSent: (verificationCode, forceResendingToken) {
            AppRouter.navigateTo(
              '/verify-phone/$verificationCode/$_phone',
            );
          },
          codeAutoRetrievalTimeout: (verificationCode) {});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-phone-number') {
        _response.status = false;
        _response.msg = 'Oops! This phone number is not valid.';
        _completer.complete(_response);
      } else {
        _response.status = false;
        _response.msg = 'Something went wrong. Try again later.';
        print('kException 135 ${e.message}');
        _completer.complete(_response);
      }
    }
    return _completer.future;
  }

  Future<CustomResponse> verifyOTP(
    String _otp,
    String _verificationID,
  ) async {
    CustomResponse _response =
        CustomResponse(status: true, msg: "OTP is successfully verified");

    try {
      PhoneAuthCredential cred = PhoneAuthProvider.credential(
          verificationId: _verificationID, smsCode: _otp);
      User? user = (await _fbAuth.signInWithCredential(cred)).user;
      if (user != null) {
        _uid = user.uid;
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString(AppConstant.spUserID, user.uid);
        sp.setInt(
            AppConstant.spPhone, int.parse((user.phoneNumber)!.substring(3)));
        checkExistingUser();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        _response.status = false;
        _response.msg = "Oops! The OTP isn't valid. Try again!";
      } else if (e.code == 'invalid-verification-id') {
        _response.status = false;
        _response.msg = "Invalid verification ID";
      } else {
        print("kException 172 ${e.message}");
        print("kException 172 ${e.hashCode}");
        print("kException 172 ${e.code}");
        _response.status = false;
        _response.msg = e.message;
        return _response;
      }
    }
    return _response;
  }

  /// RESEND OTP
  Future<bool> resendOTP(String _phone) async {
    await _fbAuth.verifyPhoneNumber(
        phoneNumber: '+91$_phone',
        verificationCompleted:
            (PhoneAuthCredential phoneAuthCredential) async {},
        verificationFailed: (error) {},
        codeSent: (verificationCode, forceResendingToken) {},
        codeAutoRetrievalTimeout: (verificationCode) {});

    return true;
  }

  /// END OF RESEND OTP

  /// CHECKING IF ACCOUNT EXISTS
  Future<bool> checkExistingUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString(AppConstant.spUserID);
    DocumentSnapshot snapshot =
        await _fbFireStore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      print('user exists');

      setSignin();

      AppRouter.navigateTo(AppRoutes.homeRoute.route, clearStack: true);
      return true;
    } else {
      print('user does not exists');
      AppRouter.navigateTo(AppRoutes.enterNameScreenRoute.route,
          clearStack: true);

      return false;
    }
  }

  /// end of CHECKING IF ACCOUNT EXISTS

  // store user data

  Future<CustomResponse> createUser(
      UserModel _userModel, File? profilePic) async {
    CustomResponse _response = CustomResponse(status: true, msg: "");
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? _uid = _prefs.getString(AppConstant.spUserID);

      await _fbFireStore
          .collection("users")
          .doc(_uid)
          .set(_userModel.toMap())
          .then((value) async {
        _prefs.setString(AppConstant.spName, _userModel.name!);
        setSignin();
        _response.status = true;
        _response.msg = 'User created successfully ';
      });
    } on FirebaseAuthException catch (e) {
      print('kError 231 $e');
      _response.status = false;
      _response.msg = e.message;
    }
    return _response;
  }

  /// creating empty documents
  Future<void> createCollectionWithEmptyDoc(
    String doc1,
    String collectionName,
    String doc2,
  ) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(doc1)
        .collection(collectionName)
        .doc(doc2)
        .set({});
  }

  ///

  Future userSignOut() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    await _fbAuth.signOut();
  }

  Future<UserModel> loadUserProfile() async {
    try {
      var snapshot = await _fbFireStore
          .collection('users')
          .doc(_fbAuth.currentUser!.uid)
          .get();

      var data = snapshot.data();

      var details = UserModel.fromMap(data!);

      return details;
    } catch (e) {
      print('kError 346 $e');
      return UserModel();
    }
  }

  Future<CustomResponse> editProfile(
    UserModel _userModel,
  ) async {
    CustomResponse _response = CustomResponse(status: true, msg: "");
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? _uid = _prefs.getString(AppConstant.spUserID);
      await _fbFireStore
          .collection("users")
          .doc(_uid)
          .update({'name': _userModel.name}).then((value) async {
        _response.status = true;
        _response.msg = 'Name Updated Successfully';
      }).catchError((error) {
        print('kError 316 $error');
        _response.status = false;
        _response.msg = error.message;
      });
    } on FirebaseAuthException catch (e) {
      print('kError 321 $e');
      _response.status = false;
      _response.msg = e.message;
    }
    return _response;
  }
}
