import 'package:karee/core.dart';

import '../../utils/utils.dart';
import '../../screens/dashboard/components/dashboard_app_bar_tool.dart';
import '../../screens/dashboard/components/dashboard_karee_presentation.dart';
import 'package:flutter/material.dart';
import 'package:karee/widgets.dart';
import 'package:karee/annotations.dart';
import 'package:karee/navigation.dart';
import 'components/dashboard_app_bar.dart';
import 'components/dashboard_footer.dart';
import 'components/dashboard_side_menu.dart';

/// Generated Karee Screen
/// @email champlainmarius20@gmail.com
/// @github [ChamplainLeCode](https://github.com/ChamplainLeCode)
///
///
///
/// `HomeDashBoardScreen` is set as Screen with name `dashboard`
@Screen('dashboard')
class HomeDashBoardScreen extends StatefulScreen {
  @override
  _HomeDashboardScreenState createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends ScreenState<HomeDashBoardScreen> {
  Of<int>? selectedIndexObs;

  int get minWidth => 600;

  bool get isMobileView => screenSize.width <= minWidth;

  @override
  void initState() {
    selectedIndexObs = Of.withTag(#sideMenu);
    super.initState();
  }

  @override
  void dispose() {
    selectedIndexObs!.value = 0;
    super.dispose();
  }

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
        appBar: DashboardAppBar(),
        drawer: Utils.isMobileView ? DashboardSideMenu() : null,
        body: Row(children: [
          if (!Utils.isMobileView) DashboardSideMenu(),
          Expanded(
              child: Column(children: [
            if (!Utils.isMobileView) DashboardAppBarTool(),
            Expanded(
                child: SingleChildScrollView(
                    padding: EdgeInsets.all(30),
                    controller: ScrollController(),
                    child: RouterWidget(
                        name: #dashboardRouter,
                        initial: DashboardKareePresentation()))),
            DashboardFooter()
          ]))
        ]));
  }

  void closeDrawer() {
    if (Utils.isMobileView) {
      KareeRouter.goBack();
    }
  }
}
