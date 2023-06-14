
import 'package:cj_software_solutions/core/layout/adaptive.dart';
import 'package:cj_software_solutions/presentation/pages/widgets/animated_footer.dart';
import 'package:cj_software_solutions/presentation/pages/widgets/page_header.dart';
import 'package:cj_software_solutions/presentation/widgets/custom_spacer.dart';
import 'package:cj_software_solutions/presentation/widgets/page_wrapper.dart';
import 'package:cj_software_solutions/presentation/widgets/project_item.dart';
import 'package:cj_software_solutions/values/values.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WorksPage extends StatefulWidget {
  static const String worksPageRoute = StringConst.WORKS_PAGE;
  const WorksPage({Key? key}) : super(key: key);

  @override
  _WorksPageState createState() => _WorksPageState();
}

class _WorksPageState extends State<WorksPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _headingTextController;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _headingTextController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _headingTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double projectItemHeight = assignHeight(context, 0.4);
    double subHeight = (3 / 4) * projectItemHeight;
    double extra = projectItemHeight - subHeight;

    return PageWrapper(
      selectedRoute: WorksPage.worksPageRoute,
      selectedPageName: StringConst.WORKS,
      navBarAnimationController: _headingTextController,
      hasSideTitle: false,
      onLoadingAnimationDone: () {
        _headingTextController.forward();
      },
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          PageHeader(
            headingText: StringConst.WORKS,
            headingTextController: _headingTextController,
          ),
          ResponsiveBuilder(
            builder: (context, sizingInformation) {
              double screenWidth = sizingInformation.screenSize.width;

              if (screenWidth <= RefinedBreakpoints().mobileSmall) {
                return Column(
                  children: _buildProjectsForMobile(
                    data: Data.projects,
                    projectHeight: projectItemHeight.toInt(),
                    subHeight: subHeight.toInt(),
                  ),
                );
              } else {
                return Container(
                  height: (subHeight * (Data.projects.length)) + extra,
                  child: Stack(
                    children: _buildProjects(
                      data: Data.projects,
                      projectHeight: projectItemHeight.toInt(),
                      subHeight: subHeight.toInt(),
                    ),
                  ),
                );
              }
            },
          ),
          CustomSpacer(heightFactor: 0.1),
         /* Container(
            child: Padding(
              padding: padding,
              child: NoteWorthyProjects(),
            ),
          ),*/
          CustomSpacer(heightFactor: 0.15),
          AnimatedFooter(),
        ],
      ),
    );
  }

  List<Widget> _buildProjects({
    required List<ProjectItemData> data,
    required int projectHeight,
    required int subHeight,
  }) {
    List<Widget> items = [];
    int margin = subHeight * (data.length - 1);
    
    for (int index = data.length - 1; index >= 0; index--) {
      
      items.add(
        Container(
          margin: EdgeInsets.only(top: margin.toDouble()),
          child: ProjectItemLg(
            projectNumber: index + 1 > 9 ? "${index + 1}" : "0${index + 1}",
            projectItemheight: projectHeight.toDouble(),
            subheight: subHeight.toDouble(),
            title: data[index].title.toLowerCase(),
            subtitle: data[index].category,
            subtitleStyle: TextStyle(fontSize: 12),
          ),
        ),
      );
      margin -= subHeight;
    }
    return items;
  }

  List<Widget> _buildProjectsForMobile({
    required List<ProjectItemData> data,
    required int projectHeight,
    required int subHeight,
  }) {
    List<Widget> items = [];
   
    for (int index = 0; index < data.length; index++) {
      items.add(
        Container(
          child: ProjectItemSm(
            projectNumber: index + 1 > 9 ? "${index + 1}" : "0${index + 1}",
            title: data[index].title.toLowerCase(),
            subtitle: data[index].category,
            subtitleStyle: TextStyle(fontSize: 12),
          ),
        ),
      );
      items.add(CustomSpacer(
        heightFactor: 0.10,
      ));
    }
    return items;
  }

 
}
