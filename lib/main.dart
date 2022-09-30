import 'package:blissed_ecommerce/cubits/cubits.dart';
import 'package:blissed_ecommerce/repositories/repositories.dart';
import 'package:blissed_ecommerce/screens/screens.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'blocs/blocs.dart';
import 'blocs/simple_bloc_observer.dart';
import 'core/app_router.dart';
import 'core/theme.dart';

import 'models/models.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'C26EF4E6-96F7-461A-A7F7-EB29A1EBF14D',
  );

  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(userRepository: UserRepository()),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(
                  authRepository: context.read<AuthRepository>(),
                  userRepository: context.read<UserRepository>())),
      BlocProvider(create: (_) => CartBloc()..add(LoadCart())),
          BlocProvider(
            create: (_) => PaymentBloc()..add(LoadPaymentMethod()),
          ),
          BlocProvider(
            create: (context) => CheckoutBloc(
              cartBloc: context.read<CartBloc>(),
              checkoutRepository: CheckoutRepository(),
              authBloc: context.read<AuthBloc>(), paymentBloc: PaymentBloc(),
            ),
          ),
          BlocProvider(
            create: (_) => CategoryBloc(
              categoryRepository: CategoryRepository(),
            )..add(LoadCategories()),
          ),
          BlocProvider(
              create: (_) => ProductBloc(
                productRepository: ProductRepository(),
              )..add(LoadProducts())),
          BlocProvider(
              create: (_) =>
              WishlistBloc(localStorageRepository: LocalStorageRepository())
                ..add(StartWishlist())),
          BlocProvider(
            create: (context) => SearchBloc(
              productBloc: context.read<ProductBloc>(),
            )..add(LoadSearch()),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E Commerce',
          theme: themeData(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
