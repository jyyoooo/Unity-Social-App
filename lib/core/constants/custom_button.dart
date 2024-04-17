import 'package:flutter/material.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    this.label,
    this.onPressed,
    this.width = 200,
    this.height = 44,
    this.padding = const EdgeInsets.all(5),
    this.color,
    this.labelColor,
    this.borderRadius = 12,
    this.loading = false,
  }) : super(key: key);

  final String? label;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? labelColor;
  final double borderRadius;
  final bool loading;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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
        widget.onPressed?.call();
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: Center(
        child: AnimatedContainer(transformAlignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          transform: _isTapped ? Matrix4.identity().scaled(.98, .98) : Matrix4.identity().absolute(),
          child: Padding(
            padding: widget.padding,
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(widget.width!, widget.height!)),
                backgroundColor: MaterialStateProperty.all(widget.color ?? buttonGreen),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                )),
              ),
              onPressed: widget.loading ? null : widget.onPressed,
              child: widget.loading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1.5,
                    )
                  : Text(
                      widget.label ?? '',
                      style: TextStyle(
                        color: widget.labelColor ?? Colors.white,
                        fontSize: 15,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
