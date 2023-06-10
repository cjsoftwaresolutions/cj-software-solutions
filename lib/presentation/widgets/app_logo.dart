import 'package:cj_software_solutions/values/values.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
    this.title = "CJ Software Solutions",
    this.titleColor = AppColors.black,
    this.titleStyle,
    this.fontSize =40,
  }) : super(key: key);

  final String title;
  final TextStyle? titleStyle;
  final Color titleColor;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
      Text(
      title,
      style: titleStyle ??
          textTheme.headline2?.copyWith(
            color: Colors.orange,
            fontSize: fontSize,
          ),
    ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text('Transform Innovative ideas into Mobile & Web Reality',style: TextStyle(fontWeight: FontWeight.bold),),
            Icon(Icons.favorite,color: Colors.pink,)
          ],
        )
      ],
    );
  }
}
