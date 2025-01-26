import 'package:karee/widgets.dart';
import 'package:karee/annotations.dart';
import 'package:karee/navigation.dart';
import 'package:karee/core.dart';
import '../utils/style.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:url_launcher/url_launcher.dart' as launcher;
/*
 * @Author Champlain Marius Bakop
 * @email champlainmarius20@gmail.com
 * @github [ChamplainLeCode](https://github.com/ChamplainLeCode)
 * 
 */

@Screen('home', isInitial: true)
class HomeScreen extends StatefulScreen {
  HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ScreenState<HomeScreen> {
  @override
  Widget builder(BuildContext context) {
    return PopScope(
        child: Scaffold(
            body: Container(
                alignment: Alignment.center,
                color: Style.dashboardSelectedMenu,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image:
                              AssetImage('assets/karee.png', package: 'karee')),
                      Text(
                        'Another way to build Beautiful Application using Flutter',
                        style: TextStyle(
                            fontSize: 30,
                            color: Style.whiteText,
                            fontWeight: FontWeight.w200),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'version v2.2.0',
                        style: TextStyle(
                            fontSize: 20,
                            color: Style.whiteText.withOpacity(0.8),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (await launcher.canLaunchUrl(
                              Uri.parse(KareeConstants.kareeGithub))) {
                            await launcher.launchUrl(
                                Uri.parse(KareeConstants.kareeGithub));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.primaries.first),
                        child: Text('Get\'s started'),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () async {
                          KareeRouter.goto('/dashboard');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Style.warningColor, elevation: 10),
                        icon: Icon(
                          Icons.dashboard_customize,
                          size: 15,
                        ),
                        label: Text('Dashboard'),
                      ),
                      SizedBox(height: 10)
                    ],
                  ),
                ))));
  }
}
