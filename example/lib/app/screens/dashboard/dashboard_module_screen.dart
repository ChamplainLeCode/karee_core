import 'package:flutter/material.dart';
import 'package:karee/internationalization.dart';

import 'package:karee/widgets.dart';
import '../../utils/style.dart';
import '../../../resources/dictionary.dart';

/// Generated Karee Screen
///
/// `DashboardModuleScreen` is set as Screen with name ``

class DashboardModuleScreen extends RoutableWidget {
  final String? vard = null;

  @override
  Widget builder(BuildContext context, parameter) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(Dictionary.kareeModuleModuleTitle.translate(),
              style: Style.moduleTitleStyle)),
      Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            Dictionary.kareeModuleModuleDetails.translate(),
            style: Style.moduleDetailStyle,
          )),
      FittedBox(
          child: Row(children: [
        Icon(Icons.grid_goldenratio, color: Style.dashboardSelectedMenu),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '  PackageManager',
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
              children: [
                TextSpan(
                  text: '.',
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(
                    text: 'resourceOf',
                    style: TextStyle(color: Colors.blueGrey))
              ])
        ]))
      ])),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Dictionary.kareeModuleModuleResourceOf.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleItemDetail,
            textScaleFactor: 1.1,
          )),
      FittedBox(
          child: Row(children: [
        Icon(Icons.now_widgets_rounded, color: Style.dashboardSelectedMenu),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '  PackageManager',
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
              children: [
                TextSpan(
                  text: '.',
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(
                    text: 'ofWidget', style: TextStyle(color: Colors.blueGrey))
              ])
        ]))
      ])),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Dictionary.kareeModuleModuleWidgetOf.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleItemDetail,
            textScaleFactor: 1.1,
          )),
      FittedBox(
          child: Row(children: [
        Icon(Icons.add_to_home_screen_outlined,
            color: Style.dashboardSelectedMenu),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '  KareeModuleLoader',
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
              children: [
                TextSpan(
                  text: '.',
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(text: 'load', style: TextStyle(color: Colors.blueGrey))
              ])
        ]))
      ])),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Dictionary.kareeModuleModuleLoad.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleItemDetail,
            textScaleFactor: 1.1,
          ))
    ]);
  }
}
