import 'package:flutter/material.dart';

class DNavigationBar extends StatelessWidget {
  final List<DNavigationBarItem> items;
  final void Function(int index)? onChanged;
  DNavigationBarController? controller;

  DNavigationBar({
    super.key,
    required this.items,
    this.controller,
    this.onChanged
  }){
    controller ??= _defaultController;
    for(int i=0; i<items.length; i++){
      items[i]._controller = controller!;
      items[i]._index = i;
      items[i].onChanged = onChanged;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      color: Colors.transparent,
      elevation: 0,
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurStyle: BlurStyle.outer,
                blurRadius: 2,
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items,
        ),
      ),
    );
  }
}



class DNavigationBarItem extends StatefulWidget  {
  final Widget icon;
  final String label;
  final Widget? selectedIcon;

  void Function(int index)? onChanged;
  late DNavigationBarController _controller;
  int _index = 0;

  DNavigationBarItem({
    super.key,
    required this.icon,
    required this.label,
    this.selectedIcon
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
        if(widget.onChanged != null) widget.onChanged!(widget._controller.currentIndex);
        setState(() {});
      },
      highlightColor: Colors.transparent,
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget._controller.currentIndex == widget._index && widget.selectedIcon != null
              ? widget.selectedIcon! : widget.icon,
          const SizedBox(height: 3),
          Text(widget.label, style: const TextStyle(fontSize: 10))
        ],
      ),
    );
  }
}

DNavigationBarController _defaultController = DNavigationBarController();

class DNavigationBarController {
  int currentIndex = 0;
  List<Widget> pages = [];
  List<PreferredSizeWidget> appBars = [];
  Widget get page => pages[currentIndex];
  PreferredSizeWidget get appBar => appBars[currentIndex];
}
