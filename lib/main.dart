import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/layout/palette.dart';
import 'package:task_app/core/services/services_locator.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:task_app/core/thems/them.dart';
import 'package:task_app/presentation/ui/add_product_screen/add_product_screen.dart';
import 'package:task_app/presentation/ui/home_screen/home_screen.dart';

import 'core/routers/routers.dart';
import 'presentation/controller/cubit/app_cubit.dart';

void main() async {
  ServicesLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("ar"), Locale("en")],
        path: "assets/i18n",
        // <-- change the path of the translation files
        fallbackLocale: const Locale("ar"),
        startLocale: const Locale("ar"),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Palette.backgroundColor));
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(  create: (context) => sl<AppCubit>()..getHomeData()),
      ],
      child: MaterialApp(
        title: 'Exit Travail',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: theme,
        initialRoute: home,
        routes: {
          home: (context) => const HomeScreen(),
         addProduct: (context) =>  AddProductScreen(),
        },
      ),
    );
  }
}
