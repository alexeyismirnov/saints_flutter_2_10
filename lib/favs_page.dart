import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'saint_list.dart';
import 'globals.dart';

class FavsPage extends StatefulWidget {
  @override
  _FavsPageState createState() => _FavsPageState();
}

class _FavsPageState extends State<FavsPage> {
  @override
  Widget build(BuildContext context) => SafeArea(
      child: VisibilityDetector(
          key: const ValueKey('my-widget-key'),
          onVisibilityChanged: (visibilityInfo) {
            setState(() {});
          },
          child: ConfigParamExt.favs.val().length == 0
              ? Center(child: Text("Нет закладок", style: Theme.of(context).textTheme.titleMedium))
              : NestedScrollView(
                  key: ValueKey(hashList(ConfigParamExt.favs.val())),
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
                        const SliverAppBar(
                            backgroundColor: Colors.transparent,
                            pinned: false,
                            title: Text('Закладки'),
                            actions: [])
                      ],
                  body: SaintList(ids: ConfigParamExt.favs.val()))));
}
