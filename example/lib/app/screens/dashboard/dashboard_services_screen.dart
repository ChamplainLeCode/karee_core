import '../../../resources/dictionary.dart';

import '../../utils/style.dart';
import 'package:flutter/material.dart';
import 'package:karee/widgets.dart';
import 'package:karee/internationalization.dart';

/// Generated Karee Screen
///
/// `DashboardServicesScreen` is set as Screen with name `dashboard_service`
class DashboardServicesScreen extends RoutableWidget {
  DashboardServicesScreen({super.key});

  @override
  Widget builder(BuildContext context, parameter) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(Dictionary.kareeModuleServiceTitle.translate(),
              style: Style.moduleTitleStyle)),
      Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            Dictionary.kareeModuleServiceDetails.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleDetailStyle,
          )),
      Text(Dictionary.eg.translate()),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Style.dashboardSelectedMenu, width: 2)),
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Image(image: AssetImage('assets/images/service-def.png'))),
    ]);
  }
}
