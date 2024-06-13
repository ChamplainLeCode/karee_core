import '../../../utils/style.dart';
import 'package:flutter/material.dart';
import 'package:karee/widgets.dart';

class DashboardFooter extends StatelessComponent {
  @override
  Widget builder(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        height: 30,
        color: Style.whiteBackground,
        child: Text('© Karee Community 2022'));
  }
}
