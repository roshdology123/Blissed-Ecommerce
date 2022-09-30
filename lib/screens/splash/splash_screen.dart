import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../blocs/auth/auth_bloc.dart';
import '../../core/constants.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 1),
          () =>
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false),
    );


    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous,current) {
      return previous.authUser != current.authUser || current.authUser ==null;
      },
      listener: (context, state) {
        print('Splash screen listener: $state');
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 250,
                  height: 250,
                ),
              ),
              Container(
                color: kMainColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'My Work is pure.',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
