import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_toolkit/flutter_toolkit.dart';
import 'package:easy_localization/easy_localization.dart';

import 'saint_model.dart';

class SaintList extends StatefulWidget {
  final DateTime date;

  SaintList({required this.date});

  @override
  SaintListState createState() => SaintListState();
}

class SaintListState extends State<SaintList> {
  Widget buildRow(Saint s) {
    var day = s.day;
    var month = s.month;
    Widget name;

    final fontSize = ConfigParam.fontSize.val();
    final style = Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: fontSize);

    if (day != 0) {
      if (day == 29 && month == 2) {
        day = 13;
        month = 3;
      }

      final dt = DateTime(DateTime.now().year, month, day);
      final format = DateFormat.MMMMd('ru');

      name = RichText(
          text: TextSpan(text: '', style: style, children: [
        TextSpan(text: format.format(dt), style: style.copyWith(color: Colors.red)),
        TextSpan(text: '   '),
        TextSpan(text: s.name)
      ]));
    } else {
      name = Text(s.name, style: style);
    }

    return Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            s.has_icon
                ? Image.asset(
                    'assets/icons/${s.id}.jpg',
                    width: 100.0,
                    height: 100.0,
                  )
                : Container(),
            Expanded(child: Container(padding: const EdgeInsets.only(left: 10.0), child: name))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SaintModel.getSaints(widget.date),
        builder: (context, AsyncSnapshot<List<Saint>> snapshot) {
          if (!snapshot.hasData) return Container();

          return CustomScrollView(slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => buildRow(snapshot.data![index]),
                    childCount: min(snapshot.data!.length, 100)))
          ]);
        });
  }
}
