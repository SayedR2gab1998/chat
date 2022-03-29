import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scholar_chat/models/messages_model.dart';
import 'package:scholar_chat/shared/components/constant.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
        (route) => false);


Widget defaultTextFormField({
  required TextEditingController controller,
  required String? Function(String? value) validator,
  required TextInputType inputType,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? onSuffixPressed,
  Function()? onTap,
  Function(String s)? onSubmit,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: isPassword,
      validator: validator,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 20
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.white
        ),
        prefixIcon: Icon(
          prefix,
          color: Colors.white
          ,
        ),
        suffixIcon: IconButton(icon: Icon(suffix),color: Colors.white,onPressed: onSuffixPressed),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xffc1dde2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),

    );

Widget defaultButton({
  double width = double.infinity, // giv it default width but can edit later
  Color background = Colors.blue,
  double radius = 5.0,
  required String text,
  required Function()? onPressed,
}) =>
    Container(
      width: width,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
          ),
        ),
        onPressed: onPressed,
      ),
    );

Widget defaultTextButton(
    {required Function() function, required String text}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase(),
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xffc1dde2)
        ),
      ),
    );

void showToast({required String message, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}
enum ToastStates {SUCCESS, ERROR, WARNING }

// get hte color of the toast depend on the state
// success, error and warning
Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}


//build chat page Ui
Widget customMessage({
  required MessagesModel message,
})
{
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      padding:const EdgeInsets.only(top: 24,bottom: 24,right: 16,left: 16),
      decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          )
      ),
      child:  Text(message.message,
        style:const TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget customMessageForFriend({
  required MessagesModel message,
})
{
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      padding:const EdgeInsets.only(top: 24,bottom: 24,right: 16,left: 16),
      decoration: const BoxDecoration(
          color: Color(0xff006389),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          )
      ),
      child:  Text(message.message,
        style:const TextStyle(color: Colors.white),
      ),
    ),
  );
}
