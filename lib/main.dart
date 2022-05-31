// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_toolkit/flutter_toolkit.dart';
import 'package:easy_localization/easy_localization.dart';

import 'homepage.dart';
import 'favs_page.dart';
import 'globals.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await GlobalPath.ensureInitialized();

  await ConfigParam.initSharedParams();
  ConfigParamExt.favs = ConfigParam<List<String>>('favs', initValue: []);

  await DB.prepare(basename: "assets/db", filename: "saints.sqlite");

  await rateMyApp.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(EasyLocalization(
      supportedLocales: const [Locale('ru', '')],
      path: 'assets/translations',
      startLocale: const Locale('ru', ''),
      child: RestartWidget(ContainerPage(tabs: [
        AnimatedTab(icon: const Icon(Icons.home), title: 'Жития', content: HomePage()),
        AnimatedTab(icon: const Icon(Icons.favorite), title: 'Закладки', content: FavsPage()),
      ]))));
}
