import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

// Used in Weather_View
Container roundedContainer({
  required final Widget child,
  required final double height,
  required final double width,
  required final Color color,
  final EdgeInsets margin = EdgeInsets.zero,

}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          blurRadius: 6,
          offset: Offset(6, 6),
          color: Colors.black26,
        ),
      ],
    ),
    height: height,
    width: width,
    child: child
  );
}
