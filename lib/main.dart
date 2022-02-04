import 'package:flutter/material.dart';
import 'package:sary/app/common/colors/light_theme_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sary/app/modules/item/view/item_view.dart';
import 'package:sary/app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sary Test',
      theme: lightTheme,
      home: const App(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(415, 930),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return const ItemView();
  }
}
