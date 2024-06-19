import "package:flutter/material.dart";

class RoundedIconWLabel extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Color? color;

  const RoundedIconWLabel({super.key, required this.color, required this.label, required this.iconData});

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Text(
            label,
            softWrap: true,
            style: Theme.of(context).primaryTextTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}
