import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/core/utils/check_strong_password.dart';

class StrongPasswordWidget extends StatefulWidget{
  final String password;

  const StrongPasswordWidget({super.key, required this.password});

  @override
  State<StatefulWidget> createState() => _StrongPasswordWidget();

}

class _StrongPasswordWidget extends State<StrongPasswordWidget>{
  Color getStrengthColor(double value) {
    if (value <= 0.2) return Colors.red;
    if (value <= 0.4) return Colors.orange;
    if (value <= 0.6) return Colors.yellow[700]!;
    if (value <= 0.8) return Colors.lightGreen;
    return Colors.green;
  }

  Widget buildPasswordStrengthBar(double value) {
    return Row(
      children: List.generate(5, (index) {
        final active = value >= (index + 1) * 0.2;
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            height: 6,
            decoration: BoxDecoration(
              color: active
                  ? getStrengthColor(value)
                  : Colors.grey.withAlpha(60),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildPasswordStrengthBar(CheckStrongPassword.check(widget.password));
  }

}