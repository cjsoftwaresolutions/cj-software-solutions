import 'package:cj_software_solutions/core/layout/adaptive.dart';
import 'package:cj_software_solutions/presentation/widgets/animated_text_slide_box_transition.dart';
import 'package:cj_software_solutions/values/values.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
    this.title = "CJ Software Solutions",
    this.titleColor = AppColors.black,
    this.titleStyle,
    this.fontSize =40,
    required this.animationController
  }) : super(key: key);

  final String title;
  final TextStyle? titleStyle;
  final Color titleColor;
  final double? fontSize;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double headerFontSize = responsiveSize(context, 28, 48, md: 36, sm: 32);
    return Column(
      children: [
        Container(
          child: AnimatedTextSlideBoxTransition(
            controller: animationController,
            text: title,
            width: responsiveSize(
              context,
              MediaQuery.of(context).size.width * 0.75,
              MediaQuery.of(context).size.width,
              md:  MediaQuery.of(context).size.width,
              sm:  MediaQuery.of(context).size.width,
            ),
            maxLines: 3,
            textStyle: textTheme.headline2?.copyWith(
              color: Colors.orange,
              fontSize: headerFontSize,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: AnimatedTextSlideBoxTransition(
            controller: animationController,
            text: 'Transform Innovative ideas into Mobile & Web Reality',
            width: responsiveSize(
              context,
              MediaQuery.of(context).size.width * 0.75,
              MediaQuery.of(context).size.width,
              md:  MediaQuery.of(context).size.width,
              sm:  MediaQuery.of(context).size.width,
            ),
            maxLines: 3,
            textStyle: TextStyle(fontSize: 20,),
          ),
        ),

      ],
    );
  }
}
