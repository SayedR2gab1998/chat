import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/screens/home/home_screen.dart';
import 'package:scholar_chat/screens/login/cubit/login_cubit.dart';
import 'package:scholar_chat/screens/login/cubit/login_states.dart';
import 'package:scholar_chat/screens/register/register_screen.dart';
import 'package:scholar_chat/shared/components/component.dart';
import 'package:scholar_chat/shared/components/constant.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  static String id = 'LoginScreen';

   @override

  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState)
            {
              showToast(
                message: 'Login Successfully',
                state: ToastStates.SUCCESS,
              );
              Navigator.pushNamed(context, 'HomeScreen',arguments: emailController.text);
            }
          if(state is LoginErrorState)
          {
            showToast(
              message: state.error,
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context,state){
          return Scaffold(
            backgroundColor: kPrimaryColor,
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children:
                      [
                        Image.asset('assets/images/scholar.png'),
                        const Text('Scholar Chat',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: 'Pacifico'
                          ),
                        ),
                        const SizedBox(height: 100,),
                        Row(
                          children: const[
                            Text('Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        defaultTextFormField(
                          controller: emailController,
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return'Email must be not empty';
                            }
                            else {return null;}
                          },
                          prefix: Icons.email_outlined,
                          label: 'Email',
                          inputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15,),
                        defaultTextFormField(
                          controller: passwordController,
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return'password must be not empty';
                            }
                            else {return null;}
                          },
                          prefix: Icons.lock,
                          isPassword: LoginCubit.get(context).isPassword,
                          suffix: LoginCubit.get(context).suffixIcon,
                          onSuffixPressed: (){
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          label: 'Password',
                          inputType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 20,),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (BuildContext context) => defaultButton(
                              text: 'login',
                              onPressed: () {
                                if(formKey.currentState!.validate())
                                {
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }
                          ),
                          fallback: (BuildContext context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            const Text("Don't have an account? ",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                              ),
                            ),
                            defaultTextButton(
                              function: (){
                                navigateAndFinish(context, RegisterScreen());
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

