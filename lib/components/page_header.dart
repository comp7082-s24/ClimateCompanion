import "package:flutter/material.dart";

class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(final BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).primaryTextTheme.titleLarge,
    );
  }
}
