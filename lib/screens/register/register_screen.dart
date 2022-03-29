import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/screens/home/home_screen.dart';
import 'package:scholar_chat/screens/login/login.dart';
import 'package:scholar_chat/screens/register/cubit/register_cubit.dart';
import 'package:scholar_chat/screens/register/cubit/register_states.dart';
import 'package:scholar_chat/shared/components/component.dart';
import 'package:scholar_chat/shared/components/constant.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  static String id = 'RegisterScreen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context, state) {
          if(state is CreateUserSuccessState)
          {
            showToast(
              message: 'Register Successfully',
              state: ToastStates.SUCCESS
            );
            //navigateAndFinish(context, HomeScreen());
            Navigator.pushNamed(context, 'HomeScreen',arguments: emailController.text);
          }
          if(state is CreateUserErrorState)
          {
            showToast(
              message: state.error,
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
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
                        const SizedBox(height: 40,),
                        Row(
                          children: const[
                            Text('Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        defaultTextFormField(
                          controller: nameController,
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return'Name must be not empty';
                            }
                            else {return null;}
                          },
                          prefix: Icons.person,
                          label: 'Full Name',
                          inputType: TextInputType.text,
                        ),
                        const SizedBox(height: 15,),
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
                          isPassword: RegisterCubit.get(context).isPassword,
                          suffix: RegisterCubit.get(context).suffixIcon,
                          onSuffixPressed: (){
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                          label: 'Password',
                          inputType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 15,),
                        defaultTextFormField(
                          controller: phoneController,
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return'Phone must be not empty';
                            }
                            else {return null;}
                          },
                          prefix: Icons.phone,
                          label: 'Phone',
                          inputType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20,),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (BuildContext context) => defaultButton(
                              text: 'register',
                              onPressed: () {
                                if(formKey.currentState!.validate())
                                {
                                  RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
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
                            const Text("Already have an account? ",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                              ),
                            ),
                            defaultTextButton(
                              function: (){navigateAndFinish(context, LoginScreen());},
                              text: 'login',
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
