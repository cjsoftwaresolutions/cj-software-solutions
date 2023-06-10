
import 'package:cj_software_solutions/core/layout/adaptive.dart';
import 'package:cj_software_solutions/presentation/pages/home/widgets/scroll_down.dart';
import 'package:cj_software_solutions/presentation/pages/works/works_page.dart';
import 'package:cj_software_solutions/presentation/widgets/animated_bubble_button.dart';
import 'package:cj_software_solutions/presentation/widgets/animated_positioned_widget.dart';
import 'package:cj_software_solutions/presentation/widgets/animated_slide_transtion.dart';
import 'package:cj_software_solutions/presentation/widgets/animated_text_slide_box_transition.dart';
import 'package:cj_software_solutions/presentation/widgets/spaces.dart';
import 'package:cj_software_solutions/values/values.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

const kDuration = Duration(milliseconds: 600);

class HomePageHeader extends StatefulWidget {
  const HomePageHeader({
    Key? key,
    required this.scrollToWorksKey,
    required this.controller,
  }) : super(key: key);

  final GlobalKey scrollToWorksKey;
  final AnimationController controller;
  @override
  _HomePageHeaderState createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController rotationController;
  late AnimationController scrollDownButtonController;
  late Animation<Offset> animation;
  late Animation<Offset> scrollDownBtnAnimation;

  @override
  void initState() {
    scrollDownButtonController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat();
    animation = Tween<Offset>(
      begin: Offset(0, 0.05),
      end: Offset(0, -0.05),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotationController.reset();
        rotationController.forward();
        // rotationController.reverse();
      }
    });
    controller.forward();
    rotationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollDownButtonController.dispose();
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = widthOfScreen(context);
    final double screenHeight = heightOfScreen(context);
    final EdgeInsets textMargin = EdgeInsets.only(
      left: responsiveSize(
        context,
        20,
        screenWidth * 0.15,
        sm: screenWidth * 0.15,
      ),
      top: responsiveSize(
        context,
        60,
        screenHeight * 0.35,
        sm: screenHeight * 0.35,
      ),
      bottom: responsiveSize(context, 20, 40),
    );
    final EdgeInsets padding = EdgeInsets.symmetric(
      horizontal: screenWidth * 0.1,
      vertical: screenHeight * 0.1,
    );
    final EdgeInsets imageMargin = EdgeInsets.only(
      right: responsiveSize(
        context,
        20,
        screenWidth * 0.05,
        sm: screenWidth * 0.05,
      ),
      top: responsiveSize(
        context,
        30,
        screenHeight * 0.25,
        sm: screenHeight * 0.25,
      ),
      bottom: responsiveSize(context, 20, 40),
    );

    return Container(
      width: screenWidth,
      color: AppColors.accentColor2.withOpacity(0.35),
      child: Stack(
        children: [
        /*  Container(
            margin: EdgeInsets.only(
              top: assignHeight(context, 0.1),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: WhiteCircle(),
            ),
          ),*/
          ResponsiveBuilder(builder: (context, sizingInformation) {
            double screenWidth = sizingInformation.screenSize.width;
            if (screenWidth < RefinedBreakpoints().tabletNormal) {
              return Column(
                children: [
                  Container(
                    padding: padding,
                    child: AnimatedSlideTranstion(
                      controller: controller,
                      position: animation,
                      child: Stack(
                        children: [
                          /*RotationTransition(
                            turns: rotationController,
                            child: Image.asset(
                              ImagePath.DEV_SKILLS_2,
                              width: screenWidth,
                            ),
                          ),*/
                          /*Image.asset(
                            ImagePath.DEV_MEDITATE,
                            width: screenWidth,
                          ),*/
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: padding.copyWith(top: 0),
                    child: Container(
                      width: screenWidth,
                      child: AboutDev(
                        controller: widget.controller,
                        width: screenWidth,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: textMargin,
                    child: Container(
                      width: screenWidth * 0.40,
                      child: AboutDev(
                        controller: widget.controller,
                        width: screenWidth * 0.40,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Container(
                    margin: imageMargin,
                    child: AnimatedSlideTranstion(
                      controller: controller,
                      position: animation,
                      child: Stack(
                        children: [
                        /*  RotationTransition(
                            turns: rotationController,
                            child: Image.asset(
                              ImagePath.DEV_SKILLS_2,
                              width: screenWidth * 0.35,
                            ),
                          ),*/
                         /* Image.asset(
                            ImagePath.DEV_MEDITATE,
                            width: screenWidth * 0.35,
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
          Positioned(
            right: 0,
            bottom: 0,
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) {
                double screenWidth = sizingInformation.screenSize.width;
                if (screenWidth < RefinedBreakpoints().tabletNormal) {
                  return Container();
                } else {
                  return InkWell(
                    hoverColor: Colors.transparent,
                    onTap: () {
                      Scrollable.ensureVisible(
                        widget.scrollToWorksKey.currentContext!,
                        duration: kDuration,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 24, bottom: 40),
                      child: MouseRegion(
                        onEnter: (e) => scrollDownButtonController.forward(),
                        onExit: (e) => scrollDownButtonController.reverse(),
                        child: AnimatedSlideTranstion(
                          controller: scrollDownButtonController,
                          beginOffset: Offset(0, 0),
                          targetOffset: Offset(0, 0.1),
                          child: ScrollDownButton(),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*class WhiteCircle extends StatelessWidget {
  const WhiteCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthOfCircle = responsiveSize(
      context,
      widthOfScreen(context) / 2.5,
      widthOfScreen(context) / 3.5,
    );
    return Container(
      width: widthOfCircle,
      height: widthOfCircle,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(widthOfCircle / 2),
        ),
      ),
    );
  }
}*/

class AboutDev extends StatefulWidget {
  const AboutDev({
    Key? key,
    required this.controller,
    required this.width,
  }) : super(key: key);

  final AnimationController controller;
  final double width;

  @override
  _AboutDevState createState() => _AboutDevState();
}

class _AboutDevState extends State<AboutDev> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    EdgeInsetsGeometry margin = const EdgeInsets.only(left: 16);
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: widget.controller,
      curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn),
    );
    double headerFontSize = responsiveSize(context, 28, 48, md: 36, sm: 32);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: margin,
              child: AnimatedTextSlideBoxTransition(
                controller: widget.controller,
                text: StringConst.HI,
                width: widget.width,
                maxLines: 3,
                textStyle: textTheme.headline2?.copyWith(
                  color: AppColors.black,
                  fontSize: 16,
                ),
              ),
            ),
            SpaceH12(),
            Container(
              margin: margin,
              child: AnimatedTextSlideBoxTransition(
                controller: widget.controller,
                text: StringConst.DEV_INTRO,
                width: widget.width,
                maxLines: 3,
                textStyle: textTheme.headline2?.copyWith(
                  color: AppColors.black,
                  fontSize: 22,
                ),
              ),
            ),
            SpaceH12(),
            Container(
              margin: margin,
              child: AnimatedTextSlideBoxTransition(
                controller: widget.controller,
                text: StringConst.DEV_TITLE,
                width: responsiveSize(
                  context,
                  widget.width * 0.75,
                  widget.width,
                  md: widget.width,
                  sm: widget.width,
                ),
                maxLines: 3,
                textStyle: textTheme.headline2?.copyWith(
                  color: Colors.blue,
                  fontSize: headerFontSize,
                ),
              ),
            ),
            SpaceH30(),
            /*Container(
              margin: margin,
              child: AnimatedPositionedText(
                controller: curvedAnimation,
                width: widget.width,
                maxLines: 3,
                factor: 2,
                text: StringConst.DEV_DESC,
                textStyle: textTheme.bodyText1?.copyWith(
                  fontSize: responsiveSize(
                    context,
                    Sizes.TEXT_SIZE_16,
                    Sizes.TEXT_SIZE_18,
                  ),
                  height: 2,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SpaceH30(),*/
            AnimatedPositionedWidget(
              controller: curvedAnimation,
              width: 200,
              height: 60,
              child: AnimatedBubbleButton(
                color: AppColors.grey100,
                imageColor: AppColors.black,
                startOffset: Offset(0, 0),
                targetOffset: Offset(0.1, 0),
                targetWidth: 200,
                startBorderRadius: const BorderRadius.all(
                  Radius.circular(100.0),
                ),
                title: StringConst.SEE_MY_WORKS.toUpperCase(),
                titleStyle: textTheme.bodyText1?.copyWith(
                  color: AppColors.black,
                  fontSize: responsiveSize(
                    context,
                    Sizes.TEXT_SIZE_14,
                    Sizes.TEXT_SIZE_16,
                    sm: Sizes.TEXT_SIZE_15,
                  ),
                  fontWeight: FontWeight.w500,
                ),
                onTap: () {
                  Navigator.pushNamed(context, WorksPage.worksPageRoute);
                },
              ),
            ),
            SpaceH40(),
         /*   Container(
              margin: margin,
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: _buildSocials(
                  context: context,
                  data: Data.socialData1,
                ),
              ),
            )*/
          ],
        ),
        SpaceH2(),
        Image.network("data:image/jpeg;base64,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")
      ],
    );
  }

 /* List<Widget> _buildSocials({
    required BuildContext context,
    required List<SocialData> data,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyText1?.copyWith(color: AppColors.grey750);
    TextStyle? slashStyle = textTheme.bodyText1?.copyWith(
      color: AppColors.grey750,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );
    List<Widget> items = [];

    for (int index = 0; index < data.length; index++) {
      items.add(
        AnimatedLineThroughText(
          text: data[index].name,
          isUnderlinedByDefault: true,
          controller: widget.controller,
          hasSlideBoxAnimation: true,
          hasOffsetAnimation: true,
          isUnderlinedOnHover: false,
          onTap: () {
            Functions.launchUrl(data[index].url);
          },
          textStyle: style,
        ),
      );

      if (index < data.length - 1) {
        items.add(
          Text('/', style: slashStyle),
        );
      }
    }

    return items;
  }*/
}
