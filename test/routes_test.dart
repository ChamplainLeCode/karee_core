import 'package:flutter_test/flutter_test.dart';
import 'package:karee/annotations.dart'
    show Autowired, Controller, KareeInjector, Service;
import 'package:karee/src/routes/router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'routes_test.mocks.dart';

@Service
class MyService {}

@Controller
class MyController {
  static MyController instance = KareeInjector.instance<MyController>()!;
  @Autowired
  late MyService myService;
  int add(a, b) => a + b;
  Future<int> addAsync(a, b) async =>
      Future.delayed(Duration(seconds: 5), () => a + b);
}

class RouteActivationMiddleware {
  RouteActivation getActivationRoute() => (_) => true;
}

@GenerateMocks([RouteActivationMiddleware])
void main() {
  late MockRouteActivationMiddleware routeActivationMiddleware;
  String syncRouteName = '/test/controller/sync/add';
  String asyncRouteName = '/test/controller/async/add';

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    routeActivationMiddleware = MockRouteActivationMiddleware();
  });

  group('Router test -> ', () {
    setUp(() {});
    test('Controller Souscription in Framework', () {
      var noController = KareeInjector.instance<MyController>();
      KareeInjector.provide(MyController());
      var myController = KareeInjector.instance<MyController>();
      expect(noController, null);
      expect(myController, isNot(null));
    });

    test('Route souscription/consumption through Controller', () async {
      KareeInjector.provide(MyController());
      Route.on(syncRouteName, MyController.instance.add);
      Route.on(asyncRouteName, MyController.instance.addAsync);
      var a = 0x50, b = 50;
      expect(KareeRouter.goto(syncRouteName, parameter: [a, b]), 130);
      expect(await KareeRouter.goto(asyncRouteName, parameter: [b, a]), 130);
    });

    test('Route souscription/consumption through Function', () async {
      Route.on('/test/function/sync/add', (a) => a * 30);
      Route.on('/test/function/async/add',
          (a) async => Future.delayed(Duration(seconds: 3), () => a / 2));
      var a = 30, b = 50;
      expect(KareeRouter.goto('/test/function/sync/add', parameter: a), 900);
      expect(
          await KareeRouter.goto('/test/function/async/add', parameter: b), 25);
      expect(
          await KareeRouter.goto('/test/function/async/add', parameter: b), 25);
    });

    test('Route Activation: if no activation the route activated by default',
        () async {
      KareeInjector.provide(MyController());
      Route.on(syncRouteName, MyController.instance.add);

      var a = 0x50, b = 50;
      expect(KareeRouter.goto(syncRouteName, parameter: [a, b]), 130);
    });

    test('Route Activation: if the activation route allows then route called',
        () async {
      KareeInjector.provide(MyController());
      Route.on(syncRouteName, MyController.instance.add,
          canActivated: (_) => true);

      var a = 0x50, b = 50;
      expect(KareeRouter.goto(syncRouteName, parameter: [a, b]), 130);
    });

    test(
        'Route Activation: if the activation route denied then route not performs',
        () async {
      KareeInjector.provide(MyController());
      Route.on(syncRouteName, MyController.instance.add,
          canActivated: (_) => false);

      var a = 0x50, b = 50;
      expect(KareeRouter.goto(syncRouteName, parameter: [a, b]), null);
    });

    test(
        'Route Activation: route with param the ActivationRouteContext with param',
        () async {
      RouteActivation routeActivation = (_) => false;
      when(routeActivationMiddleware.getActivationRoute())
          .thenReturn(routeActivation);
      KareeInjector.provide(MyController());
      Route.on(syncRouteName, MyController.instance.add,
          canActivated: routeActivationMiddleware.getActivationRoute());

      var a = 0x50, b = 50;
      KareeRouter.goto(syncRouteName, parameter: [a, b]);

      verify(routeActivationMiddleware.getActivationRoute());
    });

    test('ContactListPresenter test', () async {});
  });
}
