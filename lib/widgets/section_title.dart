import 'package:flutter/material.dart';
import '../core/size_config.dart';

class SectionTitle extends StatelessWidget {
  final String? title;
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 2),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title!,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
