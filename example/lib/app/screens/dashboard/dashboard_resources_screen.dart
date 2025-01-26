import '../../../resources/dictionary.dart';

import '../../utils/style.dart';
import 'package:flutter/material.dart';
import 'package:karee/internationalization.dart';
import 'package:karee/widgets.dart';

class DashboardResourcesScreen extends RoutableWidget {
  DashboardResourcesScreen({super.key});

  @override
  Widget builder(BuildContext context, parameter) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(Dictionary.kareeModuleResourcesTitle.translate(),
              style: Style.moduleTitleStyle)),
      Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            Dictionary.kareeModuleResourcesDetails.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleDetailStyle,
          )),
      FittedBox(
          child: Row(children: [
        Icon(Icons.miscellaneous_services, color: Style.dashboardSelectedMenu),
        Text('  ${Dictionary.kareeModuleResourcesConfigTitle.translate()}',
            style: TextStyle(
                color: Style.dashboardSelectedMenu,
                fontWeight: FontWeight.w400,
                fontSize: 18))
      ])),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Dictionary.kareeModuleResourcesConfigDetail.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleItemDetail,
            textScaler: TextScaler.linear(1.1),
          )),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Style.dashboardSelectedMenu, width: 2)),
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Image(image: AssetImage('assets/images/config-file.png'))),
      FittedBox(
          child: Row(children: [
        Icon(Icons.settings_ethernet_rounded,
            color: Style.dashboardSelectedMenu),
        Text('  ${Dictionary.kareeModuleResourcesLocaleTitle.translate()}',
            style: TextStyle(
                color: Style.dashboardSelectedMenu,
                fontWeight: FontWeight.w400,
                fontSize: 18))
      ])),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(children: [
            Text(
              Dictionary.kareeModuleResourcesLocaleDetail.translate(),
              textAlign: TextAlign.justify,
              style: Style.moduleItemDetail,
              textScaler: TextScaler.linear(1.1),
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: FittedBox(
                    child: Row(children: [
                  Icon(Icons.language, color: Style.dashboardSelectedMenu),
                  Text(
                      '  ${Dictionary.kareeModuleResourcesLocaleStep1.translate()}',
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
                child: Image(image: AssetImage('assets/images/lang.png'))),
            Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: FittedBox(
                    child: Row(children: [
                  Icon(Icons.translate, color: Style.dashboardSelectedMenu),
                  Text(
                      '  ${Dictionary.kareeModuleResourcesLocaleStep2.translate()}',
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
                child:
                    Image(image: AssetImage('assets/images/translations.png'))),
            Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: FittedBox(
                    child: Row(children: [
                  Icon(Icons.edit_outlined, color: Style.dashboardSelectedMenu),
                  Text(
                      '  ${Dictionary.kareeModuleResourcesLocaleStep3.translate()}',
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
                    image: AssetImage('assets/images/traductions-usage.png'))),
          ])),
    ]);
  }
}
