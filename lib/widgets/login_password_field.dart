import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';

import '../core/constants.dart';

class LoginPasswordFormField extends StatelessWidget {
  const LoginPasswordFormField({
    Key? key,
    required this.title,
    this.onChanged,
    this.validator,
  })
      : super(key: key);
  final String title;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: FancyPasswordField(
          hasStrengthIndicator: false,
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
          onChanged: onChanged,
          validator: validator,
        )
    );
  }
}
