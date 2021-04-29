import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgWidget extends StatefulWidget {
  final double width;
  final double height;
  final String imgPath;
  final Color color;
  final bool allowDrawingOutsideViewBox;
  SvgWidget(
      {this.imgPath,
      this.color,
      this.height,
      this.width,
      this.allowDrawingOutsideViewBox});

  @override
  _SvgWidgetState createState() => _SvgWidgetState();
}

class _SvgWidgetState extends State<SvgWidget> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      widget.imgPath,
      height: widget.height,
      width: widget.width,
      color: widget.color,
      allowDrawingOutsideViewBox:
          widget.allowDrawingOutsideViewBox ? true : false,
    );
  }
}
