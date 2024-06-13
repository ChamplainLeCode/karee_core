import 'package:flutter/material.dart' show MediaQuery;
import 'package:karee/navigation.dart' show KareeRouter;

class Utils {
  static bool get isMobileView =>
      MediaQuery.of(KareeRouter.currentContext!).size.width < minWidth;
  static const int minWidth = 650;
}
