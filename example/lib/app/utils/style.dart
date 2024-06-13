import 'package:flutter/material.dart';

/*
 * @Author Champlain Marius Bakop
 * @email champlainmarius20@gmail.com
 * @github [ChamplainLeCode](https://github.com/ChamplainLeCode)
 * 
 */
class Style {
  /// -------------------------- Colors -----------------------------

  static final Color primaryColor = Color(0xffbb5c39);
  static final Color primaryDashboardColor = Color(0xff357ca5);
  static final Color primary2DashboardColor = Color(0xff3c8dbc);
  static final Color primaryDashboardDarkColor = Color(0xff222d32);

  static final whiteBackground = Color(0xfff7f7f7);

  static const Color whiteText = Colors.white;

  static Color successColor = Color(0xff00a65a);
  static Color warningColor = Color(0xfff39c12);
  static Color dangerColor = Color(0xffdd4b39);
  static Color infoColor = Color(0xff00c0ef);
  static Color dashboardSelectedMenu = Color(0xff1a2226);
  static Color dashboardSelectedMenuBorder = Color(0xff3c8dbc);

  /// -------------------------- Styles -----------------------------

  static final TextStyle profileText =
      TextStyle(color: whiteBackground, fontSize: 20);

  static final TextStyle profileTextGrey =
      TextStyle(color: Colors.black45, fontWeight: FontWeight.w400);

  static TextStyle get moduleItemDetail => TextStyle(
      color: Style.primaryDashboardDarkColor, fontWeight: FontWeight.w300);

  static TextStyle get moduleDetailStyle => TextStyle(
      color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.w300);

  static TextStyle get moduleTitleStyle => TextStyle(
      color: primaryDashboardDarkColor,
      fontSize: 22,
      fontWeight: FontWeight.w400);
}
