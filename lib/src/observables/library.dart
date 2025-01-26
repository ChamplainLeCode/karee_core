/// ## Karee Lite State Manager
///
/// Lite State manager integrated in Karee. It helps to mange your UI
/// by providing a Widget that can be refreshed when change happens on it's observable.
///
/// Karee Lite State Manager offers you:
///
/// ### Observable
///
/// - Of: Observable used to subscribe a listener on change,
///   * **Of(T value)** that builds an observable from a value.
///   * **Of< T >.type()** that retrieves an observable for a specific type.
///
/// ### Observer
///
/// - Observer: Widget that read changes of Observable,
///   * **Observer.on< T >**: Widget that watches changes on observables of type T.
///   * **Observer()**: Widget that watches changes on specifed observables.
library karee.core.state_manager;

export 'observable.dart';
export 'persistent_context.dart';
export 'observable_widget.dart';
