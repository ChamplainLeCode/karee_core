import 'dart:math' as math show Point;

import 'package:flutter/material.dart';
import '../observables/observable.dart';
import 'screen_widget.dart';
import '../observables/observable_widget.dart';

///
/// Bucket Widget, a new Material widget that provides you a simple and pretty
/// way to send your main menu behind of screen. To take full advantages of this
/// we recommend you to set a RouterWidget as his child.
///
class Bucket extends StatefulComponent {
  /// **child** of the bucket, this widget is displayed at the top layer
  final Widget child;

  /// **decoration** is used to decorate the background of the
  /// bottom layer
  final Decoration? decoration;

  /// **drawer** is used as the background widget shown behind the child
  final Widget? drawer;

  /// **enableBucketDragGesture** Whether this bucket should be opened or
  /// closed through the drag
  final bool enableBucketDragGesture;

  /// **onBucketChange** function triggered when the bucket is opened or closed
  final void Function(bool)? onBucketChange;

  /// Bucket Widget, a new Material widget that provides you a simple and pretty
  /// way to send your main menu behind of screen. To take full advantages of this
  /// we recommend you to set a RouterWidget as his child.
  Bucket(
      {required this.child,
      this.decoration,
      this.drawer,
      this.enableBucketDragGesture = true,
      this.onBucketChange,
      Key? key})
      : super(key: key);

  @override
  BucketState createState() => BucketState();

  static BucketState? of(BuildContext context) {
    var st = context.findAncestorStateOfType<BucketState>();
    return st;
  }
}

class BucketState extends ComponentState<Bucket> {
  /// **_child** of the bucket, this widget is displayed at the top layer.
  late final Widget _child;

  /// **_childPosition** of the `child` of the bucket displayed at the top layer.
  ///
  /// An `Observable` of the child widget position displayed at the top layer.
  late final Of<math.Point<double>> _childPosition;

  /// **_bucketChildSize**
  /// The [Size] of the [Bucket] `child` displayed at the top layer.
  ///
  /// Will be deduced from the screen size.
  Of<Size>? _bucketChildSize;

  /// **_bucketActionLock** Utility variable to close or open the bucket.
  bool _bucketActionLock = true;

  /// **_dragStartPoint** The bucket drag starting point `onHorizontalDragStart`.
  math.Point? _dragStartPoint;

  /// **isOpen** Getter used to know whether the bucket is open or not.
  bool get isOpen => !_bucketActionLock;

  /// **_bucketLockEndPoint** End point of the bucket `child` displayed
  /// at the top layer from the screen top left origin.
  late final math.Point<double> _bucketLockEndPoint =
      math.Point(screenSize.width * .80, screenSize.height * .125);

  /// **_bucketLockStartPoint** Start point of the bucket `child` displayed
  /// at the top layer of the screen top left origin.
  late final math.Point<double> _bucketLockStartPoint = math.Point(0, 0);

  @override
  initState() {
    // Initialisation the bucket child to display at the top layer
    _child = widget.child;
    // The position of the bucket child is initialized to the screen top left origin.
    _childPosition = Of(math.Point(0.0, 0.0));
    super.initState();
  }

  @override
  void dispose() {
    try {
      context.findAncestorStateOfType<BucketActionButtonState>()?.dispose();
      // ignore: empty_catches
    } catch (e) {
    } finally {
      super.dispose();
    }
  }

  @override
  Widget builder(BuildContext context) {
    _bucketChildSize ??= Of(Size.copy(screenSize));

    return GestureDetector(
        onHorizontalDragStart:
            !widget.enableBucketDragGesture ? null : _onBucketDragStart,
        onHorizontalDragEnd:
            !widget.enableBucketDragGesture ? null : _onBucketDragEnd,
        onHorizontalDragUpdate:
            !widget.enableBucketDragGesture ? null : _onBucketDragged,
        child: Stack(children: [
          Positioned(
              top: 0,
              left: 0,
              width: screenSize.width,
              height: screenSize.height,
              child: Material(
                  child: SafeArea(
                      top: false,
                      child: Container(
                        decoration: widget.decoration,
                        child: widget.drawer,
                      )))),
          Observer(
              of: _childPosition,
              builder: (_) => AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  top: _childPosition.value.y,
                  left: _childPosition.value.x,
                  width: _bucketChildSize?.value.width ?? screenSize.width,
                  height: _bucketChildSize?.value.height ?? screenSize.height,
                  child: ClipRRect(
                      borderRadius: _bucketActionLock
                          ? BorderRadius.zero
                          : BorderRadius.circular(20),
                      child: GestureDetector(
                          onTap: _bucketActionLock ? null : close,
                          child: _child)))),
        ]));
  }

  /// *void _onBucketDragStart** Initialisation of the bucket `drag event starting point`.
  ///
  /// See [DragStartDetails]
  void _onBucketDragStart(DragStartDetails d) =>
      _dragStartPoint = math.Point(d.globalPosition.dx, d.globalPosition.dy);

  /// **void _onBucketDragEnd** Callback responses to the bucket `drag end event`.
  ///
  /// If the bucket is closed,
  /// - but it's position is greater or equal to 100,
  ///   - open or unlock the bucket.
  ///   - Else, close the bucket.
  /// Else
  /// - but it's position relative to the **_buttonLockEndPoint** is greater or equal to 100,
  ///   - Close the bucket.
  ///   - Else, open or unlock the bucket.
  ///
  /// See [DragEndDetails]
  void _onBucketDragEnd(DragEndDetails d) => !isBucketOpen
      ? _childPosition.value.x >= 100
          ? open()
          : close()
      : (_bucketLockEndPoint.x - _childPosition.value.x).abs() >= 100
          ? close()
          : open();

  /// **void _onBucketDragged** Callback responses to the bucket `drag event`.
  ///
  /// Algorithm to be explained
  ///
  /// See [DragUpdateDetails]
  void _onBucketDragged(DragUpdateDetails dragInfo) {
    double dx = 0;

    if (_bucketActionLock) {
      if (dragInfo.globalPosition.dx < _dragStartPoint!.x.toDouble()) {
        dx = _bucketLockStartPoint.x;
      } else {
        dx = _dragStartPoint!.distanceTo(
            math.Point(dragInfo.globalPosition.dx, _dragStartPoint!.y));
      }
      // Question: Peut il arriver que dx = 0 ?
      // Si oui, il n'y aura pas d'erreur ?
      _childPosition.value = math.Point(dx, dx / 2);
    } else {
      if (dragInfo.globalPosition.dy > _bucketLockEndPoint.y ||
          // ignore: curly_braces_in_flow_control_structures
          dragInfo.globalPosition.dy > _dragStartPoint!.y) if (dragInfo
              .globalPosition.dx >
          _dragStartPoint!.x) {
        dx = 0;
      } else {
        dx = _dragStartPoint!.x - dragInfo.globalPosition.dx;
      }

      var absDx = _bucketLockEndPoint.x - dx;
      _childPosition.value =
          math.Point(absDx < 0 ? 0 : absDx, _bucketLockEndPoint.y);
    }
  }

  /// **isBucketOpen** Getter used to know whether the bucket is opened or not.
  bool get isBucketOpen => !_bucketActionLock;

  ///
  /// **void open()** Method used to open the bucket.
  ///
  void open() {
    _bucketActionLock = false;
    _childPosition.value = _bucketLockEndPoint;
    if (widget.onBucketChange != null) {
      Future.microtask(() => widget.onBucketChange!(true));
    }
    _bucketChildSize?.value =
        Size(screenSize.width * .80, screenSize.height * .8);
  }

  ///
  /// **void close()** Method used to close the bucket.
  void close() {
    _bucketActionLock = true;
    _bucketChildSize?.value = screenSize;
    if (widget.onBucketChange != null) {
      Future.microtask(() => widget.onBucketChange!(false));
    }
    _childPosition.value = _bucketLockStartPoint;
  }
}

///
/// BucketActionButton, is used as the default button to manage event on Bucket.
///
class BucketActionButton extends StatefulComponent {
  ///
  /// **icon** an `AnimatedIconData`, used when bucket changes its state.
  ///
  final AnimatedIconData icon;

  ///
  /// **iconColor** the butcket action button icon `Color`.
  ///
  final Color? iconColor;

  ///
  /// **iconSize** the butcket action button icon `Size`.
  ///
  final double? iconSize;

  ///
  /// **iconSemanticLabel** the butcket action button icon `SemanticLabel`.
  ///
  final String? iconSemanticLabel;

  ///
  /// **iconTextDirection** the butcket action button icon `TextDirection`.
  ///
  final TextDirection? iconTextDirection;

  ///
  /// BucketActionButton, is used as the default button to manage event on Bucket.
  ///
  BucketActionButton(this.iconSemanticLabel, this.iconTextDirection,
      {required this.icon, this.iconColor, this.iconSize, Key? key})
      : super(key: key);

  @override
  BucketActionButtonState createState() => BucketActionButtonState();
}

class BucketActionButtonState extends ComponentState<BucketActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconAnimationController;

  @override
  initState() {
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget builder(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: widget.icon,
          progress: _iconAnimationController,
          color: widget.iconColor,
          size: widget.iconSize,
          semanticLabel: widget.iconSemanticLabel,
          textDirection: widget.iconTextDirection,
        ),
        onPressed: () {
          var state = Bucket.of(context);
          if (state == null) return;
          if (state.isOpen) {
            // Close the bucket if it is opened
            closeBucket();
          } else {
            // Open the bucket if it is closed
            openBucket();
          }
        });
  }

  ///
  /// Method used to send the *close event* to the default Bucket.
  ///
  /// Bucket is accessed through **Bucket.of(context)**
  void closeBucket() {
    Bucket.of(context)?.close();
    Future.microtask(() => _iconAnimationController.animateTo(0));
  }

  ///
  /// Method used to animate the passed icon.
  ///
  void animateIcon(bool state) => state
      ? Future.microtask(() => _iconAnimationController.animateBack(1))
      : Future.microtask(() => _iconAnimationController.animateTo(0));

  /// Method used to send the *open event* of the default Bucket.
  ///
  /// Bucket is accessed through **Bucket.of(context)**
  ///
  void openBucket() {
    Bucket.of(context)?.open();
    Future.microtask(() => _iconAnimationController.animateBack(1));
  }
}
