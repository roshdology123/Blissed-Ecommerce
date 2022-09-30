import 'package:blissed_ecommerce/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/checkout/checkout_bloc.dart';
import '../../core/constants.dart';
import '../../core/size_config.dart';
import '../../models/models.dart';
import '../order_confirmation/order_confirmation_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);
  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'Checkout',
      ),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CheckoutLoaded) {
              var user = state.checkout.user ?? User.empty;
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CUSTOMER INFORMATION',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        CustomTextFormField(
                          title: 'Email',
                          initialValue: user.email,
                          onChanged: (value) {
                            User user = state.checkout.user!.copyWith(email: value);

                            context.read<CheckoutBloc>().add(
                              UpdateCheckout(
                                user: state.checkout.user!.copyWith(email: value),
                              ),
                            );
                          },
                        ),


                          CustomTextFormField(
                            title: 'Full Name',
                            initialValue: user.fullName,
                            onChanged: (value) {
                              User user =
                              state.checkout.user!.copyWith(fullName: value);

                              context.read<CheckoutBloc>().add(
                                UpdateCheckout(
                                  user: state.checkout.user!
                                      .copyWith(fullName: value),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'DELIVERY INFORMATION',
                            style: Theme.of(context).textTheme.headline3,
                          ),

                          CustomTextFormField(
                            title: 'Address',
                            initialValue: user.address,
                            onChanged: (value) {
                              User user = state.checkout.user!.copyWith(address: value);

                              context.read<CheckoutBloc>().add(
                                UpdateCheckout(
                                  user:
                                  state.checkout.user!.copyWith(address: value),
                                ),
                              );
                            },
                          ),

                          CustomTextFormField(
                            title: 'City',
                            initialValue: user.city,
                            onChanged: (value) {
                              User user = state.checkout.user!.copyWith(city: value);

                              context.read<CheckoutBloc>().add(
                                UpdateCheckout(
                                  user: state.checkout.user!.copyWith(city: value),
                                ),
                              );
                            },
                          ),

                          CustomTextFormField(
                            title: 'Country',
                            initialValue: user.country,
                            onChanged: (value) {
                              User user = state.checkout.user!.copyWith(country: value);

                              context.read<CheckoutBloc>().add(
                                UpdateCheckout(
                                  user:
                                  state.checkout.user!.copyWith(country: value),
                                ),
                              );
                            },
                          ),
                          CustomTextFormField(
                            title: 'ZIP Code',
                            initialValue: user.zipCode,
                            onChanged: (value) {
                              User user = state.checkout.user!.copyWith(zipCode: value);

                              context.read<CheckoutBloc>().add(
                                UpdateCheckout(
                                  user:
                                  state.checkout.user!.copyWith(zipCode: value),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: SizeConfig.screenWidth,
                            height: 50,
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                color: kMainColor,
                              borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/payment-selection');
                                    },
                                    child: Text(
                                      'SELECT A PAYMENT METHOD',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/payment-selection');
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'ORDER SUMMARY',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const OrderSummary(),
                ],
              );
            } else {
              return const Text('Something Went Wrong!');
            }
          },
        ),
      ),
    );
  }


}

