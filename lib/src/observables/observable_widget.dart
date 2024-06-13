import 'package:flutter/widgets.dart';
import './persistent_context.dart';
import './observable.dart';
import '../widgets/screen_widget.dart';

/// An overriding of WidgetBuilder.
typedef _OfBuilder<K> = Widget Function(BuildContext ctx);

/// An overloading of see [_OfBuilder<K>] used to send state on building.
typedef _OfBuilderWithState<K> = Widget Function(BuildContext ctx, Of<K> state);

/// ### Observer<T>
/// Used as base Widget of this library. When you want to watch changes on an object,
/// add this widget in your flutter tree.
///
class Observer<T> extends _ObservableElement<T> {
  /// ### Definition
  /// ObserverBuilder for watching changes on an object, by sending its Type.
  /// ### Usage
  /// To use this, you should first setup the provider for this type. Meaning that you should
  /// send the general instance of this type in `KareeMaterialApp` to watch
  /// in all your application.
  /// ```dart
  ///   Observer.on<int>(
  ///     builder: (ctx, counterObs) {
  ///     return Text('general counter ${counterObs.value}');
  ///   }),
  /// ```
  ///
  /// See also [Observer.withProviders]
  static _OfWidgetBuilder<E> on<E>(
      {dynamic tag = #base, required _OfBuilderWithState<E> builder}) {
    return _OfWidgetBuilder<E>(
        of: PersistentContext.getObsWithTag<E>(tag), child: builder);
  }

  /// ### Definition
  /// Observer.withProviders method is used to register objects
  /// to observe in your application.
  /// ### Usage
  /// To use this, just provide all observable instances and a widgetBuilder.
  /// ```dart
  ///    Observer.withProviders(
  ///       providers: [Of(User(firstName: 'Mark', lastName: 'Ngourtchou'))],
  ///       child: (ctx) {
  ///         return Scaffold(
  ///           body: Observe.on<User>(
  ///             builder: (ctx, userObs) =>
  ///               Text(
  ///                 'Welcome ${userObs.value.firstName}'
  ///                 ' ${userObs.value.lastName}')
  ///           )
  ///         );
  ///       }
  ///     )
  /// ```
  ///
  /// See also [Observer.withProviders]
  static Widget withProviders(
      {required List<Of> providers, required _OfBuilder child}) {
    return _OfWidgetProvider(obs: providers, child: child);
  }

  /// ### Definition
  /// Observer: To watch changes of a specific object, send this one(the object)
  /// as value of the property **of**,
  ///
  /// and provide a widget builder that will be used when your watched object changes.
  ///
  /// ### Parameters
  ///
  /// **[of]**: Master observable to bind with this observer.
  ///
  /// **[child]**: Widget builder of this observer.
  ///
  /// **[slaves]**: Additional observables that should be bound to this observer.
  /// This parameter is optional.
  ///
  /// ### Usage
  /// To use this, you should first setup the provider for this type. Meaning you should
  ///
  /// send the general instance of this type in `KareeMaterialApp` to watch it
  /// in all your application.
  /// ```dart
  ///   final counter = Of(0);
  ///   Observer.on<int>(
  ///     of: counter,
  ///     child: (ctx) {
  ///     return Text('Counter value ${counter.value}');
  ///   }),
  /// ```
  ///
  /// See [Observer.withProviders]
  ///
  /// See also [Observer.on]
  Observer(
      {required Of<T> of,
      @Deprecated("Replaced by 'builder'") _OfBuilder<T>? child,
      _OfBuilder<T>? builder,
      List<Of> slaves = const []})
      : assert(builder != null || child != null),
        super(of, (builder ?? child)!, slaves);

  @override
  _OfWidgetManager<T> createState() => _OfWidgetManager<T>();
}

/// **_OfWidgetManager** Object that is responsible to assign the
/// mutable state location in the tree to the widget builder, and notify the
/// state changes to the subscriber.
class _OfWidgetManager<T> extends _ObservableState<T> {
  /// **_notifyUpdate()** Here we pass the location in the tree where the
  /// widget builds, to the component builder and notify the changes in the
  /// state to it's subscriber, so as to update the widget tree with it's new
  /// value.
  @override
  void _notifyUpdate(T value) {
    widget.child(context);
    super._notifyUpdate(value);
  }
}

/// **_OfWidgetBuilder** Object that is responsible of creating
/// a mutable state for a given widget containing a builder with context and
/// state, and a master observable.
class _OfWidgetBuilder<E> extends _ObservableElementWithState<E> {
  _OfWidgetBuilder({required _OfBuilderWithState<E> child, required Of<E> of})
      : super(of, child);

  // Creates the mutable state for this widget at a given location in the tree.
  @override
  _OfWidgetBuilderStateManager<E> createState() =>
      _OfWidgetBuilderStateManager<E>();
}

/// **_OfWidgetBuilderStateManager** Object that is responsible to assign the
/// mutable state location in the tree and the Master observable to the widget
/// builder, and notify the state changes to the subscriber.
class _OfWidgetBuilderStateManager<E> extends _ObservableStateWithObs<E> {
  /// **_notifyUpdate()** Here we pass the location in the tree where the
  /// widget builds, and the master observable to the component builder and
  /// notify the changes in the state to it's subscriber, so as to update the
  /// widget tree with it's new value.
  @override
  void _notifyUpdate(E value) {
    widget.child(context, widget.of);
    super._notifyUpdate(value);
  }
}

/// Class used internally to Build [Observer] widget with observable to persist.
class _OfWidgetProvider<T> extends StatelessComponent {
  /// The widget list of observables.
  final List<Of<T>> obs;

  /// The widget builder.
  final _OfBuilder<T> child;
  _OfWidgetProvider({required this.obs, required this.child}) {
    for (var obs in obs) {
      PersistentContext.value(obs);
    }
  }

  @override
  Widget builder(BuildContext context) {
    return child(context);
  }
}

/// `_ObservableElement`: Abstract object state component containing a Master
/// observable, and additional slave observables definition.
abstract class _ObservableElement<E> extends StatefulComponent {
  /// The object Master observable.
  late final Of<E> of;

  /// The object additional slave observables.
  late final List<Of> slaveObservables;

  /// The object builder.
  late final _OfBuilder<E> child;
  _ObservableElement(this.of, this.child, [this.slaveObservables = const []]);
}

/// `_ObservableState`: Object state component containing a Master observable,
/// and additional slave observables.
abstract class _ObservableState<E>
    extends ComponentState<_ObservableElement<E>> {
  /// **initState()** Here when this object is inserted into the three,
  /// we subscribe to the Master observable and the additional observables,
  /// so as to bound them to the component state lifecycle.
  @override
  initState() {
    widget.of.listen(_notifyUpdate);
    for (var ob in widget.slaveObservables) {
      ob.listen(_notifyUpdateSlave);
    }
    super.initState();
  }

  /// **didUpdateWidget()** Here when the observable state changes, we unsubscribe
  /// from the oldWidget and subscribe to the new one if the updated widget configurations
  /// requires replacing the object.
  @override
  void didUpdateWidget(_ObservableElement<E> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldObs = oldWidget.of;
    final currentObs = widget.of;
    if (currentObs != oldObs) oldObs.unListen(_notifyUpdate);
    currentObs.listen(_notifyUpdate);
  }

  /// **_notifyUpdate()** Here we notify the changes in the Master observable
  /// state to it's subscriber, so as to update the widget tree with it's new
  /// value.
  @mustCallSuper
  void _notifyUpdate(E value) {
    if (mounted) super.update();
  }

  /// **_notifyUpdateSlave()** Here we notify the changes in the additional observables
  /// states to it's subscriber, so as to update the widget tree with their new
  /// values.
  @mustCallSuper
  void _notifyUpdateSlave(dynamic value) {
    if (mounted) super.update();
  }

  /// **dispose()** Here we unsubscribe the observables of the object
  /// when it is removed from the widget three permanently.
  @override
  void dispose() {
    widget.of.unListen(_notifyUpdate);
    super.dispose();
  }

  @override
  Widget builder(BuildContext context) {
    return widget.child(context);
  }
}

/// Base class used as Statee for [Observer].
abstract class _ObservableElementWithState<E> extends StatefulComponent {
  /// The object Master observable.
  late final Of<E> of;

  /// The object builder containing a state observable.
  late final _OfBuilderWithState<E> child;
  _ObservableElementWithState(this.of, this.child);
}

/// `_ObservableStateWithObs`: Object state component containing essentially
/// a Master observable.
abstract class _ObservableStateWithObs<E>
    extends ComponentState<_ObservableElementWithState<E>> {
  /// **initState()** Here when this object is inserted into the three,
  /// we subscribe to the Master observable, so as to bound it to the component
  /// state lifecycle.
  @override
  initState() {
    widget.of.listen(_notifyUpdate);
    super.initState();
  }

  /// **didUpdateWidget()** Here when the observable state changes, we
  /// unsubscribe from the oldWidget and subscribe to the new one if the
  /// updated widget configurations requires replacing the object.
  @override
  void didUpdateWidget(_ObservableElementWithState<E> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldObs = oldWidget.of;
    final currentObs = widget.of;
    if (currentObs != oldObs) oldObs.unListen(_notifyUpdate);
    currentObs.listen(_notifyUpdate);
  }

  /// **_notifyUpdate()** Here we notify the changes in the Master observable
  /// state to it's subscriber, so as to update the widget tree with it's new
  /// value.
  @mustCallSuper
  void _notifyUpdate(E value) {
    if (mounted) super.update();
  }

  /// **dispose()** Here we unsubscribe the observables of the object
  /// when it is removed from the widget three permanently.
  @override
  void dispose() {
    widget.of.unListen(_notifyUpdate);
    super.dispose();
  }

  @override
  Widget builder(BuildContext context) {
    return widget.child(context, widget.of);
  }
}
