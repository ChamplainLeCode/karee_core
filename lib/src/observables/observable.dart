import 'persistent_context.dart';

typedef ObservableListener<T> = void Function(T value);

abstract class Observable<T> {
  ///
  /// Entry point to add a subscriber to an observable
  ///
  void listen(ObservableListener<T> listener);

  ///
  /// Entry point to remove a subscriber to an observable
  ///
  void unListen(ObservableListener<T> listener);

  /// Manually refresh this observale.
  ///
  /// Useful in case of unmanagable object. if you have an Object like
  /// ```dart
  ///     class User {
  ///       String name;
  ///       int age;
  ///       User(this.name, this.age);
  ///     }
  /// ```
  /// and you want to use instance of this class as observable. you can
  /// do something like this to notify all observers that some change happened.
  /// ```
  /// final userObs = Of(User('Patrick', 23));
  ///
  /// userObs.value.age++;
  ///
  /// userObs.refresh();
  /// ```
  void refresh();
}

/// This basic implementation of Observable, this offer a lite observable.
/// Observer subscribes to an Observable. Then that observer reacts to whatever
/// item the Observable emits.
class Of<T> implements Observable<T> {
  T _value;
  dynamic tag;

  /// Build an observable from a value
  Of(this._value) : tag = #base;

  /// build an Observable from a type
  factory Of.type() => PersistentContext.of<T>();

  /// Create an observable from value and tag. then persis to cache
  ///
  factory Of.tag(T value, [dynamic tag = #base]) =>
      PersistentContext.valueWithTag(value, tag);

  /// Get persisted observable by tag
  static withTag<T>(dynamic tag) => PersistentContext.withTag<T>(tag);

  /// Free observable from cache
  static void free<E>(Of<E> obs) => PersistentContext.remove<E>(obs);

  /// Permanent listeners on this observable
  // ignore: prefer_final_fields
  Set<ObservableListener<T>> _listener = {};

  /// Ephemeral listeners on this observable.
  /// Means that, every time that this observable change
  /// its value, this set is clean.
  // ignore: prefer_final_fields
  Set<ObservableListener<T>> _alert = {};

  /// Method used to set new value of an observable. this will call all listener
  /// that listen to this.
  set value(T value) {
    _value = value;
    for (var listener in _listener) {
      listener.call(value);
    }
    _alert
      ..forEach((alerter) => alerter.call(value))
      ..clear();
  }

  ///
  /// Get the current value of this observable.
  ///
  T get value => _value;

  @override
  listen(ObservableListener<T> listener) {
    _listener.add(listener);
  }

  @override
  unListen(ObservableListener<T> listener) {
    _listener.remove(listener);
  }

  @override
  String toString() => _value.toString();

  ///
  /// Add an ephemeral listener to this observable.
  /// this listener will be unsubscribe after the next change.
  ///
  void alert(ObservableListener<T> alerter) => _alert.add(alerter);

  @override
  void refresh() {
    for (var listener in _listener) {
      listener.call(value);
    }
    _alert
      ..forEach((alerter) => alerter.call(value))
      ..clear();
  }
}
