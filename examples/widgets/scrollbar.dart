// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ScrollbarApp extends StatefulComponent {
  ScrollbarApp({ this.navigator });

  final NavigatorState navigator;

  ScrollbarAppState createState() => new ScrollbarAppState();
}

class ScrollbarAppState extends State<ScrollbarApp> {
  final int _itemCount = 20;
  final double _itemExtent = 50.0;
  final ScrollbarPainter _scrollbarPainter = new ScrollbarPainter();

  Widget _buildMenu(BuildContext context) {
    NumberFormat dd = new NumberFormat("00", "en_US");
    return new ScrollableList<int>(
      items: new List<int>.generate(_itemCount, (int i) => i),
      itemExtent: _itemExtent,
      itemBuilder: (_, int i) {
        return new Text('Item ${dd.format(i)}',
          key: new ValueKey<int>(i),
          style: Theme.of(context).text.title
        );
      },
      scrollableListPainter: _scrollbarPainter
    );
  }

  Widget build(BuildContext context) {
    Widget scrollable = new Container(
      margin: new EdgeDims.symmetric(horizontal: 6.0), // TODO(hansmuller) 6.0 should be based on _kScrollbarThumbWidth
      child: new Center(
        shrinkWrap: ShrinkWrap.both,
        child: new Container(
          width: 80.0,
          height: _itemExtent * 5.0,
          child: _buildMenu(context)
        )
      )
    );

    return new Scaffold(
      toolBar: new ToolBar(center: new Text('Scrollbar Demo')),
      body: new Container(
        decoration: new BoxDecoration(backgroundColor: Theme.of(context).primarySwatch[50]),
        padding: new EdgeDims.all(12.0),
        child: new Center(child: new Card(child: scrollable))
      )
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: 'ScrollbarApp',
    theme: new ThemeData(
      brightness: ThemeBrightness.light,
      primarySwatch: Colors.blue,
      accentColor: Colors.redAccent[200]
    ),
    routes: {
      '/': (RouteArguments args) => new ScrollbarApp(navigator: args.navigator),
    }
  ));
}
