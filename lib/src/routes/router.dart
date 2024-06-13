// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import '../modules/library.dart';
import '../errors/exceptions/widget_error.dart';
import '../widgets/screen_widget.dart' show StatefulScreen, StatelessScreen;
import '../constances/constances.dart' show KareeConstants;
import '../constances/enumeration.dart' show KareeErrorCode;
import '../errors/exceptions/no_action_found_error.dart';
import '../errors/exceptions/no_route_found_error.dart';
import 'internal_route.dart';
import '../widgets/karee_router_error_widget.dart';
import '../widgets/router_widget.dart';
import '../screens/screens.dart' show screen, screens;

///
/// Cache of RouterWidgets mounted.
///
Map<Symbol, RouterWidgetState> _internalRouter = {};

///
/// Notes: Karee provides different ways to navigate between screens.
/// RouteMode helps you to set what kind of navigation policy you want.
///
/// [RouteMode.REPLACE] : If you want to pop the current context and add new one
/// without making two calls KareeRouter.goBack and KareeRouter.goto.
///
/// [RouteMode.PUSH] : Used to add a new navigation context on last one.
///
/// [RouteMode.INTERNAL] : Used to indicate to KareeRouter that the current
/// route should be sent to a Routable Widget inside the Flutter tree.
///
/// [RouteMode.EMPTY] : Meaning that you want to clean navigation before adding
/// current path. Assume that your current navigation path is
/// /settings/user/profile and you want to go back /home, to avoid to remove
/// one by one and push new path, you can use RouteMode.EMPTY.
///
enum RouteMode {
  ///
  /// RouteMode.REPLACE: If you want to pop current context and add new one
  /// without making two calls KareeRouter.goBack and KareeRouter.goto.
  // ignore: constant_identifier_names
  REPLACE,

  ///
  /// RouteMode.PUSH: Used to a add new navigation context on last one.
  ///
  // ignore: constant_identifier_names
  PUSH,

  ///
  /// RouteMode.EMPTY. Meaning that you want to clean navigation before adding
  /// current path. Assume that your current navigation path is
  /// /settings/user/profile and you want to go back /home, to avoid to remove
  /// one by one and push new path, you can use RouteMode.EMPTY.
  ///
  // ignore: constant_identifier_names
  EMPTY,

  ///
  /// RouteMode.INTERNAL: Used to indicate to KareeRouter that the current route
  /// should be sent to a Routable Widget inside the Flutter tree.
  ///
  // ignore: constant_identifier_names
  INTERNAL,

  ///
  /// RouteMode.NONE: Used to indicate to KareeRouter that the current route
  /// should be sent to a Routable Widget inside the flutter tree.
  ///
  /// See [INTERNAL]
  @Deprecated('Use INTERNAL instead')
  // ignore: constant_identifier_names
  NONE
}

/// Context of router when handling route with an activation function.
class ActivationRouteContext {
  /// Pameter sent to the route.
  dynamic parameters;

  /// The name of the route.
  String routeName;

  /// Constructor for [ActivationRouteContext]
  ActivationRouteContext(this.routeName, [this.parameters]);
}

///
/// RouteDirection: Not yet implemented, it will be used as the screen entry
/// direction during navigation.
///
///
// enum RouteDirection { LEFT_TO_RIGHT, RIGHT_TO_LEFT, UP_TO_DOWN, DOWN_TO_UP }

typedef RouteActivation = bool Function(ActivationRouteContext ctx);

///
/// [_RouteEntry]: represents record use to subscribe the path in
/// the [KareeRouter]
///
class _RouteEntry {
  String path;
  dynamic action;
  RouteActivation activation;

  _RouteEntry(this.path, this.action, this.activation);
}

///
/// [_ParameterizedRouteParams] is used to for each route with parameters
/// what is the named parameter values
///
class _ParameterizedRoute {
  _RouteEntry originalRoute;

  ///
  /// Parameter's name list in the path
  ///
  List<String> parameters;

  _ParameterizedRoute(this.originalRoute, this.parameters);

  dynamic get action => this.originalRoute.action;
}

///
/// Route: class designed to subscribe events (route) in application.
///
/// Route.on associates the event represented by the path to a specific action .
///
/// Route.on associates the event represented by the path to a specific action.
///
class Route {
  // ignore: prefer_final_fields
  static Map<String, _RouteEntry?> _routeMap = {};
  // ignore: prefer_final_fields
  ///
  /// [_routeActivationMap] is the map that contains for each parameterized
  /// route a List where:
  /// - first Item is the action associated to the path
  /// - the rest of list (excluded the first) contains parameter's names of the
  /// route
  ///
  static Map<String, _ParameterizedRoute> _routeWithParams =
      <String, _ParameterizedRoute>{};
  // ignore: prefer_final_fields
  static Map<RouteActivation, List<String>> _routeActivationMap = {};

  ///
  /// Path variable regex used to extract path variable in route.
  ///
  // ignore: unnecessary_string_escapes
  static const String _pathVariableGroup = '([0-9a-zA-Z\-_]+)';

  ///
  /// Path variable regex used to detect whether there is a path variable in
  /// the route.
  ///
  static final RegExp _pathVariableRegExp = RegExp(r'{[a-zA-Z0-9\-_]+}');

  ///
  /// This function is the default Route Guard when it's not defined.
  /// Meaning that, when you define your routes in `routes.dart`, and you
  /// don't specify the activation for each route, in default case, we
  /// allow execution through this function.
  ///
  static RouteActivation get defaultRouteActivation => (ctx) => true;

  ///
  /// This function is used to register your application in Karee Router module.
  ///
  /// [path] is the string that represents the resource location.
  ///
  /// [action] is the action to perform when resource represented by [path] is
  /// needed.
  ///
  /// [canActivated] is the route guard, use to allow the request to access to
  /// the desired resource.
  static void on(String path, dynamic action, {RouteActivation? canActivated}) {
    assert(action != null && action.toString().isNotEmpty);
    assert(path.isNotEmpty);

    final canActivateRoute = canActivated ?? defaultRouteActivation;

    var routeEntry = _RouteEntry(path, action, canActivateRoute);

    if (path.contains(_pathVariableRegExp)) {
      var meta = _ParameterizedRoute(routeEntry, []);
      var newPath = path.replaceAllMapped(_pathVariableRegExp, (m) {
        meta.parameters.add(path.substring(m.start + 1, m.end - 1));
        return _pathVariableGroup;
      });
      _routeWithParams[newPath] = meta;
    } else {
      _routeMap[path] = routeEntry;
    }
    // routeMap[route] = action;
    if (canActivateRoute != defaultRouteActivation) {
      var routes = _routeActivationMap[canActivateRoute] ?? <String>[];
      routes.add(path);
      _routeActivationMap[canActivateRoute] = routes;
    }
  }
}

/// When a new Router Widget is added in the Flutter tree, it is automatically
/// registered and available in the internal router cache.
void subscribeRouterWidget(Symbol name, RouterWidgetState state) =>
    _internalRouter[name] = state;

/// When a new Router Widget is removed from the Flutter tree, it is
/// automatically unregistered and (un)available in the internal router cache.
void unsubscribeRouterWidget(Symbol name, RouterWidgetState state) {
  _internalRouter.removeWhere((key, value) => key == name && value == state);
}

/// Function used to get a router from the cache by its [name].
RouterWidgetState? findRouterByName(
  Symbol name,
) {
  if (_internalRouter.containsKey(name)) {
    return _internalRouter[name];
  }
  throw NoActionFoundError('internal Route', name);
}

///
/// Used to perform internal routing.
///
/// See [RoutableWidget]
/// See [RouterWidget]
void doInternalRouting(Symbol routerName, dynamic screenName, dynamic param) {
  try {
    var router = findRouterByName(routerName);

    if (router == null) {
      throw Exception(
          'Unable to find router with name ${routerName.toString()}');
    }
    if (screenName is String || screenName is cupertino.Widget) {
      var widget;
      if (screenName is Widget) {
        widget = screenName;
      } else {
        widget = screens
            .firstWhere((routeItem) => routeItem[#name] == screenName)[#screen]
            ?.call();
      }
      if (widget is RoutableWidget) {
        router.load(widget..onParam(param));
        return;
      }

      throw NotRoutableWidgetException(
          routerName.toString(), widget.runtimeType);
    } else {}
  } on NotRoutableWidgetException catch (e, stack) {
    KareeRouter.goto(KareeConstants.kareeErrorPath, parameter: {
      #title: e.message,
      #stack: stack,
      #env: (param == null
          ? []
          : param is List
              ? param
              : [])
        ..reversed.toList()
        ..addAll([screenName, routerName, e.widgetType]),
      #errorCode: KareeErrorCode.notRoutableWidget
    });
  } on StateError catch (e, stack) {
    print(e);
    KareeRouter.goto(KareeConstants.kareeErrorPath, parameter: {
      #title: 'No screen found with name $screenName',
      #stack: stack,
      #env: (param == null
          ? []
          : param is List
              ? param
              : [])
        ..reversed.toList()
        ..addAll([screenName, routerName]),
      #errorCode: KareeErrorCode.screenNotFound
    });
  } catch (ex, stack) {
    print(ex);
    KareeRouter.goto(KareeConstants.kareeErrorPath, parameter: {
      #title: (ex as dynamic).message,
      #stack: stack,
      #env: (param == null
          ? []
          : param is List
              ? param
              : [])
        ..reversed.toList()
        ..addAll([
          screenName,
          '#' +
              routerName
                  .toString()
                  .substring(8, routerName.toString().length - 3)
        ]),
      #errorCode: KareeErrorCode.noRouteFound
    });
  }
}

///
/// `KareeRouter`: To navigate between screens you may use KareeRouter that
///  offers you two ways to go forward and to go back. KareeRouter provides
///  also a way to consume routes between your application modules.
///
/// `KareeRouter.goto( routeName, parameter )`
///
/// `routeName` It is the same path or event defined in the Routes.dart of your
/// module.
/// `parameter` It is the arguments list that should be injected in your Route action.
///
/// `KareeRouter.goBack( context )`
///
class KareeRouter {
  static GlobalKey<NavigatorState>? _navigatorKey;
  static BuildContext? currentContext;
  static String? _currentRoute;
  static Map<String, String>? _pathVariables;
  static dynamic _lastArguments;
  static String? screenName;
  static GlobalKey<NavigatorState> get navigatorKey =>
      _navigatorKey ?? (_navigatorKey = GlobalKey<NavigatorState>());
  static String? get currentRoute => _currentRoute;
  static Map<String, String>? get pathVariables => _pathVariables;

  static dynamic goto(String routeName, {dynamic parameter}) {
    assert(routeName.isNotEmpty);

    final activationRouteContext = ActivationRouteContext(routeName, parameter);

    /// Looking for route activation with routeName exact matching
    var canActivatedEntry = Route._routeActivationMap.entries.firstWhere(
        (entry) => entry.value.contains(routeName),
        orElse: () => MapEntry(Route.defaultRouteActivation, []));
    if (!Function.apply(canActivatedEntry.key, [activationRouteContext])) {
      /// Route Guard refused access to this routes.
      return;
    }

    KareeRouter._currentRoute = routeName;

    /// We reset the path variable for this call Session.
    _pathVariables = null;

    _RouteEntry? routeEntry = findActionFor(routeName);

    /// After checking action, we got nullable _RouteEntry, if present,
    /// then we are sure that the _route entry is exact match of current
    /// routeName or generic for (route with parameter) of routeName,
    /// then we apply routeGuard
    if (!(Function.apply(
        (routeEntry?.activation ?? Route.defaultRouteActivation),
        [activationRouteContext]))) {
      /// Route Guard refused access to this routes
      return;
    }
    try {
      if (routeEntry != null) {
        if (routeEntry.action is Function) {
          if (parameter == null) {
            return routeEntry.action();
          } else {
            return Function.apply(
                routeEntry.action,
                parameter is List
                    ? parameter
                    : parameter == null
                        ? []
                        : [parameter]);
          }
          // action(parameter);
        }

        throw NoActionFoundError(routeName, parameter);
      } else {
        ///
        /// When the route is not found! we will try to check whether it starts
        /// with the path that represents a module not loaded yet.
        ///
        try {
          var subscription = KareeModule.modules.entries.firstWhere(
              (subscription) => routeName.startsWith(subscription.key));
          if (subscription.value.isInitialized == false) {
            return Future.sync(() async {
              await subscription.value.initialize();
              return await goto(routeName, parameter: parameter);
            });
          }
          // ignore: empty_catches
        } on StateError {}
        throw NoRouteFoundError(routeName, parameter);
        //('No action for this route');
      }
    } catch (e, st) {
      if (e is NoActionFoundError || e is NoRouteFoundError) {
        screen(KareeConstants.kareeErrorScreenName, RouteMode.PUSH, argument: {
          #title: (e as dynamic).message,
          #stack: st,
          #env: [routeName, if (parameter != null) parameter],
          #errorCode: KareeErrorCode.noRouteFound
        });
      } else {
        screen(KareeConstants.kareeErrorScreenName, RouteMode.PUSH, argument: {
          #title: (e as dynamic).message,
          #stack: st,
          #env: [routeName, if (parameter != null) parameter],
          #errorCode: KareeErrorCode.generalError
        });
      }
    }
  }

  ///
  /// Function used to get the specific action from a path route.
  ///
  /// This function also setup **[KareeRouter.pathVariables]** value when the path
  /// represented by this route contains url parameters.
  ///
  static _RouteEntry? findActionFor(String ro) {
    MapEntry<String, _RouteEntry?> routeEntry = Route._routeMap.entries
        .firstWhere((entry) => entry.key == ro,
            orElse: () => MapEntry('', null));
    if (routeEntry.value == null) {
      MapEntry<String, _ParameterizedRoute> arg = Route._routeWithParams.entries
          .firstWhere((entryParam) => RegExp(entryParam.key).hasMatch(ro),
              orElse: () => MapEntry(
                  '',
                  _ParameterizedRoute(
                      _RouteEntry('', null, (_) => false), [])));
      if (arg.value.action != null) {
        var pathVar = RegExp(arg.key)
            .allMatches(ro)
            .map((e) =>
                e.groups(List<int>.generate(e.groupCount + 1, (ind) => ind)))
            .firstWhere((element) => true, orElse: () => <String>[]);
        KareeRouter._pathVariables = {};
        for (int i = 1; i < pathVar.length; i++) {
          KareeRouter._pathVariables!.addEntries([
            MapEntry(
                Route._routeWithParams[arg.key]!.parameters[i - 1], pathVar[i]!)
          ]);
        }
        return arg.value.originalRoute;
      }
      return null;
    }
    return routeEntry.value;
  }

  ///
  /// General router for the application. Overloaded by Karee to override default navigator.
  ///
  static get getRouter => (cupertino.RouteSettings rs) {
        return appRoute(rs);
      };
  static cupertino.Route<dynamic> appRoute(cupertino.RouteSettings settings) {
    try {
      var widget = settings.name == null || settings.name == '/'
          ? initialScreen()
          : screens.firstWhere((routeItem) => routeItem[#name] == settings.name,
              orElse: () {
              return {#screen: () => null};
            })[#screen]?.call();
      if (widget == null) {
        throw NoRouteFoundError(settings.name, settings.arguments);
      }

      if (widget is! StatelessScreen &&
          widget is! StatefulScreen &&
          widget is! RoutableWidget) {
        throw NotManageableWidgetException(widget);
      }

      if (settings.arguments != null) {
        KareeRouter._lastArguments = settings.arguments;
      }
      return cupertino.PageRouteBuilder(
          settings: RouteSettings(
              name: KareeRouter.currentRoute,
              arguments: settings.arguments ?? KareeRouter._lastArguments),
          transitionDuration: Duration(milliseconds: 0),
          pageBuilder: (_, a1, a2) {
            // KareeRouter.currentContext = _;
            return widget;
          });
    } on NoRouteFoundError catch (e, st) {
      KareeRouter._lastArguments = [
        settings.name!,
        if (KareeRouter.currentRoute != null) KareeRouter.currentRoute!,
        if (settings.arguments != null) settings.arguments.toString()
      ];
      return cupertino.PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 0),
          pageBuilder: (_, a1, a2) => KareeRouterErrorWidget(
              'No screen found with name ${settings.name}',
              st,
              KareeErrorCode.screenNotFound,
              KareeRouter._lastArguments));
    } on NotManageableWidgetException catch (ex, st) {
      KareeRouter._lastArguments = [
        ex.screen.toString(),
        settings.name!,
        if (KareeRouter.currentRoute != null) KareeRouter.currentRoute!,
        if (settings.arguments != null) settings.arguments.toString()
      ];
      return cupertino.PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 0),
          pageBuilder: (_, a1, a2) => KareeRouterErrorWidget(ex.message, st,
              KareeErrorCode.notKareeScreen, KareeRouter._lastArguments));
    }
  }

  ///
  /// Function used to find initial screen for `/`. Screen selected should set
  /// isInitial to `true`
  ///
  static cupertino.Widget initialScreen() {
    try {
      _RouteEntry? firstRoute = findActionFor('/');
      if (firstRoute == null) {
        return screens
            .firstWhere((routeItem) => routeItem[#initial] ?? false)[#screen]
            ?.call();
      } else {
        return firstRoute.action();
      }
    } catch (e, st) {
      return KareeRouterErrorWidget(
          'No Initial Screen found', st, KareeErrorCode.noInitialScreen, [""]);
    }
  }

  ///
  /// This function returns the screen view from its name.
  ///
  static cupertino.Widget componentForRouteName(String s) {
    try {
      final scr = screens.firstWhere((routeItem) {
        print(
            "\n### Screen name = ${routeItem[#name]}, Widget = $routeItem match ? = $s");
        return routeItem[#name] == s;
      }, orElse: () => {#screen: null})['screen' as Symbol];
      return scr;
    } catch (e, st) {
      return KareeRouterErrorWidget('No Screen found with name `$s`', st,
          KareeErrorCode.screenNotFound, [s]);
    }
  }

  ///
  /// Implementation of navigator to goback to previous context.
  ///
  static goBack() {
    if (KareeRouter.navigatorKey.currentState!.canPop()) {
      KareeRouter.navigatorKey.currentState!.pop();
    }
  }

  ///
  /// Default Karee Router.
  ///
  static router(cupertino.BuildContext context) {
    launchInternalRoute();
    return appRoute;
  }
}

///
/// Default Karee Transition.
///
class RouteTransition<T> extends cupertino.CupertinoPageRoute<T> {
  RouteTransition(
      {required cupertino.WidgetBuilder builder,
      required cupertino.RouteSettings settings})
      : super(builder: builder, settings: settings, maintainState: true);

  @override
  cupertino.Widget buildTransitions(
      cupertino.BuildContext context,
      cupertino.Animation<double> animation,
      cupertino.Animation<double> secondaryAnimation,
      cupertino.Widget child) {
    return cupertino.CupertinoPageTransition(
        child: child,
        linearTransition: true,
        primaryRouteAnimation: cupertino.CurvedAnimation(
          parent: animation,
          curve: cupertino.Curves.slowMiddle,
          reverseCurve: cupertino.Curves.bounceInOut,
        ),
        secondaryRouteAnimation: cupertino.CurvedAnimation(
          parent: secondaryAnimation,
          curve: cupertino.Curves.slowMiddle,
          reverseCurve: cupertino.Curves.easeInToLinear,
        ));
  }
}
