import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants.dart';
import '../../core/size_config.dart';
import '../../models/product_model.dart';
import '../../widgets/widget.dart';


class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({Key? key}) : super(key: key);
  static const String routeName = '/order-confirmation';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OrderConfirmationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Order Confirmation',
      ),
      bottomNavigationBar: const CustomNavBar(
        screen: routeName,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  color: kMainColor,
                  width: double.infinity,
                  height: 250,
                ),
                Positioned(
                    left: (SizeConfig.screenWidth! - 100) / 2,
                    top: 100,
                    child: SvgPicture.asset('assets/SVGs/garlands.svg')),
                Positioned(
                  top: 200,
                  height: 100,
                  width: SizeConfig.screenWidth,
                  child: Text(
                    'Your order is completed! ',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ORDER CODE: #k321',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Thank you for your purchase!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ORDER CODE: #k321',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const OrderSummary(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ORDER DETAILS',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      OrderSummaryProductCard(product: Product.products[0], quantity: 2,),
                      OrderSummaryProductCard(product: Product.products[1], quantity: 2,),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

