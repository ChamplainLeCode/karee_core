import 'package:karee/navigation.dart' show Route;
import '../controllers/dashboard/dash_board_controller.dart';

/*
 * By Karee
 * 
 */
void registeredRoute() {
  Route.on('/dashboard', DashBoardController.instance.home);
  Route.on('/dashboard/{menu}', DashBoardController.instance.menuScreen);
}
