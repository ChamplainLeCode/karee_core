import 'package:karee/navigation.dart' show RouteMode, screen;
import 'package:karee/annotations.dart' show Controller, KareeInjector;

/*
 * @github [ChamplainLeCode](https://github.com/ChamplainLeCode)
 * 
 */
@Controller
class HomeController {
  static HomeController get instance =>
      KareeInjector.instance<HomeController>()!;

  void index() {
    screen('home', RouteMode.REPLACE);
  }
}
