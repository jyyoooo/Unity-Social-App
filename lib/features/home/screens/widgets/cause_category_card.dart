// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CauseCard extends StatefulWidget {
  const CauseCard({
    Key? key,
    required this.sizer,
    required this.image,
    required this.title,
    required this.color,
    this.scale = 2.3,
    required this.onTap,
  }) : super(key: key);

  final Size sizer;
  final String image;
  final String title;
  final Color color;
  final double scale;
  final VoidCallback onTap;

  @override
  State<CauseCard> createState() => _CauseCardState();
}

class _CauseCardState extends State<CauseCard> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (_) => setState(() {
        isPressed = !isPressed;
      }),
      onTapCancel: () => setState(() {
        isPressed = !isPressed;
      }),
      child: SizedBox(
        height: widget.sizer.height / 4.2,
        width: widget.sizer.width / 4.2,
        child: AnimatedContainer(
          transformAlignment: Alignment.center,
          duration: const Duration(milliseconds: 250),
          transform: isPressed
              ? Matrix4.identity().scaled(.98, .98)
              : Matrix4.identity(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      widget.color.withOpacity(.8),
                      widget.color.withOpacity(.9),
                      widget.color,
                      widget.color
                    ])),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                overlayColor: MaterialStatePropertyAll(
                    CupertinoColors.extraLightBackgroundGray.withOpacity(.97)),
                enableFeedback: true,
                splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
                splashColor: Colors.transparent,
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onTap: widget.onTap,
                child: iconAndTitle(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column iconAndTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: AnimatedContainer(
              curve: Curves.linear,
              duration: const Duration(milliseconds: 250),
              transformAlignment: Alignment.center,
              transform: isPressed
                  ? Matrix4.identity().scaled(1.6, 1.6)
                  : Matrix4.identity(),
              child: Image.asset(
                widget.image,
                scale: widget.scale,
                color: Colors.black,
              )),
        ),
        Flexible(
          flex: 1,
          child: Hero(
            transitionOnUserGestures: true,
            tag: widget.title,
            child: Text(widget.title,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: isPressed ? FontWeight.bold : FontWeight.normal,
                    color: Colors.black)),
          ),
        ),
      ],
    );
  }
}
