
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/models/chat_users.dart';
import 'package:scholar_chat/screens/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
})
  {
    print('Hello');
    emit(RegisterLoadingState());
     FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
    ).then((value){
       userCreate(
         uId: value.user!.uid,
         phone: phone,
         email: email,
         name: name,
       );
     }).catchError((error){
       emit(RegisterErrorState(error.toString()));
     });
  }
  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    print('hello bro...');
    ChatUsers model = ChatUsers(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value)
    {
      emit(CreateUserSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}