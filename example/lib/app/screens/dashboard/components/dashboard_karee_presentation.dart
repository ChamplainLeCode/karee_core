import '../../../../resources/dictionary.dart';

import '../../../utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:karee/widgets.dart';
import 'package:karee/internationalization.dart';

class DashboardKareePresentation extends StatelessComponent {
  DashboardKareePresentation({super.key});

  @override
  Widget builder(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Text(
              Dictionary.welcomeMessage
                  .translateWithParams({'username': 'Karee'}),
              style: Style.moduleTitleStyle)),
      Align(
          alignment: Alignment.center,
          child: Text(Dictionary.welcomeMessage1.translate(),
              textAlign: TextAlign.center, style: Style.moduleTitleStyle)),
      Align(
          alignment: Alignment.center,
          child: Text(Dictionary.welcomeMessage2.translate(),
              style: Style.moduleTitleStyle, textAlign: TextAlign.center)),
    ]);
  }
}
