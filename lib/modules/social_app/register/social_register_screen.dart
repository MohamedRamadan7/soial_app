import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/modules/social_app/otp/otp_screen.dart';
import 'package:untitled/modules/social_app/register/cubit/cubit.dart';
import 'package:untitled/modules/social_app/register/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';


class SocialRegisterScreen extends StatelessWidget {
  var formkey =GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(),
    // );

    return BlocProvider(

      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context ,state)
        {
          if(state is SocialCreateUserSuccessState)
          {
            navigateAndFinish(context, SocialLayout());
          }
        },
        builder: (context ,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFiled(
                          controller: nameController,
                          type: TextInputType.emailAddress,
                          validation: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return ' Enter your Name';
                            }
                          },
                          lable:'Name',
                          fixIcon: Icons.person,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFiled(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validation: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return ' Enter your Email Address';
                            }
                          },
                          lable:'Email Address',
                          fixIcon: Icons.email,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFiled(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validation: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'Password is too short';
                              }
                            },
                            lable:'Password',
                            fixIcon: Icons.lock,
                            suffix: SocialRegisterCubit.get(context).suffix,
                            ispassword: SocialRegisterCubit.get(context).isPassword,
                            sufixpressd: ()
                            {
                              SocialRegisterCubit.get(context).ChangePasswordVisibility();
                            },
                            onsumit: (value)
                            {
                            }
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFiled(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validation: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return ' Enter your Phone';
                            }
                          },
                          lable:'Phone',
                          fixIcon: Icons.phone,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        state is! SocialRegisterLoadingState ? defaultButton(
                            function: ()
                            {
                              if(formkey.currentState!.validate())
                              {
                                // SocialRegisterCubit.get(context).submitPhoneNumber(phoneController.text);
                                // navigateTo(context, OtpScreen(phoneNumber: phoneController.text,));
                                SocialRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                                print('name ${nameController.text}');
                                print('email ${emailController.text}');
                                print('pass ${passwordController.text}');
                                print('phone ${phoneController.text}');

                              }
                            },
                            text: 'REGISTER',
                            isUberCase: true
                        ): Center(child: CircularProgressIndicator()),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //         'Don \'t have account?'
                        //     ),
                        //     TextButton(
                        //       onPressed: ()
                        //       {
                        //         navigateTo(context,ShopRegisterScreen());
                        //       },
                        //       child: Text(
                        //           'REGISTER'
                        //       ),),
                        //   ],
                        // )
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
