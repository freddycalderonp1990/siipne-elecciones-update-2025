import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import '../app/core/utils/utilidadesUtil.dart';
import '../app/core/values/app_colors.dart';
import '../app/presentation/routes/app_pages.dart';


import 'presentation/routes/siipne_routes.dart';

class MainSiipneMovil extends StatelessWidget {
  const MainSiipneMovil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch:UtilidadesUtil.convertirAColorMaterial(AppColors.colorAzul_1), // Color primario que afecta a varios elementos
        primaryColor: Colors.blue,  // Color primario
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.orange, // Color secundario/accento
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue), // Color de la línea cuando no está enfocado
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange), // Color de la línea cuando está enfocado
          ),
        ),
      ),

      localizationsDelegates:const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''), // arabic, no country code
      ],
      locale: Locale('es'),
      // translations will be displayed in that locale
      fallbackLocale: Locale('es'),
      initialRoute: SiipneRoutes.SPLASH,
      //initialBinding: DependencyInjection(),
      getPages: AppPages.getPages(),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('Key'),
          ),
        ),
      ),
    );
  }
}
