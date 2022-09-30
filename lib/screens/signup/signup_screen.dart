import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants.dart';
import '../../cubits/signup/signup_cubit.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../widgets/widget.dart';
import '../home/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static const String routeName = '/signup';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) =>
          const SignupScreen(),
    );
  }

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _validatorKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Sign Up', isWishlist: false),
      body: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          return LayoutBuilder(
              builder: (context, constraints){
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _validatorKey,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  CustomAuthTextFormField(
                                    title: 'Email',
                                    onChanged: (value) {
                                      context.read<SignupCubit>().userChanged(
                                        state.user!.copyWith(email: value),
                                      );
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Email';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomAuthTextFormField(
                                    title: 'Full Name',
                                    onChanged: (value) {
                                      context.read<SignupCubit>().userChanged(
                                          state.user!.copyWith(fullName: value)
                                      );
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Email';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomAuthTextFormField(
                                    title: 'Country',
                                    onChanged: (value) {
                                      context.read<SignupCubit>().userChanged(
                                        state.user!.copyWith(country: value),);
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Email';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomAuthTextFormField(
                                    title: 'City',
                                    onChanged: (value) {
                                      context.read<SignupCubit>().userChanged(
                                        state.user!.copyWith(city: value),
                                      );
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Email';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomAuthTextFormField(
                                    title: 'address',
                                    onChanged: (value) {
                                      context.read<SignupCubit>().userChanged(
                                        state.user!.copyWith(address: value),
                                      );
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Email';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomAuthTextFormField(
                                    title: 'ZIP Code',
                                    onChanged: (value) {
                                      context.read<SignupCubit>().userChanged(
                                        state.user!.copyWith(zipCode: value),
                                      );
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Email';
                                      }
                                      return null;
                                    },
                                  ),

                                  CustomAuthPasswordFormField(
                                    title: 'Password',
                                    onChanged: (value) {
                                      context.read<SignupCubit>().passwordChanged(
                                          value);
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Password';
                                      }
                                      return null;
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(kMainColor)),

                          onPressed: () {

                            if (_validatorKey.currentState!.validate()) {
                              context.read<SignupCubit>().signUpWithCredentials();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, HomeScreen.routeName, (Route<
                                  dynamic> route) => false);
                            }else{
                              const SnackBar(duration: Duration(seconds: 1),
                                content: Text('Please Fill all fields'),
                              );
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                  ],
                );

              }
          );
        },
      ),
    );
  }
}