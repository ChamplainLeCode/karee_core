import 'package:karee/navigation.dart';
import 'package:karee/widgets.dart';

import '../../../utils/style.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils.dart';

import 'dashboard_app_bar_tool.dart';

class DashboardAppBar extends StatefulComponent implements PreferredSizeWidget {
  DashboardAppBar();

  @override
  _DashboardAppBarState createState() => _DashboardAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(Utils.isMobileView ? 100 : 50);
}

class _DashboardAppBarState extends ComponentState<DashboardAppBar> {
  @override
  Widget builder(BuildContext context) {
    return Container(
      color: Style.dashboardSelectedMenu,
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              padding: mediaQuery.padding,
              height: 50 + mediaQuery.padding.top,
              color: Style.dashboardSelectedMenu,
              width: screenSize.width - (Utils.isMobileView ? 0 : 300),
              child: TextButton(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Karee ',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Style.whiteText)),
                      TextSpan(
                          text: 'Community',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Style.whiteText))
                    ]),
                  ),
                  onPressed: () => KareeRouter.goto('/'))),
          if (Utils.isMobileView) DashboardAppBarTool()
        ],
      ),
    );
  }
}
