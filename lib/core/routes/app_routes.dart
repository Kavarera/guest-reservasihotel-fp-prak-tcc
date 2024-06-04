import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/pages/landing_page.dart';

abstract class AppRoutesRepo {
  static const String landing = '/landing';
  static const String bookingPage = '/bookingPage';

  static List<GetPage<Widget>> pages = [
    GetPage(name: landing, page: () => LandingPage()),
  ];
}
