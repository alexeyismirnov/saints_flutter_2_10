import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

class InstallAppDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AlertDialog(
          contentPadding: const EdgeInsets.all(10.0),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Text('Новое приложение',
                                style: Theme.of(context).textTheme.headline6))
                      ]),
                  const SizedBox(height: 20),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Рекомендуем установить новое приложение ",
                        style: Theme.of(context).textTheme.subtitle1),
                    TextSpan(
                        text: "\"Православный календарь+\". ",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            "Содержит информацию о постах, праздниках, чтениях дня и многое другое.",
                        style: Theme.of(context).textTheme.subtitle1),
                  ])),
                ]),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade300, padding: const EdgeInsets.all(10.0)),
              child: Text('УСТАНОВИТЬ',
                  style: Theme.of(context).textTheme.button!.copyWith(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop(null);
                StoreRedirect.redirect(androidAppId: "com.rlc.ponomar_ru", iOSAppId: "1095609748");
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade300, padding: const EdgeInsets.all(10.0)),
              child: Text('ОТМЕНА',
                  style: Theme.of(context).textTheme.button!.copyWith(color: Colors.black45)),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            )
          ]);
}
