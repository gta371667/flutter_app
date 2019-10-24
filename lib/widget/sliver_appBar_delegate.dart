import 'dart:math' as math;

import 'package:flutter/material.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
    this.pinned = false,
    this.floating = false,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  final bool pinned;
  final bool floating;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    print("ttt build $shrinkOffset $overlapsContent");
//    return child;
//    return new SizedBox.expand(child: child);

    var topPadding = 0;

    final double visibleMainHeight = maxExtent - shrinkOffset - topPadding;

    final double toolbarOpacity =
        !pinned || (floating != null) ? ((visibleMainHeight) / kToolbarHeight).clamp(0.0, 1.0) : 1.0;

    final Widget appBar = FlexibleSpaceBar.createSettings(
      minExtent: minExtent,
      maxExtent: maxExtent,
      currentExtent: math.max(minExtent, maxExtent - shrinkOffset),
      toolbarOpacity: toolbarOpacity,
      child: AppBar(
        title: child,
        flexibleSpace: (child == null && child != null)
            ? Semantics(child: child, header: true)
            : child,
        toolbarOpacity: toolbarOpacity,
        bottomOpacity: pinned ? 1.0 : (visibleMainHeight / 1).clamp(0.0, 1.0),
      ),
    );
    return appBar;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    print("ttt shouldRebuild");

    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
