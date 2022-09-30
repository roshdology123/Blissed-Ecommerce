import 'package:blissed_ecommerce/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants.dart';
import '../../cubits/cubits.dart';

import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) =>LoginScreen(),
    );
  }

  final _validatorKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Login', isWishlist: false),
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      child: Form(
                        key: _validatorKey,
                        child: Column(
                          children: [
                            CustomAuthTextFormField(
                              title: 'Email',
                              onChanged: (value) {
                                context.read<LoginCubit>().emailChanged(value);
                                print(value);
                              },
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Enter Email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            LoginPasswordFormField(
                              title: 'Password',
                              onChanged: (value) {
                                context
                                    .read<LoginCubit>()
                                    .passwordChanged(value);
                                print(value);
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
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kMainColor)),
                    onPressed: () {
                      if (_validatorKey.currentState!.validate()) {
                        context.read<LoginCubit>().logInWithCredentials();
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomeScreen.routeName,
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: Text(
                      'Log In',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

            ],
          );
        },
      ),
    );
  }
}

