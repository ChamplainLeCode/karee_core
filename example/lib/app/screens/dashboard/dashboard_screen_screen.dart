import '../../../resources/dictionary.dart';

import '../../utils/style.dart';
import 'package:flutter/material.dart';
import 'package:karee/internationalization.dart';
import 'package:karee/widgets.dart';

class DashboardScreenTabScreen extends RoutableWidget {
  DashboardScreenTabScreen({super.key});

  @override
  Widget builder(BuildContext context, parameter) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(Dictionary.kareeModuleScreenTitle.translate(),
              style: Style.moduleTitleStyle)),
      Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            Dictionary.kareeModuleScreenDetails.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleDetailStyle,
          )),
      Row(children: [
        Icon(Icons.lens_outlined, color: Style.dashboardSelectedMenu),
        Text('  ${Dictionary.kareeModuleScreenStlsTitle.translate()}',
            style: TextStyle(
                color: Style.dashboardSelectedMenu,
                fontWeight: FontWeight.w400,
                fontSize: 18))
      ]),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Dictionary.kareeModuleScreenStlsDetail.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleItemDetail,
            textScaler: TextScaler.linear(1.1),
          )),
      Text(Dictionary.eg.translate()),
      Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Style.dashboardSelectedMenuBorder, width: 2)),
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Image(image: AssetImage('assets/images/screen-stl-eg.png'))),
      Row(children: [
        Icon(Icons.lens, color: Style.dashboardSelectedMenu),
        Text('  ${Dictionary.kareeModuleScreenStfsTitle.translate()}',
            style: TextStyle(
                color: Style.dashboardSelectedMenu,
                fontWeight: FontWeight.w400,
                fontSize: 18))
      ]),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(children: [
            Text(
              "    ${Dictionary.kareeModuleScreenStfsDetail.translate()}",
              textAlign: TextAlign.justify,
              style: Style.moduleItemDetail,
              textScaler: TextScaler.linear(1.1),
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Style.dashboardSelectedMenuBorder, width: 2)),
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Image(
                    image: AssetImage('assets/images/screen-stf-eg.png'))),
          ])),
    ]);
  }
}
