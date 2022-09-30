
import 'package:flutter/foundation.dart' as debug;
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';
import 'constants.dart';

class AppRouter{
  static Route onGenerateRoute(RouteSettings settings){
    if (debug.kDebugMode) {
      // ignore: avoid_print
      print('Routing to : ${settings.name}');
    }

    switch(settings.name){
      case SplashScreen.routeName:
        return SplashScreen.route();
      case '/':
        return HomeScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case WishlistScreen.routeName:
        return WishlistScreen.route();
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case OrderConfirmationScreen.routeName:
        return OrderConfirmationScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case PaymentSelection.routeName:
        return PaymentSelection.route();
      case SignupScreen.routeName:
        return SignupScreen.route();
      case UserScreen.routeName:
        return UserScreen.route();
      default:
        return _errorRoute();
    }
  }
  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          centerTitle: true,
          backgroundColor: kMainColor,
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}