
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/social_app.dart';
import 'package:untitled/modules/social_app/register/cubit/states.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context)=> BlocProvider.of(context);


  void userRegister({
  required String email,
  required String password,
    required String name,
    required String phone,
})
  {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
          uId:value.user!.uid,
          name: name,
          email:email ,
          phone: phone,
      );
    }).catchError((error){
      emit(SocialRegisterErrorState(error.toString()));

    });
  }
  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,

  })
  {
    SocialUserModel model =SocialUserModel(
      name:name,
      email:email ,
      phone:phone ,
      uId: uId,
      image: 'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1650812434~exp=1650813034~hmac=45ca8003a54de2c4049d95bcb334d9f201af910850e41026aec20af9e12cf319&w=740',
      cover: 'https://img.freepik.com/free-photo/muslim-family-having-ramadan-feast_53876-7870.jpg?w=740',
      bio: 'write your bio ...',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          print ('user is : $uId');
          emit(SocialCreateUserSuccessState());

    }).catchError((error) {
      print ('error is : ${error.toString()}');
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }


  // late String verificationId;
  //
  // Future<void> submitPhoneNumber(String phoneNumber) async {
  //   emit(Loading());
  //
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: '+2$phoneNumber',
  //     timeout: const Duration(seconds: 14),
  //     verificationCompleted: verificationCompleted,
  //     verificationFailed: verificationFailed,
  //     codeSent: codeSent,
  //     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  //   );
  // }
  //
  // void verificationCompleted(PhoneAuthCredential credential) async {
  //   print('verificationCompleted');
  //   await signIn(credential);
  // }
  //
  // void verificationFailed(FirebaseAuthException error) {
  //   print('verificationFailed : ${error.toString()}');
  //   emit(ErrorOccurred(errorMsg: error.toString()));
  // }
  //
  // void codeSent(String verificationId, int? resendToken) {
  //   print('codeSent');
  //   this.verificationId = verificationId;
  //   emit(PhoneNumberSubmited());
  // }
  //
  // void codeAutoRetrievalTimeout(String verificationId) {
  //   print('codeAutoRetrievalTimeout');
  // }
  //
  // Future<void> submitOTP(String otpCode) async {
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: this.verificationId, smsCode: otpCode);
  //
  //   await signIn(credential);
  // }
  //
  // Future<void> signIn(PhoneAuthCredential credential) async {
  //   try {
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //     emit(PhoneOTPVerified());
  //     print('done');
  //   } catch (error) {
  //     emit(ErrorOccurred(errorMsg: error.toString()));
  //   }
  // }
  //
  // Future<void> logOut() async {
  //   await FirebaseAuth.instance.signOut();
  // }
  //
  // User getLoggedInUser() {
  //   User firebaseUser = FirebaseAuth.instance.currentUser!;
  //   return firebaseUser;
  // }


  IconData suffix= Icons.visibility;
  bool isPassword=true;

  void ChangePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix= isPassword? Icons.visibility_off_outlined :Icons.visibility;
    emit(SocialChangeRegisterPasswordVisibilityState());
  }

}