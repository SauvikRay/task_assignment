// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


// Standard iOS 10 tab bar height.
const double _kTabBarHeight = 50.0;

const Color _kDefaultTabBarBorderColor = CupertinoDynamicColor.withBrightness(
  color: Color(0x4D000000),
  darkColor: Color(0x29000000),
);
const Color _kDefaultTabBarInactiveColor = CupertinoColors.inactiveGray;

/// An iOS-styled bottom navigation tab bar.
///
/// Displays multiple tabs using [BottomNavigationBarItem] with one tab being
/// active, the first tab by default.
///
/// This [StatelessWidget] doesn't store the active tab itself. You must
/// listen to the [onTap] callbacks and call `setState` with a new [currentIndex]
/// for the new selection to reflect. This can also be done automatically
/// by wrapping this with a [CupertinoTabScaffold].
///
/// Tab changes typically trigger a switch between [Navigator]s, each with its
/// own navigation stack, per standard iOS design. This can be done by using
/// [CupertinoTabView]s inside each tab builder in [CupertinoTabScaffold].
///
/// If the given [backgroundColor]'s opacity is not 1.0 (which is the case by
/// default), it will produce a blurring effect to the content behind it.
///
/// When used as [CupertinoTabScaffold.tabBar], by default [CupertinoTabBar]
/// disables text scaling to match the native iOS behavior. To override
/// this behavior, wrap each of the `navigationBar`'s components inside a
/// [MediaQuery] with the desired [TextScaler].
///
/// {@tool dartpad}
/// This example shows a [CupertinoTabBar] placed in a [CupertinoTabScaffold].
///
/// ** See code in examples/api/lib/cupertino/bottom_tab_bar/cupertino_tab_bar.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [CupertinoTabScaffold], which hosts the [CupertinoTabBar] at the bottom.
///  * [BottomNavigationBarItem], an item in a [CupertinoTabBar].
///  * <https://developer.apple.com/design/human-interface-guidelines/ios/bars/tab-bars/>
class CustomCupertinoTabBar extends StatefulWidget implements PreferredSizeWidget {
  /// Creates a tab bar in the iOS style.
  const CustomCupertinoTabBar({
    super.key,
    this.shape,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor = _kDefaultTabBarInactiveColor,
    this.iconSize = 30.0,
    this.height = _kTabBarHeight,
    this.border = const Border(
      top: BorderSide(
        color: _kDefaultTabBarBorderColor,
        width: 0.0, // 0.0 means one physical pixel
      ),
    ),
    this.notchMargin=4.0
  }) : assert(
         items.length >= 2,
         "Tabs need at least 2 items to conform to Apple's HIG",
       ),
       assert(0 <= currentIndex && currentIndex < items.length),
       assert(height >= 0.0);

  final NotchedShape? shape;

  /// The interactive items laid out within the bottom navigation bar.
  final List<BottomNavigationBarItem> items;

  /// The callback that is called when a item is tapped.
  ///
  /// The widget creating the bottom navigation bar needs to keep track of the
  /// current index and call `setState` to rebuild it with the newly provided
  /// index.
  final ValueChanged<int>? onTap;

  /// The index into [items] of the current active item.
  ///
  /// Must be between 0 and the number of tabs minus 1, inclusive.
  final int currentIndex;

  /// The background color of the tab bar. If it contains transparency, the
  /// tab bar will automatically produce a blurring effect to the content
  /// behind it.
  ///
  /// Defaults to [CupertinoTheme]'s `barBackgroundColor` when null.
  final Color? backgroundColor;

  /// The foreground color of the icon and title for the [BottomNavigationBarItem]
  /// of the selected tab.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryColor` if null.
  final Color? activeColor;

  /// The foreground color of the icon and title for the [BottomNavigationBarItem]s
  /// in the unselected state.
  ///
  /// Defaults to a [CupertinoDynamicColor] that matches the disabled foreground
  /// color of the native `UITabBar` component.
  final Color inactiveColor;

  /// The size of all of the [BottomNavigationBarItem] icons.
  ///
  /// This value is used to configure the [IconTheme] for the navigation bar.
  /// When a [BottomNavigationBarItem.icon] widget is not an [Icon] the widget
  /// should configure itself to match the icon theme's size and color.
  final double iconSize;

  /// The height of the [CupertinoTabBar].
  ///
  /// Defaults to 50.
  final double height;

  /// The border of the [CupertinoTabBar].
  ///
  /// The default value is a one physical pixel top border with grey color.
  final Border? border;
  final double notchMargin;
  @override
  State<CustomCupertinoTabBar> createState() => _CustomCupertinoTabBarState();
  
  @override
    Size get preferredSize => Size.fromHeight(height);
  

  
}

class _CustomCupertinoTabBarState extends State<CustomCupertinoTabBar> {


  /// Indicates whether the tab bar is fully opaque or can have contents behind
  /// it show through it.
  bool opaque(BuildContext context) {
    final Color backgroundColor =
        widget.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor;
    return CupertinoDynamicColor.resolve(backgroundColor, context).alpha == 0xFF;
  }

late ValueListenable<ScaffoldGeometry> geometryListenable;
  final GlobalKey materialKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
  }
  @override
  Widget build(BuildContext context) {
     final bool hasFab = Scaffold.of(context).hasFloatingActionButton;
     final NotchedShape? notchedShape = widget.shape ;
  final CustomClipper<Path> clipper = notchedShape != null && hasFab
      ? _CustomBottomAppBarClipper(
          geometry: geometryListenable,
          shape: notchedShape,
          materialKey: materialKey,
          notchMargin: widget.notchMargin,
        )
      : const ShapeBorderClipper(shape: RoundedRectangleBorder());

    assert(debugCheckHasMediaQuery(context));
    final double bottomPadding = MediaQuery.viewPaddingOf(context).bottom;

    final Color backgroundColor = CupertinoDynamicColor.resolve(
      widget.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor,
      context,
    );

    BorderSide resolveBorderSide(BorderSide side) {
      return side == BorderSide.none
        ? side
        : side.copyWith(color: CupertinoDynamicColor.resolve(side.color, context));
    }

    // Return the border as is when it's a subclass.
    final Border? resolvedBorder = widget.border == null || widget.border.runtimeType != Border
      ? widget.border
      : Border(
        top: resolveBorderSide(widget.border!.top),
        left: resolveBorderSide(widget.border!.left),
        bottom: resolveBorderSide(widget.border!.bottom),
        right: resolveBorderSide(widget.border!.right),
      );

    final Color inactive = CupertinoDynamicColor.resolve(widget.inactiveColor, context);
    Widget result = DecoratedBox(
      decoration: BoxDecoration(
        border: resolvedBorder,
        color: backgroundColor,
      ),
      child: PhysicalShape(
        clipper:clipper ,
      color:Colors.white,
      elevation: 15,
        child: SizedBox(
          height: widget.height + bottomPadding,
          child: IconTheme.merge( // Default with the inactive state.
            data: IconThemeData(color: inactive, size: widget.iconSize),
            child: DefaultTextStyle( // Default with the inactive state.
              style: CupertinoTheme.of(context).textTheme.tabLabelTextStyle.copyWith(color: inactive),
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: Semantics(
                  explicitChildNodes: true,
                  child: Row(
                    // Align bottom since we want the labels to be aligned.
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: _buildTabItems(context),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (!opaque(context)) {
      // For non-opaque backgrounds, apply a blur effect.
      result = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: result,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildTabItems(BuildContext context) {
    final List<Widget> result = <Widget>[];
    final CupertinoLocalizations localizations = CupertinoLocalizations.of(context);

    for (int index = 0; index < widget.items.length; index += 1) {
      final bool active = index == widget.currentIndex;
      result.add(
        _wrapActiveItem(
          context,
          Expanded(
            // Make tab items part of the EditableText tap region so that
            // switching tabs doesn't unfocus text fields.
            child: TextFieldTapRegion(
              child: Semantics(
                selected: active,
                hint: localizations.tabSemanticsLabel(
                  tabIndex: index + 1,
                  tabCount: widget.items.length,
                ),
                child: MouseRegion(
                  cursor:  kIsWeb ? SystemMouseCursors.click : MouseCursor.defer,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: widget.onTap == null ? null : () { widget.onTap!(index); },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: _buildSingleTabItem(widget.items[index], active),
                    ),
                  ),
                ),
              ),
            ),
          ),
          active: active,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildSingleTabItem(BottomNavigationBarItem item, bool active) {
    return <Widget>[
      Expanded(
        child: Center(child: active ? item.activeIcon : item.icon),
      ),
      if (item.label != null) Text(item.label!),
    ];
  }

  /// Change the active tab item's icon and title colors to active.
  Widget _wrapActiveItem(BuildContext context, Widget item, { required bool active }) {
    if (!active) {
      return item;
    }

    final Color activeColor = CupertinoDynamicColor.resolve(
      widget.activeColor ?? CupertinoTheme.of(context).primaryColor,
      context,
    );
    return IconTheme.merge(
      data: IconThemeData(color: activeColor),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: activeColor),
        child: item,
      ),
    );
  }

  /// Create a clone of the current [CupertinoTabBar] but with provided
  /// parameters overridden.
  CustomCupertinoTabBar copyWith({
    Key? key,
    List<BottomNavigationBarItem>? items,
    Color? backgroundColor,
    Color? activeColor,
    Color? inactiveColor,
    double? iconSize,
    double? height,
    Border? border,
    int? currentIndex,
    ValueChanged<int>? onTap,
  }) {
    return CustomCupertinoTabBar(
      key: key,
      items: items ?? this.widget.items,
      backgroundColor: backgroundColor ?? this.widget.backgroundColor,
      activeColor: activeColor ?? this.widget.activeColor,
      inactiveColor: inactiveColor ?? this.widget.inactiveColor,
      iconSize: iconSize ?? this.widget.iconSize,
      height: height ?? this.widget.height,
      border: border ?? this.widget.border,
      currentIndex: currentIndex ?? this.widget.currentIndex,
      onTap: onTap ?? this.widget.onTap,
    );
  }
}


class _CustomBottomAppBarClipper extends CustomClipper<Path> {
  const _CustomBottomAppBarClipper({
    required this.geometry,
    required this.shape,
    required this.materialKey,
    required this.notchMargin,
  }) : super(reclip: geometry);

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final GlobalKey materialKey;
  final double notchMargin;

  // Returns the top of the BottomAppBar in global coordinates.
  //
  // If the Scaffold's bottomNavigationBar was specified, then we can use its
  // geometry value, otherwise we compute the location based on the AppBar's
  // Material widget.
  double get bottomNavigationBarTop {
    final double? bottomNavigationBarTop = geometry.value.bottomNavigationBarTop;
    if (bottomNavigationBarTop != null) {
      return bottomNavigationBarTop;
    }
    final RenderBox? box = materialKey.currentContext?.findRenderObject() as RenderBox?;
    return box?.localToGlobal(Offset.zero).dy ?? 0;
  }

  @override
  Path getClip(Size size) {
    // button is the floating action button's bounding rectangle in the
    // coordinate system whose origin is at the appBar's top left corner,
    // or null if there is no floating action button.
    final Rect? button = geometry.value.floatingActionButtonArea?.translate(0.0, bottomNavigationBarTop * -1.0);
    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(_CustomBottomAppBarClipper oldClipper) {
    return oldClipper.geometry != geometry
        || oldClipper.shape != shape
        || oldClipper.notchMargin != notchMargin;
  }
}