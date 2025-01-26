import '../../../resources/dictionary.dart';

import '../../utils/style.dart';
import 'package:flutter/material.dart';
import 'package:karee/widgets.dart';
import 'package:karee/internationalization.dart';

/// Generated Karee Screen
/// @email champlainmarius20@gmail.com
/// @github [ChamplainLeCode](https://github.com/ChamplainLeCode)
///
///
///
/// `DashboardConstantsScreen` is set as Screen
///
class DashboardConstantsScreen extends RoutableWidget {
  DashboardConstantsScreen({super.key});

  @override
  Widget builder(BuildContext context, parameter) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(Dictionary.kareeModuleConstantTitle.translate(),
              style: Style.moduleTitleStyle)),
      Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            Dictionary.kareeModuleConstantDetails.translate(),
            style: Style.moduleDetailStyle,
          )),
      FittedBox(
          child: Row(children: [
        Icon(Icons.verified_user, color: Style.dashboardSelectedMenu),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '  KareeInstanceProfile',
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
                    text: 'production',
                    style: TextStyle(color: Colors.blueGrey))
              ])
        ]))
      ])),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Dictionary.kareeModuleConstantProfileProdDetail.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleItemDetail,
            textScaler: TextScaler.linear(1.1),
          )),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Style.dashboardSelectedMenu, width: 2)),
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Image(
            image: AssetImage('assets/images/error-prod.png'),
            width: 300,
          )),
      FittedBox(
          child: Row(children: [
        Icon(Icons.developer_mode, color: Style.dashboardSelectedMenu),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '  KareeInstanceProfile',
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
                    text: 'development',
                    style: TextStyle(color: Colors.blueGrey))
              ])
        ]))
      ])),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Dictionary.kareeModuleConstantProfileDevDetail.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleItemDetail,
            textScaler: TextScaler.linear(1.1),
          )),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Style.dashboardSelectedMenu, width: 2)),
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Image(
            image: AssetImage('assets/images/error-dev.png'),
            width: 300,
          )),
      FittedBox(
          child: Row(children: [
        Icon(Icons.add_to_home_screen_outlined,
            color: Style.dashboardSelectedMenu),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '  KareeConstants',
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
                    text: 'kareeErrorScreenName',
                    style: TextStyle(color: Colors.blueGrey))
              ])
        ]))
      ])),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Dictionary.kareeModuleConstantErrorScreenNameDetail.translate(),
            textAlign: TextAlign.justify,
            style: Style.moduleItemDetail,
            textScaler: TextScaler.linear(1.1),
          ))
    ]);
  }
}
