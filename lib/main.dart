import 'package:cj_software_solutions/app_theme.dart';
import 'package:cj_software_solutions/injection_container.dart';
import 'package:cj_software_solutions/presentation/pages/about/about_page.dart';
import 'package:cj_software_solutions/presentation/pages/contact_page.dart';
import 'package:cj_software_solutions/presentation/pages/home/home_page.dart';
import 'package:cj_software_solutions/presentation/pages/works/works_page.dart';
import 'package:cj_software_solutions/presentation/routes/routes.dart';
import 'package:cj_software_solutions/values/values.dart';
import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

import 'configure_web.dart';

// Home
// TODO:: add well rounded verbose rotating logos -> representing web, mobile & cloud
// cloud -> kubernets & docker
// mobile -> kotlin, android, flutter, jetpack compose,
// web -> react, javascript


// Certifications
// TODO:: Add Cloud Certification from Udacity

// Contact
// TODO:: Fix email service


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
   configureApp();
  runApp(Aerium());
}

class Aerium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        title: StringConst.APP_TITLE,
        color: Colors.blue,
        theme: AppTheme.lightThemeData,
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.homePageRoute,
        routes: {
          '/': (context) => HomePage(),
          '/about': (context) => const AboutPage(),
          '/contact': (context) => const ContactPage(),
          '/works': (context) => const WorksPage(),
        },
        onGenerateRoute: RouteConfiguration.onGenerateRoute,
      ),
    );
  }
}


