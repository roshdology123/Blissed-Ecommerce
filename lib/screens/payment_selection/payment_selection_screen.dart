import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

import '../../widgets/widget.dart';
import '/blocs/blocs.dart';

import '/models/models.dart';

class PaymentSelection extends StatelessWidget {
  static const String routeName = '/payment-selection';

  const PaymentSelection({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const PaymentSelection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Selection'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is PaymentLoaded) {
            return ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                Platform.isIOS
                    ? RawApplePayButton(
                  style: ApplePayButtonStyle.black,
                  type: ApplePayButtonType.inStore,
                  onPressed: () {
                    context.read<PaymentBloc>().add(
                      const SelectPaymentMethod(
                          paymentMethod: PaymentMethod.apple_pay),
                    );
                    Navigator.pop(context);
                  },
                )
                    : const SizedBox(),
                const SizedBox(height: 10),
                Platform.isAndroid
                    ? RawGooglePayButton(
                  type: GooglePayButtonType.pay,
                  onPressed: () {
                    context.read<PaymentBloc>().add(
                      const SelectPaymentMethod(
                          paymentMethod: PaymentMethod.google_pay),
                    );
                    Navigator.pop(context);
                  },
                )
                    : const SizedBox(),
                ElevatedButton(
                  onPressed: () {
                    context.read<PaymentBloc>().add(
                      const SelectPaymentMethod(
                          paymentMethod: PaymentMethod.credit_card),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Pay with Credit Card'),
                ),
              ],
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}