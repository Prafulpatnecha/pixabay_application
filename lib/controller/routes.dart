import 'package:flutter/material.dart';
import 'package:pixabay_application/view/wallpaper/wallpaper_page.dart';

import '../view/home/home_page.dart';

class AppRoutes{
  static Map<String, Widget Function(BuildContext)> routes={
    '/':(context)=>const HomePage(),
    '/wallpaper':(context)=>const WallpaperPage(),
  };
}