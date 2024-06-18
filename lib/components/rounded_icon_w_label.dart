import "package:flutter/material.dart";

class RoundedIconWLabel extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Color? color;

  const RoundedIconWLabel({super.key, required this.color, required this.label, required this.iconData});

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          Text(
            label,
            softWrap: true,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
          ),
        ],
      ),
    );
  }
}
