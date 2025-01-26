import '../../../resources/dictionary.dart';

import '../../utils/style.dart';
import 'package:flutter/material.dart';
import 'package:karee/widgets.dart';
import 'package:karee/internationalization.dart';

/// Generated Karee Screen
/// @github [ChamplainLeCode](https://github.com/ChamplainLeCode)
///
/// `DashboardControllersScreen` is set as Screen with name `dashboard_controller`
class DashboardControllersScreen extends RoutableWidget {
  DashboardControllersScreen({super.key});

  @override
  Widget builder(BuildContext context, parameter) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(Dictionary.kareeModuleControllerTitle.translate(),
              style: Style.moduleTitleStyle)),
      Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            Dictionary.kareeModuleConstantDetails.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleDetailStyle,
          )),
      FittedBox(
          child: Row(children: [
        Icon(Icons.miscellaneous_services, color: Style.dashboardSelectedMenu),
        Text('  ${Dictionary.kareeModuleControllerServiceTitle.translate()}',
            style: TextStyle(
                color: Style.dashboardSelectedMenu,
                fontWeight: FontWeight.w400,
                fontSize: 18))
      ])),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Dictionary.kareeModuleControllerServiceDetail.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleItemDetail,
            textScaler: TextScaler.linear(1.1),
          )),
      FittedBox(
          child: Row(children: [
        Icon(Icons.settings_ethernet_rounded,
            color: Style.dashboardSelectedMenu),
        Text('  ${Dictionary.kareeModuleControllerVariableTitle.translate()}',
            style: TextStyle(
                color: Style.dashboardSelectedMenu,
                fontWeight: FontWeight.w400,
                fontSize: 18))
      ])),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Dictionary.kareeModuleControllerVariableDetail.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleItemDetail,
            textScaler: TextScaler.linear(1.1),
          )),
    ]);
  }
}
