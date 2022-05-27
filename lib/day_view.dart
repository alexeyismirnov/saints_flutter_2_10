import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_toolkit/flutter_toolkit.dart';

import 'globals.dart';

class DayView extends StatefulWidget {
  final DateTime date, dateOld;

  DayView({Key? key, required this.date})
      : dateOld = date.subtract(const Duration(days: 13)),
        super(key: key);

  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  DateTime get currentDate => widget.date;
  DateTime get currentDateOS => widget.dateOld;

  @override
  Widget build(BuildContext context) {
    final df1 = DateFormat.yMMMMEEEEd('ru');
    final df2 = DateFormat.yMMMMd('ru');

    var dateWidget = GestureDetector(
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.calendar_today, size: 30.0),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    AutoSizeText(df1.format(currentDate).capitalize(),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        minFontSize: 5,
                        style: Theme.of(context).textTheme.titleLarge),
                    AutoSizeText(df2.format(currentDateOS) + " " + "(ст. ст.)",
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        minFontSize: 5,
                        style: Theme.of(context).textTheme.subtitle1),
                  ]))
            ]),
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  locale: const Locale('ru'),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100))
              .then((newDate) {
            if (newDate != null) {
              print("DISPATCH");
              DateChangedNotification(newDate).dispatch(context);
            }
          });
        });

    return NestedScrollView(
        key: ValueKey(currentDate),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [SliverAppBar(backgroundColor: Colors.transparent, pinned: false, title: dateWidget)],
        body: const Center(child: Text("hello")));
  }
}
