import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../core/constants.dart';
import '../../cubits/login/login_cubit.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../repositories/user/user_repository.dart';
import '../../widgets/widget.dart';
import '../home/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  static const String routeName = '/user';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => BlocProvider<UserBloc>(
              create: (context) => UserBloc(
                authBloc: BlocProvider.of<AuthBloc>(context),
                userRepository: context.read<UserRepository>(),
              )..add(
                  LoadUser(context.read<AuthBloc>().state.authUser),
                ),
              child: const UserScreen(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            );
          }
          if (state is UserLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CUSTOMER INFORMATION',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    title: 'Email',
                    initialValue: state.user.email,
                    onChanged: (value) {
                      context.read<UserBloc>().add(
                            UpdateUser(
                              user: state.user.copyWith(email: value),
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    title: 'Full Name',
                    initialValue: state.user.fullName,
                    onChanged: (value) {
                      context.read<UserBloc>().add(
                            UpdateUser(
                              user: state.user.copyWith(fullName: value),
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    title: 'Address',
                    initialValue: state.user.address,
                    onChanged: (value) {
                      context.read<UserBloc>().add(
                            UpdateUser(
                              user: state.user.copyWith(address: value),
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    title: 'City',
                    initialValue: state.user.city,
                    onChanged: (value) {
                      context.read<UserBloc>().add(
                            UpdateUser(
                              user: state.user.copyWith(city: value),
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    title: 'Country',
                    initialValue: state.user.country,
                    onChanged: (value) {
                      context.read<UserBloc>().add(
                            UpdateUser(
                              user: state.user.copyWith(country: value),
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    title: 'ZIP Code',
                    initialValue: state.user.zipCode,
                    onChanged: (value) {
                      context.read<UserBloc>().add(
                            UpdateUser(
                              user: state.user.copyWith(zipCode: value),
                            ),
                          );
                    },
                  ),
                  Expanded(child: Container()),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthRepository>().signOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomeScreen.routeName,
                                (Route<dynamic> route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: kMainColor,
                        fixedSize: const Size(200, 40),
                      ),
                      child: Text(
                        'Sign Out',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is UserUnauthenticated) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'You are not logged in!',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(), backgroundColor: kMainColor,
                    fixedSize: const Size(200, 40),
                  ),
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                    context.read<AuthRepository>().signOut();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(), backgroundColor: Colors.white,
                    fixedSize: const Size(200, 40),
                  ),
                  child: Text(
                    'Signup',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),

                _GoogleLoginButton()
              ],
            );
          } else {
            return const Text('WTF');
          }
        },
      ),
    );
  }
}


class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(FontAwesomeIcons.google),
          onPressed: () {
            context.read<LoginCubit>().logInWithGoogle();
            Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.routeName,
                    (Route<dynamic> route) => false);
          },
          style: IconButton.styleFrom(
            shape: const RoundedRectangleBorder(),
          backgroundColor: Colors.white,
            fixedSize: const Size(200, 40),
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<LoginCubit>().logInWithGoogle();
            Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.routeName,
                    (Route<dynamic> route) => false);
          },
          child: Text(
            'Sign In with Google',
            style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
