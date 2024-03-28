library d_navigation_bar;
import 'package:flutter/material.dart';

/// default controller
DNavigationBarController _defaultController = DNavigationBarController();

// ignore: must_be_immutable
class DNavigationBar extends StatelessWidget {
  final List<DNavigationBarItem> items;
  final void Function(int index)? onChanged;
  final MainAxisAlignment? mainAxisAlignment;
  final Color backgroundColor;
  final bool useShadow;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry borderRadius;
  final double height;
  final Decoration? decoration;
  DNavigationBarController? controller;

  DNavigationBar({
    super.key,
    required this.items,
    this.controller,
    this.onChanged,
    this.mainAxisAlignment,
    this.backgroundColor = Colors.white,
    this.useShadow = true,
    this.padding,
    this.borderRadius = BorderRadius.zero,
    this.height = 60.0,
    this.decoration
  }){
    controller ??= _defaultController;
    for(int i=0; i<items.length; i++){
      items[i]._controller = controller!;
      items[i]._index = i;
      items[i]._onChanged = onChanged;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: height,
      color: Colors.transparent,
      elevation: 0,
      padding: padding ?? const EdgeInsets.all(0),
      child: Container(
        decoration: decoration ?? BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
            boxShadow: useShadow ? const [
              BoxShadow(
                color: Colors.grey,
                blurStyle: BlurStyle.outer,
                blurRadius: 2,
              )
            ] : null
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceEvenly,
          children: items,
        ),
      ),
    );
  }
}


// ignore: must_be_immutable
class DNavigationBarItem extends StatefulWidget  {
  final Widget icon;
  final String? label;
  final Widget? activeIcon;
  final TextStyle labelStyle;
  final TextStyle activeLabelStyle;
  final double iconLabelSpacing;
  final Color highlightColor;
  final void Function()? onPressed;

  void Function(int index)? _onChanged;
  late DNavigationBarController _controller;
  int _index = 0;

  DNavigationBarItem({
    super.key,
    required this.icon,
    this.label,
    this.activeIcon,
    this.labelStyle = const TextStyle(fontSize: 10),
    this.activeLabelStyle = const TextStyle(fontSize: 10),
    this.iconLabelSpacing = 3.0,
    this.highlightColor = Colors.transparent,
    this.onPressed
  });

  @override
  State<DNavigationBarItem> createState() => _DNavigationBarItemState();
}

class _DNavigationBarItemState extends State<DNavigationBarItem> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        widget._controller.currentIndex = widget._index;
        if(widget._onChanged != null) widget._onChanged!(widget._controller.currentIndex);
        if(widget.onPressed != null) widget.onPressed!();
        setState(() {});
      },
      highlightColor: widget.highlightColor,
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget._controller.currentIndex == widget._index && widget.activeIcon != null
              ? widget.activeIcon! : widget.icon,
          if(widget.label != null) SizedBox(height: widget.iconLabelSpacing),
          if(widget.label != null)
            Text(
                widget.label!,
                style: widget._controller.currentIndex == widget._index ? widget.activeLabelStyle : widget.labelStyle
            )
        ],
      ),
    );
  }
}

/// DNavigationBarController
class DNavigationBarController {
  int currentIndex;
  List<Widget> pages;
  List<PreferredSizeWidget> appBars;

  DNavigationBarController({
    this.currentIndex = 0,
    this.pages = const [],
    this.appBars = const []
  });

  Widget get page {
    try{
      return pages[currentIndex];
    } catch(e){
      return Center(child: Text(e.toString()));
    }
  }

  PreferredSizeWidget get appBar {
    try{
      return appBars[currentIndex];
    } catch(e){
      return AppBar(title: Text(e.toString()), backgroundColor: Colors.red);
    }
  }
}
