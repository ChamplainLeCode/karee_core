import 'package:flutter/material.dart';
import '../constances/library.dart' show KareeConstants;
import '../observables/library.dart' show Observer;
import '../utils/app_localization.dart';
import '../routes/router.dart' show KareeRouter;

///
/// StatelessWidget that is used to add some view in Navigation context.
///
/// This widget also allows you to access to context outside the build function.
///
@immutable
abstract class StatelessScreen extends StatelessWidget {
  dynamic get arguments =>
      ModalRoute.of(KareeRouter.currentContext!)?.settings.arguments;

  /// `Getter`: to retrieve the terminal **size** properties.
  ///
  /// See [Size]
  @protected
  Size get screenSize => MediaQuery.of(context).size;

  /// `Getter`: to retrieve the terminal **mediaQuery** properties.
  ///
  /// See [MediaQueryData]
  MediaQueryData get mediaQuery => MediaQuery.of(context);

  /// `Getter`: to retrieve the screen navigation **context**.
  ///
  BuildContext get context => KareeRouter.currentContext!;

  /// Constructor for [StatelessScreen]
  StatelessScreen({Key? key}) : super(key: key);

  /// see [build]
  @protected
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    KareeRouter.currentContext = context;
    return Observer.on<AppLocalization>(
        tag: KareeConstants.kApplicationLocalizationTag,
        builder: (_, l) => builder(context));
  }
}

///
/// StatelessComponent that is used to substitue StatelessWidget to access
/// context outside the build function, expose also [screenSize], [mediaQuery]
/// and [arguments]
///
@immutable
abstract class StatelessComponent extends StatelessWidget {
  /// Constructor for [StatelessComponent]
  StatelessComponent({Key? key}) : super(key: key);

  ///
  /// Navigation parameter
  ///
  dynamic get arguments =>
      ModalRoute.of(KareeRouter.currentContext!)?.settings.arguments;

  // BuildContext? _context;

  /// `Getter`: to retrieve the terminal **size** properties.
  ///
  /// See [Size]
  @protected
  Size get screenSize => MediaQuery.of(KareeRouter.currentContext!).size;

  /// `Getter`: to retrieve the terminal **mediaQuery** properties.
  ///
  /// See [MediaQueryData]
  MediaQueryData get mediaQuery => MediaQuery.of(context);

  /// `Getter`: to retrieve the screen navigation **context**.
  ///
  BuildContext get context => KareeRouter.currentContext!;

  /// see [build]
  @protected
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // _context = context;
    return builder(context);
  }
}

///
/// StatefulComponent that is used to substitute the StatefulWidget for accessing
/// [ComponentState.screenSize], [ComponentState.mediaQuery] and
/// [ComponentState.arguments]
///
@immutable
abstract class StatefulComponent extends StatefulWidget {
  /// Constructor for [StatefulComponent]
  StatefulComponent({Key? key}) : super(key: key);

  @override
  ComponentState<StatefulComponent> createState();
}

abstract class ComponentState<T extends StatefulComponent> extends State<T> {
  ///
  /// Navigation parameter
  ///
  dynamic get arguments => ModalRoute.of(context)?.settings.arguments;

  /// `Getter`: to retrieve the terminal **mediaQuery** properties.
  ///
  /// See [MediaQueryData]
  MediaQueryData get mediaQuery => MediaQuery.of(context);

  /// `Getter`: to retrieve the terminal **size** properties.
  ///
  /// See [Size]
  @protected
  Size get screenSize => MediaQuery.of(context).size;

  @protected
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }

  /// Function used to update the widget with [setState]
  void update() => setState(() {});
}

///
/// StatefulWidget that is used to add some view in Navigation context.
///
@immutable
abstract class StatefulScreen extends StatefulWidget {
  /// Constructor for [StatefulScreen]
  StatefulScreen({Key? key}) : super(key: key);

  @override
  ScreenState<StatefulScreen> createState();
}

abstract class ScreenState<T extends StatefulScreen> extends State<T> {
  ///
  /// Navigation parameter
  ///
  dynamic get arguments => ModalRoute.of(context)?.settings.arguments;

  /// `Getter`: to retrieve the terminal **mediaQuery** properties.
  ///
  /// See [MediaQueryData]
  MediaQueryData get mediaQuery => MediaQuery.of(context);

  /// `Getter`: to retrieve the terminal **size** properties.
  ///
  /// See [Size]
  @protected
  Size get screenSize => MediaQuery.of(context).size;

  /// see [build]
  @protected
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    KareeRouter.currentContext = context;
    return Observer.on<AppLocalization>(
        tag: KareeConstants.kApplicationLocalizationTag,
        builder: (_, l) => builder(context));
  }
}
