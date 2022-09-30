
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import '../core/size_config.dart';
import '../models/product_model.dart';

class GooglePay extends StatelessWidget {
  const GooglePay({
    Key? key,
    required this.total,
    required this.products,
  }) : super(key: key);

  final String total;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    var paymentItems = products
        .map(
          (product) => PaymentItem(
          label: product.name,
          amount: product.price.toString(),
          type: PaymentItemType.item,
          status: PaymentItemStatus.final_price),
    )
        .toList();

    paymentItems.add(
      PaymentItem(
        label: "Total",
        amount: total,
        type: PaymentItemType.total,
        status: PaymentItemStatus.final_price,
      ),
    );

    void onGooglePayResult(paymentResult) {
      debugPrint(paymentResult.toString());
    }

    return SizedBox(
      width: SizeConfig.screenWidth! - 50,
      child: GooglePayButton(
        paymentConfigurationAsset: 'payment_profile_google_pay.json',
        onPaymentResult: onGooglePayResult,
        paymentItems: paymentItems,
        type: GooglePayButtonType.pay,
        margin: const EdgeInsets.only(top: 10),
        loadingIndicator: const CircularProgressIndicator(),
      ),
    );
  }
}