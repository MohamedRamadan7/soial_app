import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/modules/social_app/login/cubit/cubit.dart';
import 'package:untitled/modules/social_app/login/cubit/states.dart';
import 'package:untitled/modules/social_app/register/social_register_screen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if (state is SocialLoginSuccessState) {
            print(state.uId);
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, SocialLayout());
            });
            navigateAndFinish(context, SocialLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.blue),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Image.asset('assets/imges/Layer 2-mdpi.png'),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'Login now to communicate with friends',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          // TextfieldGray(
                          //     controller: emailController,
                          //   type:  TextInputType.emailAddress,
                          //   validation: (String value)
                          //   {
                          //     if(value.isEmpty)
                          //     {
                          //       return ' Enter your Email Address';
                          //     }
                          //   },
                          //   hintText:'Email Address',
                          // ),
                          defaultFormFiled(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return ' Enter your Email Address';
                              }
                            },
                            lable: 'Email Address',
                            fixIcon: Icons.email,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaultFormFiled(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validation: (String value) {
                                if (value.isEmpty) {
                                  return 'Password is too short';
                                }
                              },
                              lable: 'Password',
                              fixIcon: Icons.lock,
                              suffix: SocialLoginCubit.get(context).suffix,
                              ispassword:
                                  SocialLoginCubit.get(context).isPassword,
                              sufixpressd: () {
                                SocialLoginCubit.get(context)
                                    .ChangePasswordVisibility();
                              },
                              onsumit: (value) {
                                if (formkey.currentState!.validate()) {
                                  // SocialLoginCubit.get(context).userLogin(
                                  //     email: emailController.text,
                                  //     password: passwordController.text);
                                  // print('email ${emailController.text}');
                                  // print('pass ${passwordController.text}');
                                }
                              }),
                          SizedBox(
                            height: 30.0,
                          ),
                          state is! SocialLoginLoadingState
                              ? defaultButton(
                                  function: () {
                                    if (formkey.currentState!.validate()) {
                                      SocialLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                      print('email ${emailController.text}');
                                      print('pass ${passwordController.text}');
                                    }
                                  },
                                  text: 'login',
                                  isUberCase: true)
                              : Center(child: CircularProgressIndicator()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don \'t have account?'),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, SocialRegisterScreen());
                                },
                                child: Text('REGISTER'),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
