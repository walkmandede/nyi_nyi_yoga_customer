import 'package:flutter/material.dart';
import 'package:kmdmobilehybrid/utils/route_utils.dart';
import 'constants/app_colors.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1));
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: MaterialApp(
          routes: RouteUtils().routes,
          initialRoute: RouteUtils.entryPage,
          debugShowCheckedModeBanner: false,
          title: 'KMD Yoga App',
          locale: const Locale('en', 'EN'),
          theme: ThemeData(
            fontFamily: 'Poppins',
            primarySwatch: MaterialColor(
              AppColors.primary.value, const {
              050: Color.fromRGBO(29, 44, 77, .1),
              100: Color.fromRGBO(29, 44, 77, .2),
              200: Color.fromRGBO(29, 44, 77, .3),
              300: Color.fromRGBO(29, 44, 77, .4),
              400: Color.fromRGBO(29, 44, 77, .5),
              500: Color.fromRGBO(29, 44, 77, .6),
              600: Color.fromRGBO(29, 44, 77, .7),
              700: Color.fromRGBO(29, 44, 77, .8),
              800: Color.fromRGBO(29, 44, 77, .9),
              900: Color.fromRGBO(29, 44, 77, 1),
            }),
            useMaterial3: false,
          ),
      ),
    );
  }

}