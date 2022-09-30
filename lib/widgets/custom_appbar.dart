import 'package:flutter/material.dart';

import '../core/constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool? isWishlist;
  CustomAppBar({
    Key? key,
    required this.title,
    this.isWishlist = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SafeArea(
        child: isWishlist! ?  AppNavBar(title: title) : AuthNavBar(title: title),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

class AppNavBar extends StatelessWidget {
  const AppNavBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: kMainColor
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 6,

        ),
        child: Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
      ),

      iconTheme: IconThemeData(color: kMainColor),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/wishlist');
            },
            icon: const Icon(Icons.bookmark)
        )
      ],
    );
  }
}

class AuthNavBar extends StatelessWidget {
  const AuthNavBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      title: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: kMainColor
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 6,

        ),
        child: Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
      ),

    );
  }
}

