import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TileItem extends StatefulWidget {
  const TileItem(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.icon,
      this.destructive = false})
      : super(key: key);

  final String title;
  final VoidCallback onTap;
  final Widget icon;
  final bool destructive;

  @override
  TileItemState createState() => TileItemState();
}

class TileItemState extends State<TileItem> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        duration: const Duration(milliseconds: 50),
        transform:
            _isTapped ? Matrix4.identity().scaled(.98) : Matrix4.identity(),
        child: ListTile(
          trailing: !widget.destructive
              ? const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Colors.grey,
                  ),
                )
              : const SizedBox.shrink(),
          enableFeedback: true,
          tileColor: CupertinoColors.lightBackgroundGray.withOpacity(.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          leading: widget.icon,
          title: Text(
            widget.title,
            style: TextStyle(
                color: widget.destructive
                    ? CupertinoColors.destructiveRed
                    : Colors.black),
          ),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
