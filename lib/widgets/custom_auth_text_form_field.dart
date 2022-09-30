import 'package:flutter/material.dart';

import '../core/constants.dart';

class CustomAuthTextFormField extends StatelessWidget {
  const CustomAuthTextFormField({
    Key? key,
    required this.title,
    this.onChanged, this.validator})
      : super(key: key);
  final String title;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: TextFormField(

        onChanged: onChanged,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: title,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor, width: 1.6
            )
          ) ,
          floatingLabelStyle: TextStyle(color: kMainColor),
          labelStyle:
          MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
            final Color color = states.contains(MaterialState.error)
                ? Theme.of(context).errorColor
                : kMainColor;
            return TextStyle(color: color, letterSpacing: 1.3);
          }),
        ),
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      )
    );
  }
}
