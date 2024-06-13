import '../../../resources/dictionary.dart';

import '../../utils/style.dart';
import 'package:flutter/material.dart';
import 'package:karee/internationalization.dart';
import 'package:karee/widgets.dart';

class DashboardRoutageScreen extends RoutableWidget {
  @override
  Widget builder(BuildContext context, parameter) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(Dictionary.kareeModuleRoutageTitle.translate(),
              style: Style.moduleTitleStyle)),
      Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            Dictionary.kareeModuleRoutageDetails.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleDetailStyle,
          )),
      FittedBox(
          child: Row(children: [
        Icon(Icons.navigation_rounded, color: Style.dashboardSelectedMenu),
        Text('  ${Dictionary.kareeModuleRoutageUrlTitle.translate()}',
            style: TextStyle(
                color: Style.dashboardSelectedMenu,
                fontWeight: FontWeight.w400,
                fontSize: 18))
      ])),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Dictionary.kareeModuleRoutageUrlDetail.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleItemDetail,
            textScaleFactor: 1.1,
          )),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Style.dashboardSelectedMenu, width: 2)),
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Image(image: AssetImage('assets/images/routage-url.png'))),
      FittedBox(
          child: Row(children: [
        Icon(Icons.integration_instructions_outlined,
            color: Style.dashboardSelectedMenu),
        Text('  ${Dictionary.kareeModuleRoutageInternalTitle.translate()}',
            style: TextStyle(
                color: Style.dashboardSelectedMenu,
                fontWeight: FontWeight.w400,
                fontSize: 18))
      ])),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(children: [
            Text(
              "    ${Dictionary.kareeModuleRoutageInternalDetail.translate()}",
              textAlign: TextAlign.justify,
              style: Style.moduleItemDetail,
              textScaleFactor: 1.1,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: FittedBox(
                    child: Row(children: [
                  Icon(Icons.settings_input_composite_rounded,
                      color: Style.dashboardSelectedMenu),
                  Text(
                      '  ${Dictionary.kareeModuleRoutageInternalStep1.translate()}',
                      style: TextStyle(
                          color: Style.dashboardSelectedMenu,
                          fontWeight: FontWeight.w400,
                          fontSize: 16))
                ]))),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Style.dashboardSelectedMenu, width: 2)),
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Image(
                    image: AssetImage('assets/images/routage-set-router.png'))),
            Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: FittedBox(
                    child: Row(children: [
                  Icon(Icons.send_rounded, color: Style.dashboardSelectedMenu),
                  Text(
                      '  ${Dictionary.kareeModuleRoutageInternalStep2.translate()}',
                      style: TextStyle(
                          color: Style.dashboardSelectedMenu,
                          fontWeight: FontWeight.w400,
                          fontSize: 16))
                ]))),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Style.dashboardSelectedMenu, width: 2)),
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Image(
                    image: AssetImage(
                        'assets/images/routage-setup-routablewidget.png'))),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Style.dashboardSelectedMenu, width: 2)),
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Image(
                    image: AssetImage('assets/images/routage-load-route.png'))),
          ])),
    ]);
  }
}
