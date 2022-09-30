import 'package:flutter/material.dart';

import '../core/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.title,
    this.onChanged, this.initialValue,
  }) : super(key: key);
  final String title;
  final Function(String)? onChanged;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
              child: TextFormField(
                initialValue: initialValue,
                onChanged: onChanged,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.only(left: 10.0),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: kMainColor,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
